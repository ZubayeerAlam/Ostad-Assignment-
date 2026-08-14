import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_task_manager_app/Screen/splashScreen.dart';

class My_app extends StatelessWidget {
  const My_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: splashScreen(),

    );
  }
}
