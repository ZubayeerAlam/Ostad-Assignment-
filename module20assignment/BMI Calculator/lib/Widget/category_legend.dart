import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bmi_provider.dart';

class CategoryLegend extends StatelessWidget {
  const CategoryLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BmiProvider>();
    final String? activeCategory = provider.bmi != null ? provider.category : null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BMI Categories',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _legendRow(activeCategory, Colors.blue, 'Underweight', 'Below 18.5'),
            _legendRow(activeCategory, Colors.green, 'Normal Weight', '18.5 – 24.9'),
            _legendRow(activeCategory, Colors.orange, 'Overweight', '25.0 – 29.9'),
            _legendRow(activeCategory, Colors.red, 'Obesity', '30.0 or above'),
          ],
        ),
      ),
    );
  }

  Widget _legendRow(String? activeCategory, Color color, String label, String range) {
    final style = TextStyle(
      fontWeight: activeCategory == label ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: style)),
          Text(range, style: style),
        ],
      ),
    );
  }
}
