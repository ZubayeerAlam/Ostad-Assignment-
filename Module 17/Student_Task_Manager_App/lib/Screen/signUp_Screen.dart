import 'package:flutter/cupertino.dart';
import 'package:student_task_manager_app/Widget/screenBG.dart';

import '../Widget/appBG.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  @override
  Widget build(BuildContext context) {
    return appBG(
        child: Center(
            child: Text("Sign Up Screen")
        )
    );
  }
}
