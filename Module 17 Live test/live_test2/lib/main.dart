import 'package:flutter/material.dart';
import 'BloodReqest_Screen.dart';
import 'blood_request_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Requests',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF1F3F8),
        useMaterial3: true,
      ),
      home: const BloodRequestScreen(),
    );
  }
}
