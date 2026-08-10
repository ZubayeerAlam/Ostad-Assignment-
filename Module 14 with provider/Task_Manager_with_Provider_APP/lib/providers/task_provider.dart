import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../Data/Model/Api_response.dart';
import '../Data/Model/task_model.dart';
import '../Data/Model/task_status_count_model.dart';
import '../Data/Service/Api_Caller.dart';
import '../Utils/Urls.dart';

class TaskProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMassage;

  void setLogin(bool value) {
    isLoading = value;
    notifyListeners();
  }

  List<TaskStatusCountModel> taskCount = [];

  Future<void> getAllTaskCount() async {

    setLogin(true);
    final ApiResponse response = await ApiCaller.getRequest(
      url: urls.getTaskCountURL,
    );

    List<TaskStatusCountModel> taskC = [];

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in (response.responseData['data'])) {
        taskC.add(TaskStatusCountModel.fromJson(jsonData));
      }

      taskC.removeWhere((e) => e.sId == null);
    } else {
      ScaffoldMessenger.of(
        context as BuildContext,
      ).showSnackBar(SnackBar(content: Text(response.responseData['data'])));
    }
    taskCount = taskC;
    setLogin(false);
  }



  List<TaskModel> tasks = [];

  Future<void> getAllTask() async {
    setLogin(true);

    final ApiResponse response = await ApiCaller.getRequest(
      url: urls.getTaskByStatusURL('New'),
    );
    final ApiResponse responsePending = await ApiCaller.getRequest(
      url: urls.getTaskByStatusURL('Pending'),
    );
    final ApiResponse responseInProgress = await ApiCaller.getRequest(
      url: urls.getTaskByStatusURL('In Progress'),
    );
    final ApiResponse responseCompleted = await ApiCaller.getRequest(
      url: urls.getTaskByStatusURL('Completed'),
    );

    List<TaskModel> task = [];

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in (response.responseData['data'])) {
        task.add(TaskModel.fromJson(jsonData));
      }

      for (Map<String, dynamic> jsonData
          in (responsePending.responseData['data'])) {
        task.add(TaskModel.fromJson(jsonData));
      }

      for (Map<String, dynamic> jsonData
          in (responseInProgress.responseData['data'])) {
        task.add(TaskModel.fromJson(jsonData));
      }

      for (Map<String, dynamic> jsonData
          in (responseCompleted.responseData['data'])) {
        task.add(TaskModel.fromJson(jsonData));
      }
    } else {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text(jsonDecode(response.responseData['data']))),
      );
    }
    tasks = task;

    setLogin(false);
  }
}
