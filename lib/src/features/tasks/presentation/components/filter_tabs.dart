import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/src/features/tasks/presentation/bloc/tasks_bloc.dart';

class FilterTabs extends StatelessWidget {
  const FilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      buildWhen: (previous, current) => previous.filter != current.filter,
      builder: (context, state) {
        return Container(
          height: 48,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            children: [
              _FilterChip(
                label: 'Все',
                selected: state.filter == TaskFilter.all,
                onSelected: (_) => context
                    .read<TasksBloc>()
                    .add(const TaskFilterChanged(TaskFilter.all)),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Выполненные',
                selected: state.filter == TaskFilter.completed,
                onSelected: (_) => context
                    .read<TasksBloc>()
                    .add(const TaskFilterChanged(TaskFilter.completed)),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Невыполненные',
                selected: state.filter == TaskFilter.active,
                onSelected: (_) => context
                    .read<TasksBloc>()
                    .add(const TaskFilterChanged(TaskFilter.active)),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.selected,
    required this.label,
    required this.onSelected,
  });

  final bool selected;
  final String label;
  final Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: theme.colorScheme.primary.withValues(alpha: 0.2),
      showCheckmark: false,
      labelStyle: TextStyle(
        color:
            selected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
