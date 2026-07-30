import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_app/Widget/ScreenBG.dart';
import 'package:task_manager_app/Utils/assets_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
