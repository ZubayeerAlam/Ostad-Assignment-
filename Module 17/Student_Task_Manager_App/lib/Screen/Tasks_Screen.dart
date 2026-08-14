import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Data/Model/task_status_count_model.dart';
import '../Widget/taskCard.dart';
import '../Widget/taskStatus_Bycount.dart';
import '../providers/task_provider.dart';
import 'Add_new_taskScreen.dart';


class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _State();
}

class _State extends State<TaskScreen> {
  // await getAllTask();
  // await getAllTaskCount();

  void initState() {
    super.initState();
    final taskProvider= Provider.of<TaskProvider>(context , listen: false);
    taskProvider.getAllTask();
    taskProvider.getAllTaskCount();
  }


  @override
  Widget build(BuildContext context) {
    List<String> statusOrder = [
      'All task',
      'Pending',
      'In Progress',
      'Completed'
    ];

    return Scaffold(
      body: Consumer<TaskProvider>(

        builder: (context, taskProvider, child) {
          if(taskProvider.isLoading){
             Center(child: CircularProgressIndicator());
          }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 88,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: statusOrder.length,

                  itemBuilder: (context, index) {
                      final status = statusOrder[index];

                      final task = status == "All task"
                          ? TaskStatusCountModel(
                        sId: "All task",
                        sum: taskProvider.tasks.length,
                      )
                          : taskProvider.taskCount.firstWhere(
                            (e) => e.sId == status,
                        orElse: () => TaskStatusCountModel(
                          sId: status,
                          sum: 0,
                        ),
                      );
                      return TaskCountByStatus(title: task.sId.toString(), count: task.sum ?? 0,);

                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 6);
                  },
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskModel: taskProvider.tasks[index],
                    cardColor: taskProvider.tasks[index].status == 'New'
                        ? Colors.blue
                        : taskProvider.tasks[index].status == 'Pending'
                        ? Colors.orange
                        : taskProvider.tasks[index].status == 'In Progress'
                        ? Colors.purple
                        : taskProvider.tasks[index].status == 'Completed'
                        ? Colors.green
                        : Colors.grey,
                    refresh: () async {
                     await taskProvider.getAllTask();
                     await taskProvider.getAllTaskCount();
                    },
                  );
                },
              ),
            ),
          ],
        );

        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTaskScreen()));
        },child: Icon(Icons.add) ,
      ),
    );
  }
}
