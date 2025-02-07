import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/src/app/config/di.dart';
import 'package:tasks_app/src/features/tasks/data/repositories/tasks_repository.dart';
import 'package:tasks_app/src/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:tasks_app/src/features/tasks/presentation/components/components.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(
        tasksRepository: getIt<ITasksRepository>(),
      )..add(const TasksSubscriptionRequested()),
      child: const TasksView(),
    );
  }
}

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Задачи',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TasksBloc, TasksState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == TasksStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: const Text('Произошла ошибка'),
                      backgroundColor: theme.colorScheme.error,
                    ),
                  );
              }
            },
          ),
        ],
        child: const Column(
          children: [
            FilterTabs(),
            Expanded(child: TasksList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddTaskBottomSheet.show(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
