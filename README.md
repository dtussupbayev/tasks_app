# Tasks App

Tasks App is a task management application developed with a focus on simplicity, clarity, and adherence to best practices. It uses BLoC for state management, GetIt for dependency injection, and SharedPreferences for local storage.

## Features
- Add, delete, and update tasks.
- Mark tasks complete/incomplete.
- Filter tasks by status (all, completed, active).
- Clean, responsive UI using Material Design.

## Project Structure
```
/lib
  /src
    /app
      config/        // Dependency injection and app configuration
      view/          // Main application view and routing
    /features
      /tasks
        data/       // Models and repositories (local storage)
        presentation/
          bloc/     // State management with BLoC
          components/ // UI components (e.g., task_tile, filter_tabs)
          screens/  // Screens (e.g., tasks_screen)
```

## Getting Started
1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd tasks_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## Dependencies
- Flutter
- BLoC
- Equatable
- GetIt
- SharedPreferences
- JsonSerializable