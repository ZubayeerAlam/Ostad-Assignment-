import 'package:flutter/material.dart';

import '../utils/validators.dart';

/// AlertDialog for entering the monthly budget. Pops with the new budget.
class BudgetDialog extends StatefulWidget {
  const BudgetDialog({super.key, this.initialBudget});

  final double? initialBudget;

  @override
  State<BudgetDialog> createState() => _BudgetDialogState();
}

class _BudgetDialogState extends State<BudgetDialog> {
  late final TextEditingController _budgetController = TextEditingController(
    text: widget.initialBudget?.toStringAsFixed(2) ?? '',
  );
  String? _error;

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  void _save() {
    final error = validateBudget(_budgetController.text);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    Navigator.pop(context, double.parse(_budgetController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Monthly Budget'),
      content: TextField(
        controller: _budgetController,
        autofocus: true,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: 'Budget amount',
          prefixText: '৳ ',
          border: const OutlineInputBorder(),
          errorText: _error,
        ),
        onChanged: (_) {
          if (_error != null) setState(() => _error = null);
        },
        onSubmitted: (_) => _save(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}
