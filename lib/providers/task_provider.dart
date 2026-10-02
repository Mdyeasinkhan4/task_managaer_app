import 'package:flutter/foundation.dart';
import '../models/task.dart';

/// [TaskProvider] manages the global task state for the application.
/// It extends [ChangeNotifier] to allow reactive UI updates whenever state changes.
class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Complete Flutter Assignment',
      description: 'Implement Provider state management for Task Manager app.',
      isCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Task(
      id: '2',
      title: 'Review Provider Documentation',
      description: 'Understand ChangeNotifier, Consumer, watch, and read.',
      isCompleted: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Task(
      id: '3',
      title: 'Prepare Project Presentation',
      description: 'Create slides showcasing the task manager features.',
      isCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  /// Unmodifiable view of tasks list to prevent direct external modification.
  List<Task> get tasks => List.unmodifiable(_tasks);

  // Statistics Getters
  int get totalTasks => _tasks.length;

  int get completedTasks => _tasks.where((task) => task.isCompleted).length;

  int get pendingTasks => _tasks.where((task) => !task.isCompleted).length;

  /// Adds a new task to the list and notifies listeners.
  void addTask(String title, String description) {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      description: description.trim(),
      isCompleted: false,
    );
    _tasks.insert(0, newTask);
    notifyListeners();
  }

  /// Toggles the completion status of a task by ID and notifies listeners.
  void toggleTask(String taskId) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      final currentTask = _tasks[index];
      _tasks[index] = currentTask.copyWith(
        isCompleted: !currentTask.isCompleted,
      );
      notifyListeners();
    }
  }

  /// Removes a task from the list by ID and notifies listeners.
  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }
}
