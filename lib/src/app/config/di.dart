import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/src/features/tasks/data/repositories/tasks_repository.dart';
import 'package:tasks_app/src/features/tasks/presentation/bloc/tasks_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<ITasksRepository>(
    () => LocalTasksRepository(prefs: prefs),
  );

  getIt.registerLazySingleton<TasksBloc>(
    () => TasksBloc(
      tasksRepository: getIt<ITasksRepository>(),
    ),
  );
}
