import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/src/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:tasks_app/src/features/tasks/presentation/components/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state.tasks.isEmpty) {
          if (state.status == TasksStatus.loading) {
            return const Center(
              child: CupertinoActivityIndicator(radius: 12),
            );
          } else if (state.status == TasksStatus.success) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt,
                    size: 48,
                    color: theme.colorScheme.primary.withValues(alpha: 0.8),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Нет задач',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            );
          }
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: state.filteredTasks.length,
          itemBuilder: (context, index) {
            final task = state.filteredTasks[index];
            return TaskTile(
              task: task,
              onToggleCompleted: (isCompleted) {
                context.read<TasksBloc>().add(
                      TaskCompletionToggled(
                        task: task,
                        isCompleted: isCompleted,
                      ),
                    );
              },
              onDeleteTapped: () {
                context.read<TasksBloc>().add(TaskDeleted(task));
              },
            );
          },
        );
      },
    );
  }
}
