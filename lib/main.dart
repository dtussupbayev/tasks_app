import 'package:flutter/material.dart';
import 'package:tasks_app/src/app/config/di.dart';
import 'package:tasks_app/src/app/view/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const TasksApp());
}
