import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

class TaskStatistics extends StatelessWidget {
  const TaskStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          _StatCard(
            label: 'Total',
            count: taskProvider.totalTasks,
            icon: Icons.list_alt,
            color: Colors.indigo,
          ),
          const SizedBox(width: 8),
          _StatCard(
            label: 'Completed',
            count: taskProvider.completedTasks,
            icon: Icons.check_circle,
            color: Colors.green,
          ),
          const SizedBox(width: 8),
          _StatCard(
            label: 'Pending',
            count: taskProvider.pendingTasks,
            icon: Icons.pending_actions,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: color.withValues(alpha: 0.12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 6),
              Text(
                '$count',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(label, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
