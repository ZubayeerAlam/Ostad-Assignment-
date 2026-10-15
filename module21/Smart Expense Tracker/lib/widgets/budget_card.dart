import 'package:flutter/material.dart';

import '../controllers/expense_controller.dart';
import '../utils/formatters.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({
    super.key,
    required this.controller,
    required this.onEditBudget,
  });

  final ExpenseController controller;
  final VoidCallback onEditBudget;

  @override
  Widget build(BuildContext context) {
    final budget = controller.monthlyBudget;
    final textTheme = Theme.of(context).textTheme;

    if (budget == null) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.account_balance_wallet_outlined),
          title: const Text('No monthly budget set'),
          subtitle: const Text('Set a budget to track your spending status'),
          trailing: FilledButton(
            onPressed: onEditBudget,
            child: const Text('Set'),
          ),
        ),
      );
    }

    final spent = controller.thisMonthTotal;
    final remaining = controller.remainingBudget!;
    final percent = controller.budgetUsedPercent!;
    final status = controller.spendingStatus!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Monthly Budget', style: textTheme.titleMedium),
                const Spacer(),
                Chip(
                  avatar: Icon(status.icon, color: status.color, size: 18),
                  label: Text(status.label),
                  side: BorderSide(color: status.color),
                  visualDensity: VisualDensity.compact,
                ),
                IconButton(
                  tooltip: 'Edit budget',
                  icon: const Icon(Icons.edit),
                  onPressed: onEditBudget,
                ),
              ],
            ),
            Text(
              '${formatMoney(spent)} of ${formatMoney(budget)} spent this month',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: (percent / 100).clamp(0.0, 1.0),
                minHeight: 10,
                color: status.color,
                backgroundColor: status.color.withValues(alpha: 0.15),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  remaining >= 0
                      ? 'Remaining: ${formatMoney(remaining)}'
                      : 'Over by: ${formatMoney(-remaining)}',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: remaining >= 0 ? null : Colors.red,
                  ),
                ),
                const Spacer(),
                Text('${percent.toStringAsFixed(1)}% used'),
              ],
            ),
            if (controller.isOverBudget) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You have exceeded your monthly budget by '
                        '${formatMoney(-remaining)}!',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
