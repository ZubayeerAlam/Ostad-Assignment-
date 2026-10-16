# Task Manager App (Provider)

A Flutter task manager that demonstrates Provider state management.

## Features
- Task list (title, description, completion status) built with `ListView.builder`
- Add tasks from a separate screen via the `FloatingActionButton`
- Mark tasks as completed or incomplete with a `Checkbox`
- Delete tasks (with a confirmation dialog)
- Live statistics: total, completed, and pending tasks
- Empty-state view when there are no tasks

## State management
- `Task` model: `lib/models/task.dart`
- `TaskProvider extends ChangeNotifier`, which calls `notifyListeners()`: `lib/providers/task_provider.dart`
- `ChangeNotifierProvider` at the root: `lib/main.dart`
- `Consumer<TaskProvider>` renders the task list; `context.watch()` renders the statistics
- `context.read()` handles add, toggle, and delete actions
- `setState()` is not used anywhere

## Project structure
```
lib/
├── main.dart
├── models/task.dart
├── providers/task_provider.dart
├── screens/
│   ├── task_list_screen.dart
│   └── add_task_screen.dart
└── widgets/
    ├── task_tile.dart
    ├── task_statistics.dart
    └── empty_task_view.dart
```

## Run
```
flutter pub get
flutter run
```
