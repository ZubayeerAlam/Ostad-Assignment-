import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bmi_calculator/Myapp.dart';

void main() {
  testWidgets('Calculates BMI and shows category', (WidgetTester tester) async {
    await tester.pumpWidget(const BmiApp());

    await tester.enterText(find.byType(TextField).at(0), '70');
    await tester.enterText(find.byType(TextField).at(1), '170');
    await tester.tap(find.text('Calculate BMI'));
    await tester.pump();

    expect(find.text('24.2'), findsOneWidget);
    expect(find.text('Normal Weight'), findsNWidgets(2));
  });

  testWidgets('Updates BMI automatically while typing', (WidgetTester tester) async {
    await tester.pumpWidget(const BmiApp());

    await tester.enterText(find.byType(TextField).at(0), '70');
    await tester.enterText(find.byType(TextField).at(1), '170');
    await tester.pump();
    expect(find.text('24.2'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), '90');
    await tester.pump();
    expect(find.text('31.1'), findsOneWidget);
    expect(find.text('Obesity'), findsNWidgets(2));
  });

  testWidgets('Shows error for invalid input', (WidgetTester tester) async {
    await tester.pumpWidget(const BmiApp());

    await tester.enterText(find.byType(TextField).at(0), '0');
    await tester.enterText(find.byType(TextField).at(1), '170');
    await tester.tap(find.text('Calculate BMI'));
    await tester.pump();

    expect(find.text('Weight and height must be greater than 0.'), findsOneWidget);
  });

  testWidgets('Reset clears input and result', (WidgetTester tester) async {
    await tester.pumpWidget(const BmiApp());

    await tester.enterText(find.byType(TextField).at(0), '70');
    await tester.enterText(find.byType(TextField).at(1), '170');
    await tester.tap(find.text('Calculate BMI'));
    await tester.pump();
    await tester.tap(find.text('Reset'));
    await tester.pump();

    expect(find.text('24.2'), findsNothing);
    expect(find.text('70'), findsNothing);
  });
}
