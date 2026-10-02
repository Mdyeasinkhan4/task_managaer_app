import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

/// [TaskStatistics] displays real-time task count statistics.
/// Demonstrates the usage of [Consumer<TaskProvider>] for reactive rebuilding.
class TaskStatistics extends StatelessWidget {
  const TaskStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Total',
                  count: taskProvider.totalTasks,
                  icon: Icons.assignment_outlined,
                  color: Colors.blue,
                  backgroundColor: Colors.blue.shade50,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Completed',
                  count: taskProvider.completedTasks,
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                  backgroundColor: Colors.green.shade50,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Pending',
                  count: taskProvider.pendingTasks,
                  icon: Icons.pending_actions,
                  color: Colors.orange,
                  backgroundColor: Colors.orange.shade50,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const _StatCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
