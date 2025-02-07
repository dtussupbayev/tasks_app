part of 'tasks_bloc.dart';

enum TaskFilter { all, completed, active }

enum TasksStatus { initial, loading, success, failure }

class TasksState extends Equatable {
  const TasksState({
    this.status = TasksStatus.initial,
    this.tasks = const [],
    this.filter = TaskFilter.all,
  });

  final TasksStatus status;
  final List<Task> tasks;
  final TaskFilter filter;

  List<Task> get filteredTasks {
    switch (filter) {
      case TaskFilter.completed:
        return tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.active:
        return tasks.where((task) => !task.isCompleted).toList();
      case TaskFilter.all:
        return tasks;
    }
  }

  @override
  List<Object?> get props => [
        status,
        tasks,
        filter,
      ];

  TasksState copyWith({
    TasksStatus? status,
    List<Task>? tasks,
    TaskFilter? filter,
  }) {
    return TasksState(
      status: status ?? this.status,
      tasks:
          tasks != null ? List<Task>.from(tasks) : List<Task>.from(this.tasks),
      filter: filter ?? this.filter,
    );
  }
}
