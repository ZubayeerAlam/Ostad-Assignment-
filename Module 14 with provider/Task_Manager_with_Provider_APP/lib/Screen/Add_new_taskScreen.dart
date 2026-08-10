

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/Utils/Urls.dart';

import '../Data/Model/Api_response.dart';
import '../Data/Service/Api_Caller.dart';
import '../Widget/ScreenBG.dart';
import '../Widget/taskStatus_Bycount.dart';
import 'main_nav_Screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  Future<void>createTask() async {

    final ApiResponse response = await ApiCaller.PostRequest(url: urls.CreateTaskURL,
        body: {
          "title":titleController.text,
          "description": descriptionController.text,
          "status":"New"
        }

    );

    if(response.isSuccess){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavScreen()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task created successfully....!')));


    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.responseData['data'])));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavScreen()));

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Screen_BG(child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 200,),
              Text('Add New task', style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: 25,),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: 'Title'
                ),
              ),
              SizedBox(height: 10,),

              TextFormField(
                controller: descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: 'Description'
                ),
              ),

              FilledButton(onPressed: (){

                createTask();
              }, child: Icon(Icons.arrow_circle_right_outlined,size: 25,)),
            ],
          ),
        ),
        ));
  }
}
