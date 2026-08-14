import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Data/Model/Api_response.dart';
import '../Data/Model/task_model.dart';
import '../Data/Service/Api_Caller.dart';
import '../utils/Urls.dart';

class TaskCard extends StatefulWidget {
  final TaskModel taskModel;
  final Color cardColor;
  final VoidCallback refresh;

  const TaskCard({
    super.key,
    required this.taskModel,
    required this.cardColor,
    required this.refresh,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  void showChangeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Card(
                color: widget.taskModel.status == 'New'
                    ? Colors.green
                    : null,

                child: ListTile(
                  title: Text('New'),
                  onTap: () {
                    updateTaskStatus('New');
                    Navigator.pop(context);
                  },
                  trailing: widget.taskModel.status == 'New'
                      ? Icon(Icons.check_circle, color: Colors.white)
                      : null,
                ),
              ),


              Card(
                color: widget.taskModel.status == 'Pending'
                    ? Colors.green
                    : null,

                child: ListTile(
                  title: Text('Pending'),
                  onTap: () {
                    updateTaskStatus('Pending');
                    Navigator.pop(context);
                  },
                  trailing: widget.taskModel.status == 'Pending'
                      ? Icon(Icons.check_circle, color: Colors.white)
                      : null,
                ),
              ),
              Card(
                color: widget.taskModel.status == 'In Progress'
                    ? Colors.green
                    : null,

                child: ListTile(
                  title: Text('In Progress'),
                  onTap: () {
                    updateTaskStatus('In Progress');
                    Navigator.pop(context);
                  },
                  trailing: widget.taskModel.status == 'In Progress'
                      ? Icon(Icons.check_circle, color: Colors.white)
                      : null,
                ),
              ),
              Card(
                color: widget.taskModel.status == 'Completed'
                    ? Colors.green
                    : null,

                child: ListTile(
                  title: Text('Completed'),
                  onTap: () {
                    updateTaskStatus('Completed');
                    Navigator.pop(context);
                  },
                  trailing: widget.taskModel.status == 'Completed'
                      ? Icon(Icons.check_circle, color: Colors.white)
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> updateTaskStatus(String status) async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: urls.updateTaskStatusURL(widget.taskModel.sId.toString(), status),
    );

    if (response.isSuccess) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Task Status Updated')));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.responseData['data'].toString())),
        );
      }
    }

    widget.refresh();
  }

  Future<void> deleteTask() async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: urls.deleteTaskURL(widget.taskModel.sId.toString()),
    );

    if (response.isSuccess) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Task Deleted')));
      widget.refresh();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.responseData['data'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.taskModel.title.toString(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
      ),

      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.taskModel.description.toString()),

          Text("Date: ${widget.taskModel.createdDate}"),
          Row(
            children: [
              Chip(
                label: Text(widget.taskModel.status.toString()),
                backgroundColor: widget.cardColor,

                labelStyle: TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  showChangeDialog();
                },
                icon: Icon(Icons.edit_note, color: Colors.green),
              ),

              IconButton(
                onPressed: () {
                  deleteTask();
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
