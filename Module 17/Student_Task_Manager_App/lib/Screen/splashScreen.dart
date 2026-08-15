import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_task_manager_app/Screen/Login_Screen.dart';
import 'package:student_task_manager_app/Widget/screenBG.dart';


import '../utils/assets_path.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}



class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MoveToHome();
  }


  Future MoveToHome() async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> loginScreen()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenBG(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 200,),
                SizedBox(
                    height: 238,
                    child: Expanded(child: Image.asset( AssetPath.splashLogo, width: 200, height: 20,))),
                Text("Task Manager",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'montserrat',
                ),)

              ],
            ),
          )
      
      ),
    );

  }
}
