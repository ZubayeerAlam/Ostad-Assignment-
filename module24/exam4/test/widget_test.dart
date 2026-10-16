import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:task_manager_app/main.dart';
import 'package:task_manager_app/providers/task_provider.dart';

void main() {
  Widget buildApp() => ChangeNotifierProvider(
    create: (_) => TaskProvider(),
    child: const TaskManagerApp(),
  );

  testWidgets('add, complete and delete a task', (tester) async {
    await tester.pumpWidget(buildApp());
    expect(find.text('No tasks yet'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Buy milk');
    await tester.enterText(find.byType(TextFormField).at(1), 'From the shop');
    await tester.tap(find.text('Save Task'));
    await tester.pumpAndSettle();

    expect(find.text('Buy milk'), findsOneWidget);
    expect(find.text('Incomplete'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(find.text('Completed'), findsNWidgets(2)); // stat label + status

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();

    expect(find.text('No tasks yet'), findsOneWidget);
  });
}
