import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';


import '../Data/Model/Api_response.dart';
import '../Data/Model/task_model.dart';
import '../Data/Model/task_status_count_model.dart';
import '../Data/Service/Api_Caller.dart';
import '../Utils/Urls.dart';
import '../Widget/taskStatus_Bycount.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _State();
}

class _State extends State<TaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTaskCount();
  }


  List<TaskStatusCountModel> taskCount = [];

  Future<void> getAllTaskCount() async {
    final ApiResponse response = await ApiCaller.getRequest(url: urls.getTaskCountURL);

    List<TaskStatusCountModel> taskC = [];

    if(response.isSuccess){
      for(Map<String , dynamic>jsonData in (response.responseData['data'])){
        taskC.add(TaskStatusCountModel.fromJson(jsonData));
      }

      taskC.removeWhere((e)=>e.sId == null);

    }else{
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text(response.responseData['data'])),
      );
    }
    setState(() {
      taskCount = taskC;
    });

  }


  List<TaskModel>tasks = [];

  Future<void> getAllTask() async {
    final ApiResponse response = await ApiCaller.getRequest(url: urls.getTaskByStatusURL('New'));

    List<TaskModel> task = [];


    if(response.isSuccess){
      for(Map<String , dynamic>jsonData in (response.responseData['data'])){
        task.add(TaskModel.fromJson(jsonData));
      }
    }else{
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(content: Text(jsonDecode(response.responseData['data']))));

    }


    setState(() {
      tasks = task;
    });

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
                    final status = statusOrder[index];

                    final task = taskCount.firstWhere((e)=>e.sId == status, orElse: ()=> TaskStatusCountModel(
                    sId: status,
                    sum: 0
                    ));
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