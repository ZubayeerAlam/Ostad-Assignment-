import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screen/bmi_screen.dart';
import 'providers/bmi_provider.dart';

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BmiProvider()),
      ],
      child: MaterialApp(
        title: 'BMI Calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const BmiScreen(),
      ),
    );
  }
}
