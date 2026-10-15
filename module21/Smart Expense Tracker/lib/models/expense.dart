import 'package:flutter/material.dart';

enum ExpenseCategory {
  food('Food', Icons.restaurant, Colors.orange),
  transport('Transport', Icons.directions_bus, Colors.blue),
  shopping('Shopping', Icons.shopping_bag, Colors.purple),
  other('Other', Icons.category, Colors.blueGrey);

  const ExpenseCategory(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}

class Expense {
  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  final String id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
}
