import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

/// [TaskCard] displays individual task details and provides interactive controls.
/// Uses [context.read<TaskProvider>()] for executing actions like toggle and delete.
class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete Task'),
          ],
        ),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              // Delete action using context.read()
              context.read<TaskProvider>().deleteTask(task.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Task deleted successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = task.isCompleted;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      elevation: isCompleted ? 1 : 3,
      color: isCompleted
          ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
          : theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isCompleted
              ? Colors.green.withValues(alpha: 0.3)
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox for toggling task state
            Checkbox(
              value: isCompleted,
              activeColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: (_) {
                // Toggle action using context.read()
                context.read<TaskProvider>().toggleTask(task.id);
              },
            ),
            const SizedBox(width: 8),

            // Task Title & Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    task.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: isCompleted
                          ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  if (task.description.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      task.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isCompleted
                            ? theme.colorScheme.onSurface.withValues(alpha: 0.4)
                            : theme.colorScheme.onSurfaceVariant,
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  // Status Badge Chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Colors.green.withValues(alpha: 0.1)
                          : Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isCompleted ? 'Completed' : 'Pending',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isCompleted ? Colors.green : Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Delete Action Button
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              tooltip: 'Delete Task',
              onPressed: () => _showDeleteConfirmation(context),
            ),
          ],
        ),
      ),
    );
  }
}
