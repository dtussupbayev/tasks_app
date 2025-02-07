import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/src/features/tasks/data/models/task.dart';
import 'package:tasks_app/src/features/tasks/data/repositories/tasks_repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc({
    required ITasksRepository tasksRepository,
  })  : _tasksRepository = tasksRepository,
        super(const TasksState()) {
    on<TasksSubscriptionRequested>(_onSubscriptionRequested);
    on<TaskAdded>(_onTaskAdded);
    on<TaskDeleted>(_onTaskDeleted);
    on<TaskCompletionToggled>(_onTaskCompletionToggled);
    on<TaskFilterChanged>(_onFilterChanged);
  }

  final ITasksRepository _tasksRepository;

  Future<void> _onSubscriptionRequested(
    TasksSubscriptionRequested event,
    Emitter<TasksState> emit,
  ) async {
    emit(state.copyWith(status: TasksStatus.loading));
    await emit.forEach<List<Task>>(
      _tasksRepository.getTasks(),
      onData: (newTasks) => state.copyWith(
        status: TasksStatus.success,
        tasks: newTasks,
      ),
      onError: (_, __) => state.copyWith(
        status: TasksStatus.failure,
      ),
    );
  }

  Future<void> _onTaskAdded(
    TaskAdded event,
    Emitter<TasksState> emit,
  ) async {
    try {
      final task = Task(
        title: event.title.trim(),
        isCompleted: false,
      );
      await _tasksRepository.saveTask(task);
    } catch (_) {
      emit(state.copyWith(status: TasksStatus.failure));
    }
  }

  Future<void> _onTaskDeleted(
    TaskDeleted event,
    Emitter<TasksState> emit,
  ) async {
    try {
      await _tasksRepository.deleteTask(event.task.id);
    } catch (_) {
      emit(state.copyWith(status: TasksStatus.failure));
    }
  }

  Future<void> _onTaskCompletionToggled(
    TaskCompletionToggled event,
    Emitter<TasksState> emit,
  ) async {
    try {
      final updatedTask = event.task.copyWith(isCompleted: event.isCompleted);
      await _tasksRepository.saveTask(updatedTask);
    } catch (_) {
      emit(state.copyWith(status: TasksStatus.failure));
    }
  }

  void _onFilterChanged(
    TaskFilterChanged event,
    Emitter<TasksState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }
}
