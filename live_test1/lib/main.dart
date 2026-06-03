import 'package:flutter/material.dart';
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

class BloodRequestScreen extends StatelessWidget {
  const BloodRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> requests = [
      BloodRequestCard(
        bloodType: 'O-',
        units: 3,
        hospital: 'Khulna City Medical College Hospital, KDA Ave...',
      ),
      BloodRequestCard(
        bloodType: 'O+',
        units: 2,
        hospital: 'Khulna City Medical College Hospital, KDA Ave...',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Blood Requests',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 24),

                for (final request in requests)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: request,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}