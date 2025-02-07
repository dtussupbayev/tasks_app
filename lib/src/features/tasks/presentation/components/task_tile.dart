import 'package:flutter/material.dart';
import 'package:tasks_app/src/features/tasks/data/models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    required this.task,
    super.key,
    this.onToggleCompleted,
    this.onDeleteTapped,
  });

  final Task task;
  final ValueChanged<bool>? onToggleCompleted;
  final VoidCallback? onDeleteTapped;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: Key('task_${task.id}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDeleteTapped?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          title: Text(
            task.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: task.isCompleted
                ? theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    decoration: TextDecoration.lineThrough,
                  )
                : theme.textTheme.bodyLarge,
          ),
          leading: Transform.scale(
            scale: 1.2,
            child: Checkbox(
              shape: const CircleBorder(),
              value: task.isCompleted,
              onChanged: onToggleCompleted == null
                  ? null
                  : (value) => onToggleCompleted!(value!),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: theme.colorScheme.error,
            ),
            onPressed: onDeleteTapped,
          ),
        ),
      ),
    );
  }
}
