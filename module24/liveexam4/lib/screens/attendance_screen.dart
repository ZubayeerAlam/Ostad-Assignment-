import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/attendance_provider.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Attendance Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: const Column(
        children: [
          _StatisticsSection(),
          Expanded(child: _StudentList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const _AddStudentDialog(),
        ),
        tooltip: 'Add Student',
        child: const Icon(Icons.person_add),
      ),
    );
  }
}

class _StatisticsSection extends StatelessWidget {
  const _StatisticsSection();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AttendanceProvider>();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          _StatCard(
            label: 'Total',
            value: provider.totalStudents,
            color: Colors.indigo,
          ),
          _StatCard(
            label: 'Present',
            value: provider.presentCount,
            color: Colors.green,
          ),
          _StatCard(
            label: 'Absent',
            value: provider.absentCount,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: color.withValues(alpha: 0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Text(
                '$value',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class _StudentList extends StatelessWidget {
  const _StudentList();

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceProvider>(
      builder: (context, provider, _) {
        final students = provider.students;

        if (students.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.people_outline, size: 64, color: Colors.grey),
                SizedBox(height: 12),
                Text(
                  'No students yet.\nTap + to add a student.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: ListTile(
                leading: Checkbox(
                  value: student.isPresent,
                  onChanged: (value) => context
                      .read<AttendanceProvider>()
                      .toggleAttendance(student.id, value ?? false),
                ),
                title: Text(student.name),
                subtitle: Text(
                  student.isPresent ? 'Present' : 'Absent',
                  style: TextStyle(
                    color: student.isPresent ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Delete',
                  onPressed: () => context
                      .read<AttendanceProvider>()
                      .removeStudent(student.id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _AddStudentDialog extends StatefulWidget {
  const _AddStudentDialog();

  @override
  State<_AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<_AddStudentDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AttendanceProvider>().addStudent(_controller.text);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Student'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Student name',
            border: OutlineInputBorder(),
          ),
          validator: (value) => (value == null || value.trim().isEmpty)
              ? 'Student name cannot be empty'
              : null,
          onFieldSubmitted: (_) => _submit(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Add')),
      ],
    );
  }
}
