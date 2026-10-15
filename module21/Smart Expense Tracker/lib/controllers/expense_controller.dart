import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../models/expense_summary.dart';
import '../utils/formatters.dart';

enum ExpenseFilter {
  all('All'),
  today('Today'),
  thisWeek('This week'),
  thisMonth('This month'),
  byCategory('By category');

  const ExpenseFilter(this.label);

  final String label;
}

enum SpendingStatus {
  safe('Safe', Colors.green, Icons.check_circle),
  moderate('Moderate', Colors.amber, Icons.info),
  warning('Warning', Colors.orange, Icons.warning_amber),
  overBudget('Over Budget', Colors.red, Icons.error);

  const SpendingStatus(this.label, this.color, this.icon);

  final String label;
  final Color color;
  final IconData icon;

  /// Below 50% → Safe, 50–80% → Moderate, 80–100% → Warning,
  /// above 100% → Over Budget.
  static SpendingStatus fromPercent(double percent) {
    if (percent < 50) return SpendingStatus.safe;
    if (percent < 80) return SpendingStatus.moderate;
    if (percent <= 100) return SpendingStatus.warning;
    return SpendingStatus.overBudget;
  }
}

/// Holds the app state. Every change calls [notifyListeners], so the UI and
/// all calculations update immediately after adding, deleting or filtering.
class ExpenseController extends ChangeNotifier {
  ExpenseController({DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final DateTime Function() _clock;
  final List<Expense> _expenses = [];
  double? _monthlyBudget;
  ExpenseFilter _filter = ExpenseFilter.all;
  ExpenseCategory _filterCategory = ExpenseCategory.food;

  DateTime get now => _clock();
  List<Expense> get allExpenses => List.unmodifiable(_expenses);
  double? get monthlyBudget => _monthlyBudget;
  ExpenseFilter get filter => _filter;
  ExpenseCategory get filterCategory => _filterCategory;

  // ---------- Filtering ----------

  /// Expenses matching the current filter, newest first.
  List<Expense> get filteredExpenses {
    final today = now;
    return _expenses.where((e) => _matchesFilter(e, today)).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Calculations based on the filtered list.
  ExpenseSummary get filteredSummary =>
      ExpenseSummary.fromExpenses(filteredExpenses, now);

  bool _matchesFilter(Expense expense, DateTime today) {
    switch (_filter) {
      case ExpenseFilter.all:
        return true;
      case ExpenseFilter.today:
        return isSameDay(expense.date, today);
      case ExpenseFilter.thisWeek:
        // Week runs Monday to Sunday.
        final weekStart = DateTime(
          today.year,
          today.month,
          today.day - (today.weekday - 1),
        );
        final weekEnd = DateTime(
          weekStart.year,
          weekStart.month,
          weekStart.day + 7,
        );
        final day = dateOnly(expense.date);
        return !day.isBefore(weekStart) && day.isBefore(weekEnd);
      case ExpenseFilter.thisMonth:
        return _isThisMonth(expense, today);
      case ExpenseFilter.byCategory:
        return expense.category == _filterCategory;
    }
  }

  bool _isThisMonth(Expense expense, DateTime today) =>
      expense.date.year == today.year && expense.date.month == today.month;

  void setFilter(ExpenseFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  void setFilterCategory(ExpenseCategory category) {
    _filterCategory = category;
    notifyListeners();
  }

  // ---------- Budget ----------

  /// The monthly budget is compared with this month's spending.
  double get thisMonthTotal {
    final today = now;
    return _expenses
        .where((e) => _isThisMonth(e, today))
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  double? get remainingBudget =>
      _monthlyBudget == null ? null : _monthlyBudget! - thisMonthTotal;

  double? get budgetUsedPercent =>
      _monthlyBudget == null ? null : thisMonthTotal / _monthlyBudget! * 100;

  SpendingStatus? get spendingStatus {
    final percent = budgetUsedPercent;
    return percent == null ? null : SpendingStatus.fromPercent(percent);
  }

  bool get isOverBudget => spendingStatus == SpendingStatus.overBudget;

  void setMonthlyBudget(double budget) {
    if (budget <= 0) {
      throw ArgumentError.value(budget, 'budget', 'must be greater than 0');
    }
    _monthlyBudget = budget;
    notifyListeners();
  }

  void clearBudget() {
    _monthlyBudget = null;
    notifyListeners();
  }

  // ---------- Add / delete ----------

  void addExpense(Expense expense) {
    if (expense.amount <= 0) {
      throw ArgumentError.value(
        expense.amount,
        'amount',
        'must be greater than 0',
      );
    }
    _expenses.add(expense);
    notifyListeners();
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
