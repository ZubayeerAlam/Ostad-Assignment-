import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/providers/auth_provider.dart';
import 'package:task_manager_app/providers/task_provider.dart';

import 'Screen/Splash_Screen.dart';
import 'Utils/app_colors.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderSide: BorderSide.none),

            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),

            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),

          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.PColor,
              fixedSize: Size.fromWidth(double.maxFinite),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 28,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
