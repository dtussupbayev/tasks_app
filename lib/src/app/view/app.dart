import 'package:flutter/material.dart';
import 'package:tasks_app/src/features/tasks/presentation/screens/tasks_screen.dart';

class TasksApp extends StatelessWidget {
  const TasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TasksScreen(),
    );
  }
}
