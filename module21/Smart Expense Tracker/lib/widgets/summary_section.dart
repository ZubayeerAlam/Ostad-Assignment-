import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../models/expense_summary.dart';
import '../utils/formatters.dart';

/// Shows the calculations for the currently filtered expenses.
class SummarySection extends StatelessWidget {
  const SummarySection({super.key, required this.summary});

  final ExpenseSummary summary;

  @override
  Widget build(BuildContext context) {
    final highest = summary.highest;
    final lowest = summary.lowest;

    return Column(
      children: [
        Row(
          children: [
            _StatTile(
              label: 'Total Expense',
              value: formatMoney(summary.total),
              icon: Icons.payments,
              color: Colors.teal,
            ),
            _StatTile(
              label: "Today's Total",
              value: formatMoney(summary.todayTotal),
              icon: Icons.today,
              color: Colors.indigo,
            ),
          ],
        ),
        Row(
          children: [
            _StatTile(
              label: 'Highest',
              value: highest == null ? '—' : formatMoney(highest.amount),
              caption: highest?.title,
              icon: Icons.arrow_upward,
              color: Colors.red,
            ),
            _StatTile(
              label: 'Lowest',
              value: lowest == null ? '—' : formatMoney(lowest.amount),
              caption: lowest?.title,
              icon: Icons.arrow_downward,
              color: Colors.green,
            ),
          ],
        ),
        Row(
          children: [
            _StatTile(
              label: 'Average',
              value: formatMoney(summary.average),
              icon: Icons.calculate,
              color: Colors.deepPurple,
            ),
            _StatTile(
              label: 'Expenses',
              value: '${summary.count}',
              icon: Icons.receipt_long,
              color: Colors.brown,
            ),
          ],
        ),
        const SizedBox(height: 4),
        _CategoryTotalsCard(summary: summary),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.caption,
  });

  final String label;
  final String value;
  final String? caption;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: textTheme.bodySmall),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (caption != null)
                      Text(
                        caption!,
                        style: textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryTotalsCard extends StatelessWidget {
  const _CategoryTotalsCard({required this.summary});

  final ExpenseSummary summary;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category Totals',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            for (final category in ExpenseCategory.values)
              _CategoryRow(
                category: category,
                amount: summary.categoryTotals[category]!,
                total: summary.total,
              ),
          ],
        ),
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.category,
    required this.amount,
    required this.total,
  });

  final ExpenseCategory category;
  final double amount;
  final double total;

  @override
  Widget build(BuildContext context) {
    final share = total == 0 ? 0.0 : amount / total;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(category.icon, color: category.color, size: 20),
          const SizedBox(width: 8),
          SizedBox(width: 80, child: Text('${category.label} total')),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: share,
                minHeight: 8,
                color: category.color,
                backgroundColor: category.color.withValues(alpha: 0.15),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            formatMoney(amount),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
