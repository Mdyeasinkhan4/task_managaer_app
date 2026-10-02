import 'package:flutter_test/flutter_test.dart';
import 'package:task_managaer_app/providers/task_provider.dart';

void main() {
  group('TaskProvider Unit Tests', () {
    late TaskProvider taskProvider;

    setUp(() {
      taskProvider = TaskProvider();
    });

    test('Initial tasks statistics are calculated correctly', () {
      expect(taskProvider.totalTasks, equals(3));
      expect(taskProvider.completedTasks, equals(1));
      expect(taskProvider.pendingTasks, equals(2));
    });

    test('addTask increases totalTasks and pendingTasks', () {
      taskProvider.addTask('New Test Task', 'Test Description');

      expect(taskProvider.totalTasks, equals(4));
      expect(taskProvider.pendingTasks, equals(3));
      expect(taskProvider.completedTasks, equals(1));
      expect(taskProvider.tasks.first.title, equals('New Test Task'));
      expect(taskProvider.tasks.first.description, equals('Test Description'));
      expect(taskProvider.tasks.first.isCompleted, isFalse);
    });

    test('toggleTask changes task completion status and updates statistics',
        () {
      final initialPending = taskProvider.pendingTasks;
      final initialCompleted = taskProvider.completedTasks;
      final taskId = taskProvider.tasks.firstWhere((t) => !t.isCompleted).id;

      taskProvider.toggleTask(taskId);

      expect(taskProvider.pendingTasks, equals(initialPending - 1));
      expect(taskProvider.completedTasks, equals(initialCompleted + 1));
    });

    test('deleteTask removes task and updates statistics', () {
      final initialTotal = taskProvider.totalTasks;
      final taskToDelete = taskProvider.tasks.first;

      taskProvider.deleteTask(taskToDelete.id);

      expect(taskProvider.totalTasks, equals(initialTotal - 1));
      expect(
        taskProvider.tasks.any((t) => t.id == taskToDelete.id),
        isFalse,
      );
    });
  });
}
