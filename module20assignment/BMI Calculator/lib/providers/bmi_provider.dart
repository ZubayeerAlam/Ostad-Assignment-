import 'package:flutter/material.dart';

class BmiProvider extends ChangeNotifier {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  double? bmi;
  String category = '';
  String errorMessage = '';
  Color categoryColor = Colors.grey;
  IconData categoryIcon = Icons.help_outline;
  String advice = '';

  // Called on every keystroke so the result updates while the user types
  void onInputChanged(String _) {
    // Don't show an error while a field is still empty — just hide the result
    if (weightController.text.trim().isEmpty ||
        heightController.text.trim().isEmpty) {
      bmi = null;
      errorMessage = '';
      notifyListeners();
      return;
    }
    calculateBmi();
  }

  void calculateBmi() {
    final double? weight = double.tryParse(weightController.text.trim());
    final double? heightCm = double.tryParse(heightController.text.trim());

    // Validation: both fields must be valid numbers
    if (weight == null || heightCm == null) {
      bmi = null;
      errorMessage = 'Please enter valid numbers for weight and height.';
      notifyListeners();
      return;
    }

    // Validation: both values must be greater than 0
    if (weight <= 0 || heightCm <= 0) {
      bmi = null;
      errorMessage = 'Weight and height must be greater than 0.';
      notifyListeners();
      return;
    }

    // Convert height from cm to m
    final double heightM = heightCm / 100;

    // BMI = weight (kg) / height² (m)
    bmi = weight / (heightM * heightM);
    errorMessage = '';

    // Determine category using conditional statements
    if (bmi! < 18.5) {
      category = 'Underweight';
      categoryColor = Colors.blue;
      categoryIcon = Icons.trending_down;
      advice = 'You are below the healthy range. Consider a balanced, nutritious diet.';
    } else if (bmi! < 25.0) {
      category = 'Normal Weight';
      categoryColor = Colors.green;
      categoryIcon = Icons.check_circle;
      advice = 'Great! You are in the healthy range. Keep it up.';
    } else if (bmi! < 30.0) {
      category = 'Overweight';
      categoryColor = Colors.orange;
      categoryIcon = Icons.warning_amber_rounded;
      advice = 'You are slightly above the healthy range. Regular exercise can help.';
    } else {
      category = 'Obesity';
      categoryColor = Colors.red;
      categoryIcon = Icons.error;
      advice = 'Your BMI is high. Consider consulting a health professional.';
    }

    notifyListeners();
  }

  void reset() {
    weightController.clear();
    heightController.clear();
    bmi = null;
    category = '';
    errorMessage = '';
    categoryColor = Colors.grey;
    categoryIcon = Icons.help_outline;
    advice = '';
    notifyListeners();
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }
}
