part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class TasksSubscriptionRequested extends TasksEvent {
  const TasksSubscriptionRequested();
}

class TaskAdded extends TasksEvent {
  const TaskAdded(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class TaskDeleted extends TasksEvent {
  const TaskDeleted(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

class TaskCompletionToggled extends TasksEvent {
  const TaskCompletionToggled({
    required this.task,
    required this.isCompleted,
  });

  final Task task;
  final bool isCompleted;

  @override
  List<Object> get props => [task, isCompleted];
}

class TaskFilterChanged extends TasksEvent {
  const TaskFilterChanged(this.filter);

  final TaskFilter filter;

  @override
  List<Object> get props => [filter];
}
