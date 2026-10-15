import '../utils/formatters.dart';
import 'expense.dart';

/// All calculations for a list of expenses (usually the filtered list).
class ExpenseSummary {
  const ExpenseSummary._({
    required this.count,
    required this.total,
    required this.todayTotal,
    required this.average,
    required this.highest,
    required this.lowest,
    required this.categoryTotals,
  });

  factory ExpenseSummary.fromExpenses(List<Expense> expenses, DateTime now) {
    final categoryTotals = {for (final c in ExpenseCategory.values) c: 0.0};

    // No expenses: everything is zero and there is no highest/lowest.
    if (expenses.isEmpty) {
      return ExpenseSummary._(
        count: 0,
        total: 0,
        todayTotal: 0,
        average: 0,
        highest: null,
        lowest: null,
        categoryTotals: categoryTotals,
      );
    }

    var total = 0.0;
    var todayTotal = 0.0;
    var highest = expenses.first;
    var lowest = expenses.first;

    for (final expense in expenses) {
      total += expense.amount;
      if (isSameDay(expense.date, now)) todayTotal += expense.amount;
      if (expense.amount > highest.amount) highest = expense;
      if (expense.amount < lowest.amount) lowest = expense;
      categoryTotals[expense.category] =
          categoryTotals[expense.category]! + expense.amount;
    }

    return ExpenseSummary._(
      count: expenses.length,
      total: total,
      todayTotal: todayTotal,
      average: total / expenses.length,
      highest: highest,
      lowest: lowest,
      categoryTotals: categoryTotals,
    );
  }

  final int count;
  final double total;
  final double todayTotal;
  final double average;
  final Expense? highest;
  final Expense? lowest;
  final Map<ExpenseCategory, double> categoryTotals;
}
