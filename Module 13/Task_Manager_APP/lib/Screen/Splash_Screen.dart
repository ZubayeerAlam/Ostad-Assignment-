import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_app/Widget/ScreenBG.dart';
import 'package:task_manager_app/Utils/assets_path.dart';

import '../Data/Controller/auth_controller.dart';
import 'log_in_screen.dart';
import 'main_nav_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Widget binding chara e kajj koreche
    MoveToNextScreen();
  }

  Future MoveToNextScreen() async{
    await AuthController.getUserData();
    bool isLogin=await AuthController.usUserLogin();
    await Future.delayed(Duration(seconds: 3));

    if(isLogin){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainNavScreen()));
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login_Screen()));
    }

    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login_Screen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen_BG(child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AssetPath.calendarSVG,width: 64,),
              Text("Task Manager",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 32,
              ),)
            ],
          ))
      )
    );
  }
}
