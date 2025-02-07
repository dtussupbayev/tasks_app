import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasks_app/src/app/config/di.dart';
import 'package:tasks_app/src/features/tasks/presentation/bloc/tasks_bloc.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) => const AddTaskBottomSheet(),
    );
  }

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _taskTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _taskTitleController.dispose();
    super.dispose();
  }

  void _submitTask(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final taskTitle = _taskTitleController.text.trim();
      HapticFeedback.mediumImpact();
      getIt<TasksBloc>().add(TaskAdded(taskTitle));
      _taskTitleController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Новая задача',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _TaskInputField(
              controller: _taskTitleController,
              onSubmitted: (_) => _submitTask(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskInputField extends StatelessWidget {
  const _TaskInputField({
    required this.controller,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            autofocus: true,
            maxLines: null,
            maxLength: 100,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: onSubmitted,
            validator: (value) =>
                (value?.trim().isEmpty ?? true) ? 'Введите задачу' : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintText: 'Введите задачу...',
              counterText: '',
            ),
          ),
        ),
        const SizedBox(width: 12),
        _AddTaskButton(onPressed: () => onSubmitted?.call(controller.text)),
      ],
    );
  }
}

class _AddTaskButton extends StatelessWidget {
  const _AddTaskButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
