import 'package:flutter/material.dart';

import '../Widget/App_Bar.dart';
import 'Categories_Screen.dart';
import 'Calender_Screen.dart';
import 'Profile_Screen.dart';
import 'Tasks_Screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  bool isSelected=false;
  int selectedIndex = 0;

  List screens = [
    TaskScreen(),
    CategoriesScreen(),
    CalenderScreen(),
    Profile_Screen( appBarTitle: 'Profile',),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: selectedIndex == 3 ? null : Appbar(),
      body: screens[selectedIndex],
        bottomNavigationBar:
        NavigationBarTheme(

          data: NavigationBarThemeData(
            indicatorColor: Colors.green,
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),

            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
                  (states) {
                if (states.contains(WidgetState.selected)) {
                  isSelected=true;
                  return const IconThemeData(color: Colors.white);
                }
                isSelected=false;
                return  IconThemeData(color: Colors.grey.shade700);
              },
            ),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                  (states) {
                if (states.contains(WidgetState.selected)) {
                  return  TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  );
                }
                return TextStyle(
                  color: Colors.grey.shade700,
                );
              },
            ),
          ),
          child: Card(
            child: NavigationBar(

              backgroundColor: Colors.white,
              height: 62,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations:  [
                Card(
                  color: isSelected?Colors.green:Colors.white,
                  child: NavigationDestination(
                    icon: Icon(Icons.task_outlined),
                    label: 'Tasks',
                  ),
                ),
                Card(
                  color: isSelected?Colors.green:Colors.white,
                  child: NavigationDestination(
                    icon: Icon(Icons.category_outlined),
                    label: 'Categories',
                  ),
                ),
                Card(
                  color: isSelected?Colors.green:Colors.white,
                  child: NavigationDestination(
                    icon: Icon(Icons.calendar_today_outlined),
                    label: 'Calendar',
                  ),
                ),
                Card(
                  color: isSelected?Colors.green:Colors.white,
                  child: NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    label: 'Profile',
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}


