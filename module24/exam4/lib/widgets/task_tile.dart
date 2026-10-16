import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  Future<void> _confirmDelete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete == true && context.mounted) {
      context.read<TaskProvider>().deleteTask(task.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${task.title}" deleted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final completedStyle = task.isCompleted
        ? const TextStyle(
            decoration: TextDecoration.lineThrough,
            color: Colors.grey,
          )
        : null;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) =>
              context.read<TaskProvider>().toggleTaskStatus(task.id),
        ),
        title: Text(
          task.title,
          style: completedStyle?.copyWith(fontWeight: FontWeight.w600) ??
              const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description, style: completedStyle),
            const SizedBox(height: 4),
            Text(
              task.isCompleted ? 'Completed' : 'Incomplete',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: task.isCompleted ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          tooltip: 'Delete task',
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () => _confirmDelete(context),
        ),
      ),
    );
  }
}
