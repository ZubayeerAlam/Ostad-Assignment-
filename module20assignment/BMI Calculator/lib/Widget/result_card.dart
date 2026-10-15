import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bmi_provider.dart';
import 'bmi_scale.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BmiProvider>(
      builder: (context, provider, child) {
        if (provider.errorMessage.isNotEmpty) {
          return Text(
            provider.errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          );
        }

        if (provider.bmi == null) return const SizedBox.shrink();

        return Card(
          elevation: 4,
          color: provider.categoryColor.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: provider.categoryColor, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(provider.categoryIcon, color: provider.categoryColor, size: 56),
                const SizedBox(height: 8),
                const Text('Your BMI', style: TextStyle(fontSize: 16)),
                Text(
                  provider.bmi!.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: provider.categoryColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: provider.categoryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    provider.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                BmiScale(bmi: provider.bmi!),
                const SizedBox(height: 16),
                Text(
                  provider.advice,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
