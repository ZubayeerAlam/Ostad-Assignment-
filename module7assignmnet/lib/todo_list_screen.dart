import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'todo_card.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> tasks = [
      const TodoCard(
        id: '01',
        title: 'Market Research',
        time: '10:00 AM (10 minutes ago)',
        status: 'Done',
        iconColor: Color(0xFFE91E63),
        icon: Icons.shopping_bag_outlined,
      ),
      const TodoCard(
        id: '02',
        title: 'Competitive Analysis',
        time: '12:00 PM',
        status: 'In Progress',
        iconColor: Color(0xFFE91E63),
        icon: Icons.shopping_bag_outlined,
      ),
      const TodoCard(
        id: '03',
        title: 'Create Low-fidelity Wireframe',
        time: '07:00 PM',
        status: 'To-do',
        iconColor: Color(0xFF7C4DFF),
        icon: Icons.blur_circular_outlined,
      ),
      const TodoCard(
        id: '04',
        title: 'How to pitch a Design Sprint',
        time: '09:00 PM',
        status: 'To-do',
        iconColor: Color(0xFFFF9800),
        icon: Icons.book_outlined,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'To-Do List',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: [
                    for (final task in tasks) task,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
        },
        backgroundColor: const Color(0xFF7C4DFF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}