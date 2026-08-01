import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/Screen/NewTask_Screen.dart';

import '../Utils/app_colors.dart';
import '../Widget/App_Bar.dart';
import 'Cancel_Screen.dart';
import 'CompleteTask_Screen.dart';
import 'ProgressTask_Screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int selectedIndex = 0;

  List screens = [
    NewtaskScreen(),
    ProgressTaskScreen(),
    CompleteTaskScreen(),
    CancelScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: screens[selectedIndex],
        bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.task), label: 'New Task'),
          NavigationDestination(
              icon: Icon(Icons.refresh), label: 'Progress Task'),
          NavigationDestination(
              icon: Icon(Icons.task_alt_outlined), label: 'Completed Task'),
          NavigationDestination(
              icon: Icon(Icons.cancel_outlined), label: 'Cancel Task'),
        ],
      )
    );
  }
}


