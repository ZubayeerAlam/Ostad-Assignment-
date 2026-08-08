// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../Data/Model/Api_response.dart';
// import '../Data/Model/task_model.dart';
// import '../Data/Model/task_status_count_model.dart';
// import '../Data/Service/Api_Caller.dart';
// import '../Utils/Urls.dart';
// import '../Widget/taskCard.dart';
//
// class CategoriesScreen extends StatefulWidget {
//   const CategoriesScreen({super.key});
//
//   @override
//   State<CategoriesScreen> createState() => _CategoriesScreenState();
// }
//
// class _CategoriesScreenState extends State<CategoriesScreen> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getAllTask();
//   }
//
//   List<TaskModel>tasks = [];
//
//
//   Future<void> getAllTask() async {
//     final ApiResponse response = await ApiCaller.getRequest(url: urls.getTaskByStatusURL('New'));
//     final ApiResponse responsePending = await ApiCaller.getRequest(url: urls.getTaskByStatusURL('Pending'));
//     final ApiResponse responseInProgress = await ApiCaller.getRequest(url: urls.getTaskByStatusURL('In Progress'));
//     final ApiResponse responseCompleted = await ApiCaller.getRequest(url: urls.getTaskByStatusURL('Completed'));
//
//     List<TaskModel> allTask = [];
//     List<TaskModel> pendingTask = [];
//     List<TaskModel> inProgressTask = [];
//     List<TaskModel> completedTask = [];
//
//
//     if(response.isSuccess){
//       for(Map<String , dynamic>jsonData in (response.responseData['data'])){
//         allTask.add(TaskModel.fromJson(jsonData));
//       }
//
//
//       for(Map<String , dynamic>jsonData in (responsePending.responseData['data'])){
//         allTask.add(TaskModel.fromJson(jsonData));
//         pendingTask.add(TaskModel.fromJson(jsonData));
//       }
//
//
//       for(Map<String , dynamic>jsonData in (responseInProgress.responseData['data'])){
//         allTask.add(TaskModel.fromJson(jsonData));
//         inProgressTask.add(TaskModel.fromJson(jsonData));
//       }
//
//
//       for(Map<String , dynamic>jsonData in (responseCompleted.responseData['data'])){
//         allTask.add(TaskModel.fromJson(jsonData));
//         completedTask.add(TaskModel.fromJson(jsonData));
//       }
//     }else{
//       ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(content: Text(jsonDecode(response.responseData['data']))));
//
//     }
//
//
//     setState(() {
//       tasks = allTask;
//
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     List<String> statusOrder = [
//       'All task',
//       'Pending',
//       'In Progress',
//       'Completed'
//     ];
//
//     return Scaffold(
//       body: Column(
//         children: [
//
//           SizedBox(
//             height: 42,
//             child: Expanded(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: statusOrder.length,
//                       itemBuilder: (context, index) {
//                         final status = statusOrder[index];
//                         final bool isSelected = selectedStatus == status;
//
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedStatus = status;
//                             });
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
//                             child: Text(status),
//                           ),
//                         );
//
//                       },
//                     ),
//                   ),
//                 ]
//               ),
//             ),
//           ),
//
//
//           Expanded(
//             child: ListView.builder(
//               itemCount: tasks.length,
//               itemBuilder: (context, index) {
//                 return TaskCard(
//                   taskModel: tasks[index],
//                   cardColor: Colors.blue,
//                   refresh: () async {
//                     await getAllTask();
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../Data/Model/task_model.dart';
import '../Data/Service/Api_Caller.dart';
import '../Utils/Urls.dart';
import '../Widget/taskCard.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    getAllTask();
  }

  List<TaskModel> allTask = [];
  List<TaskModel> newTask = [];
  List<TaskModel> pendingTask = [];
  List<TaskModel> inProgressTask = [];
  List<TaskModel> completedTask = [];

  final List<String> statusOrder = [
    'All',
    'New',
    'Pending',
    'In Progress',
    'Completed',
  ];

  String selectedStatus = 'All';

  Future<void> getAllTask() async {
    setState(() {
    });

    final responseNew = await ApiCaller.getRequest(
      url: urls.getTaskByStatusURL('New'),
    );
    final responsePending = await ApiCaller.getRequest(
      url: urls.getTaskByStatusURL('Pending'),
    );
    final responseInProgress = await ApiCaller.getRequest(
      url: urls.getTaskByStatusURL('In Progress'),
    );
    final responseCompleted = await ApiCaller.getRequest(
      url: urls.getTaskByStatusURL('Completed'),
    );

    List<TaskModel> tempAll = [];
    List<TaskModel> tempNew = [];
    List<TaskModel> tempPending = [];
    List<TaskModel> tempInProgress = [];
    List<TaskModel> tempCompleted = [];


    if (responseNew.isSuccess) {
      for (Map<String, dynamic> jsonData
          in (responseNew.responseData['data'])) {
        final task = TaskModel.fromJson(jsonData);
        tempAll.add(task);
        tempNew.add(task);
      }
    }

    if (responsePending.isSuccess) {
      for (Map<String, dynamic> jsonData
          in (responsePending.responseData['data'])) {
        final task = TaskModel.fromJson(jsonData);
        tempAll.add(task);
        tempPending.add(task);
      }
    }

    if (responseInProgress.isSuccess) {
      for (Map<String, dynamic> jsonData
          in (responseInProgress.responseData['data'])) {
        final task = TaskModel.fromJson(jsonData);
        tempAll.add(task);
        tempInProgress.add(task);
      }
    }

    if (responseCompleted.isSuccess) {
      for (Map<String, dynamic> jsonData
          in (responseCompleted.responseData['data'])) {
        final task = TaskModel.fromJson(jsonData);
        tempAll.add(task);
        tempCompleted.add(task);
      }
    }

    setState(() {
      allTask = tempAll;
      newTask = tempNew;
      pendingTask = tempPending;
      inProgressTask = tempInProgress;
      completedTask = tempCompleted;
    });
  }

  List<TaskModel> get filteredTasks {
    switch (selectedStatus) {
      case 'New':
        return newTask;
      case 'Pending':
        return pendingTask;
      case 'In Progress':
        return inProgressTask;
      case 'Completed':
        return completedTask;
      case 'All':
      default:
        return allTask;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: statusOrder.length,
              itemBuilder: (context, index) {
                final status = statusOrder[index];
                final bool isSelected = selectedStatus == status;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedStatus = status;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? Colors.green : Colors.grey.shade700,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: filteredTasks.isEmpty ? const Center(
                child: Text('No tasks found')
            ) : RefreshIndicator(
                    onRefresh: getAllTask,
                    child: ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskModel: filteredTasks[index],
                          cardColor: filteredTasks[index].status == 'New'
                            ? Colors.blue
                                : filteredTasks[index].status == 'Pending'
                        ? Colors.orange
                            : filteredTasks[index].status == 'In Progress'
                            ? Colors.purple
                                : filteredTasks[index].status == 'Completed'
                        ? Colors.green
                            : Colors.grey,
                          refresh: () async {
                            await getAllTask();
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
