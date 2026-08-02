import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widget/taskStatus_Bycount.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _State();
}

class _State extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 88,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,

                itemBuilder: (context, index) {
                  return TaskCountByStatus(title: "new", count: 30);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 28);
                },
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "Task $index",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                    ),
                  ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task descriptionTask descriptionTask descriptionTask descriptionTask descriptionTask description",
                      ),

                      Text("23-33-3333"),
                      Row(
                        children: [
                          Chip(
                            label: Text("New"),
                            backgroundColor: Colors.blue,

                            labelStyle: TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit_note,color: Colors.green,),
                          ),

                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete,color: Colors.red,),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
