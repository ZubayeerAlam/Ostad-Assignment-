
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_task_manager_app/Screen/splashScreen.dart';
import 'package:student_task_manager_app/providers/auth_provider.dart';
import 'package:student_task_manager_app/providers/task_provider.dart';
import 'package:student_task_manager_app/utils/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>AuthProvider()),
        ChangeNotifierProvider(create: (_)=>TaskProvider()),
      ],

      child: MaterialApp(
        theme: ThemeData(

            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,

              hintStyle: TextStyle(
                  color: Colors.grey
              ),

              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none
              ),

              border: OutlineInputBorder(
                  borderSide: BorderSide.none
              ),

            ),


            filledButtonTheme: FilledButtonThemeData(
                style: FilledButton.styleFrom(
                    backgroundColor: AppColors.PColor,
                    fixedSize: Size.fromWidth(double.maxFinite),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    )
                )
            ),


            textTheme: TextTheme(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 28
                )
            )
        ),

        home: splashScreen(),
      ),


    );
  }
}
