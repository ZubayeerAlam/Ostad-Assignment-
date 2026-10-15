import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_expense_tracker/controllers/expense_controller.dart';
import 'package:smart_expense_tracker/main.dart';
import 'package:smart_expense_tracker/models/expense.dart';
import 'package:smart_expense_tracker/utils/validators.dart';

// Fixed "now": Friday 16 Oct 2026, so the week is Mon 12 – Sun 18 Oct.
final _now = DateTime(2026, 10, 16, 14);

Expense _expense(
  String id,
  double amount,
  ExpenseCategory category,
  DateTime date,
) => Expense(
  id: id,
  title: 'E$id',
  amount: amount,
  category: category,
  date: date,
);

void main() {
  group('ExpenseController', () {
    late ExpenseController controller;

    setUp(() => controller = ExpenseController(clock: () => _now));

    test('no expenses gives zero totals and no highest/lowest', () {
      final s = controller.filteredSummary;
      expect(s.total, 0);
      expect(s.average, 0);
      expect(s.highest, isNull);
      expect(s.lowest, isNull);
      expect(s.categoryTotals.values.every((v) => v == 0), isTrue);
    });

    test('adding and deleting updates every calculation', () {
      controller
        ..addExpense(_expense('1', 100, ExpenseCategory.food, _now))
        ..addExpense(
          _expense('2', 300, ExpenseCategory.transport, DateTime(2026, 10, 14)),
        )
        ..addExpense(
          _expense('3', 50, ExpenseCategory.food, DateTime(2026, 9, 1)),
        );

      var s = controller.filteredSummary;
      expect(s.total, 450);
      expect(s.todayTotal, 100);
      expect(s.highest!.id, '2');
      expect(s.lowest!.id, '3');
      expect(s.average, 150);
      expect(s.categoryTotals[ExpenseCategory.food], 150);
      expect(s.categoryTotals[ExpenseCategory.transport], 300);

      controller.deleteExpense('2');
      s = controller.filteredSummary;
      expect(s.total, 150);
      expect(s.highest!.id, '1');
      expect(s.categoryTotals[ExpenseCategory.transport], 0);
    });

    test('rejects zero or negative amounts and budgets', () {
      expect(
        () => controller.addExpense(
          _expense('x', 0, ExpenseCategory.other, _now),
        ),
        throwsArgumentError,
      );
      expect(
        () => controller.addExpense(
          _expense('y', -5, ExpenseCategory.other, _now),
        ),
        throwsArgumentError,
      );
      expect(() => controller.setMonthlyBudget(-1), throwsArgumentError);
      expect(controller.allExpenses, isEmpty);
    });

    test('filters change the displayed calculations', () {
      controller
        ..addExpense(_expense('today', 10, ExpenseCategory.food, _now))
        ..addExpense(
          _expense('mon', 20, ExpenseCategory.shopping, DateTime(2026, 10, 12)),
        )
        ..addExpense(
          _expense(
            'lastWeek',
            40,
            ExpenseCategory.shopping,
            DateTime(2026, 10, 11),
          ),
        )
        ..addExpense(
          _expense(
            'lastMonth',
            80,
            ExpenseCategory.other,
            DateTime(2026, 9, 30),
          ),
        );

      controller.setFilter(ExpenseFilter.today);
      expect(controller.filteredSummary.total, 10);
      controller.setFilter(ExpenseFilter.thisWeek);
      expect(controller.filteredSummary.total, 30);
      controller.setFilter(ExpenseFilter.thisMonth);
      expect(controller.filteredSummary.total, 70);
      controller
        ..setFilter(ExpenseFilter.byCategory)
        ..setFilterCategory(ExpenseCategory.shopping);
      expect(controller.filteredSummary.total, 60);
      controller.setFilter(ExpenseFilter.all);
      expect(controller.filteredSummary.total, 150);
    });

    test('budget uses this month and reports spending status', () {
      controller
        ..setMonthlyBudget(1000)
        ..addExpense(
          _expense('old', 5000, ExpenseCategory.other, DateTime(2026, 9, 1)),
        )
        ..addExpense(_expense('a', 400, ExpenseCategory.food, _now));
      expect(controller.remainingBudget, 600);
      expect(controller.spendingStatus, SpendingStatus.safe);

      controller.addExpense(_expense('b', 300, ExpenseCategory.food, _now));
      expect(controller.spendingStatus, SpendingStatus.moderate);

      controller.addExpense(_expense('c', 300, ExpenseCategory.food, _now));
      expect(controller.spendingStatus, SpendingStatus.warning); // exactly 100%
      expect(controller.isOverBudget, isFalse);

      controller.addExpense(_expense('d', 1, ExpenseCategory.food, _now));
      expect(controller.spendingStatus, SpendingStatus.overBudget);
      expect(controller.remainingBudget, -1);
    });

    test('status thresholds', () {
      expect(SpendingStatus.fromPercent(49.9), SpendingStatus.safe);
      expect(SpendingStatus.fromPercent(50), SpendingStatus.moderate);
      expect(SpendingStatus.fromPercent(80), SpendingStatus.warning);
      expect(SpendingStatus.fromPercent(100), SpendingStatus.warning);
      expect(SpendingStatus.fromPercent(100.1), SpendingStatus.overBudget);
    });
  });

  test('validators', () {
    expect(validateAmount('0'), isNotNull);
    expect(validateAmount('-3'), isNotNull);
    expect(validateAmount('abc'), isNotNull);
    expect(validateAmount('12.5'), isNull);
    expect(validateBudget('-1'), 'Budget cannot be negative');
    expect(validateBudget('500'), isNull);
    expect(validateTitle('  '), isNotNull);
  });

  testWidgets('add an expense through the UI, then delete it', (tester) async {
    // Tall screen so the expense list below the overview gets built.
    tester.view.physicalSize = const Size(1080, 3000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const SmartExpenseApp());
    expect(find.textContaining('No expenses yet'), findsOneWidget);

    await tester.tap(find.text('Add Expense'));
    await tester.pumpAndSettle();

    // Invalid amount is rejected.
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Expense title'),
      'Lunch',
    );
    await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '0');
    await tester.tap(find.text('Save Expense'));
    await tester.pumpAndSettle();
    expect(find.text('Amount must be greater than 0'), findsOneWidget);
    expect(find.text('Please select a category'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '250');
    await tester.tap(find.byType(DropdownButtonFormField<ExpenseCategory>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Food').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save Expense'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(ListTile, 'Lunch'), findsOneWidget);
    expect(find.text('Expenses (1)'), findsOneWidget);
    // Only expense, so it is both the highest and the lowest.
    expect(find.text('Lunch'), findsNWidgets(3));

    await tester.tap(find.byTooltip('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Expenses (0)'), findsOneWidget);
    expect(find.textContaining('No expenses yet'), findsOneWidget);
  });
}
