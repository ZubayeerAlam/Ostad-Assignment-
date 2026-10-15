import 'package:flutter/material.dart';

import '../controllers/expense_controller.dart';
import '../models/expense.dart';
import '../models/expense_summary.dart';
import '../utils/formatters.dart';
import '../widgets/budget_card.dart';
import '../widgets/budget_dialog.dart';
import '../widgets/expense_tile.dart';
import '../widgets/filter_bar.dart';
import '../widgets/summary_section.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = ExpenseController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openAddExpense() async {
    final expense = await Navigator.push<Expense>(
      context,
      MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
    );
    if (expense == null || !mounted) return;

    _controller.addExpense(expense);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Added "${expense.title}"')));
    if (_controller.isOverBudget) _showOverBudgetWarning();
  }

  Future<void> _editBudget() async {
    final budget = await showDialog<double>(
      context: context,
      builder: (_) => BudgetDialog(initialBudget: _controller.monthlyBudget),
    );
    if (budget == null || !mounted) return;

    _controller.setMonthlyBudget(budget);
    if (_controller.isOverBudget) _showOverBudgetWarning();
  }

  void _showOverBudgetWarning() {
    final over = -_controller.remainingBudget!;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber, color: Colors.red, size: 40),
        title: const Text('Over Budget!'),
        content: Text(
          'You have spent ${formatMoney(_controller.thisMonthTotal)} this month, '
          'which is ${formatMoney(over)} more than your monthly budget of '
          '${formatMoney(_controller.monthlyBudget!)}.',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(Expense expense) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete expense?'),
        content: Text(
          'Delete "${expense.title}" (${formatMoney(expense.amount)})? '
          'This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    _controller.deleteExpense(expense.id);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Deleted "${expense.title}"')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Expense Tracker'),
        actions: [
          IconButton(
            tooltip: 'Set monthly budget',
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: _editBudget,
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          // Recalculated on every change: add, delete, budget or filter.
          final expenses = _controller.filteredExpenses;
          final summary = ExpenseSummary.fromExpenses(
            expenses,
            _controller.now,
          );

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
            itemCount: expenses.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _Overview(
                  controller: _controller,
                  summary: summary,
                  onEditBudget: _editBudget,
                );
              }
              final expense = expenses[index - 1];
              return ExpenseTile(
                key: ValueKey(expense.id),
                expense: expense,
                onDelete: () => _confirmDelete(expense),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddExpense,
        icon: const Icon(Icons.add),
        label: const Text('Add Expense'),
      ),
    );
  }
}

/// Everything above the expense list: budget, filters, calculations.
class _Overview extends StatelessWidget {
  const _Overview({
    required this.controller,
    required this.summary,
    required this.onEditBudget,
  });

  final ExpenseController controller;
  final ExpenseSummary summary;
  final VoidCallback onEditBudget;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final filterLabel = controller.filter == ExpenseFilter.byCategory
        ? controller.filterCategory.label
        : controller.filter.label;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BudgetCard(controller: controller, onEditBudget: onEditBudget),
        const SizedBox(height: 12),
        Text('Filter', style: textTheme.titleMedium),
        const SizedBox(height: 4),
        FilterBar(controller: controller),
        const SizedBox(height: 12),
        Text('Summary ($filterLabel)', style: textTheme.titleMedium),
        const SizedBox(height: 4),
        SummarySection(summary: summary),
        const SizedBox(height: 12),
        Text('Expenses (${summary.count})', style: textTheme.titleMedium),
        if (summary.count == 0)
          _EmptyState(hasAnyExpense: controller.allExpenses.isNotEmpty),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasAnyExpense});

  final bool hasAnyExpense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.receipt_long, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 8),
            Text(
              hasAnyExpense ? 'No expenses match this filter' : 'No expenses yet.\nTap "Add Expense" to add your first one.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
