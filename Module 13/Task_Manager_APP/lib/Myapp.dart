import 'package:flutter/material.dart';

import 'Screen/Splash_Screen.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
          textTheme: TextTheme(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  fontFamily: 'Poppins',
              )
          )
      ),
      home: SplashScreen(),
    );
  }
}
