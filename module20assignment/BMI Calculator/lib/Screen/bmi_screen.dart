import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/action_buttons.dart';
import '../Widget/category_legend.dart';
import '../Widget/input_field.dart';
import '../Widget/result_card.dart';
import '../providers/bmi_provider.dart';

class BmiScreen extends StatelessWidget {
  const BmiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BmiProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              controller: provider.weightController,
              label: 'Weight (kg)',
              hint: 'e.g. 70',
              icon: Icons.monitor_weight_outlined,
              onChanged: provider.onInputChanged,
            ),
            const SizedBox(height: 16),
            InputField(
              controller: provider.heightController,
              label: 'Height (cm)',
              hint: 'e.g. 170',
              icon: Icons.height,
              onChanged: provider.onInputChanged,
            ),
            const SizedBox(height: 24),
            const ActionButtons(),
            const SizedBox(height: 24),
            const ResultCard(),
            const SizedBox(height: 24),
            const CategoryLegend(),
          ],
        ),
      ),
    );
  }
}
