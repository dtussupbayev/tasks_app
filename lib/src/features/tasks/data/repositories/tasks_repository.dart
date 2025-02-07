import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/src/features/tasks/data/models/task.dart';

abstract class ITasksRepository {
  Stream<List<Task>> getTasks();
  Future<void> saveTask(Task task);
  Future<void> deleteTask(String id);
}

class LocalTasksRepository implements ITasksRepository {
  LocalTasksRepository({
    required SharedPreferences prefs,
  }) : _prefs = prefs {
    _init();
  }

  final SharedPreferences _prefs;

  late final StreamController<List<Task>> _taskStreamController =
      StreamController<List<Task>>.broadcast(
    onListen: () {
      _taskStreamController.add(_tasks);
    },
  );

  List<Task> _tasks = [];

  static const _kTasksCollectionKey = 'tasks_collection_key';

  String? _getValue(String key) => _prefs.getString(key);

  Future<void> _setValue(String key, String value) =>
      _prefs.setString(key, value);

  void _init() {
    try {
      final tasksJson = _getValue(_kTasksCollectionKey);
      if (tasksJson != null) {
        _tasks = List<Map<String, dynamic>>.from(
          json.decode(tasksJson) as List,
        ).map(Task.fromJson).toList();
      }
      _taskStreamController.add(_tasks);
    } on FormatException catch (e) {
      _tasks = [];
      _taskStreamController.addError('Failed to load tasks: ${e.message}');
    }
  }

  @override
  Stream<List<Task>> getTasks() => _taskStreamController.stream;

  @override
  Future<void> saveTask(Task task) async {
    final taskIndex = _tasks.indexWhere((t) => t.id == task.id);
    if (taskIndex >= 0) {
      _tasks[taskIndex] = task;
    } else {
      _tasks.add(task);
    }

    _taskStreamController.add(_tasks);
    await _setValue(_kTasksCollectionKey, json.encode(_tasks));
  }

  @override
  Future<void> deleteTask(String id) async {
    final taskIndex = _tasks.indexWhere((t) => t.id == id);
    if (taskIndex >= 0) {
      _tasks.removeAt(taskIndex);
      _taskStreamController.add(_tasks);
      await _setValue(_kTasksCollectionKey, json.encode(_tasks));
    }
  }

  Future<void> close() async {
    await _taskStreamController.close();
  }
}
