import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:liveexam4/main.dart';
import 'package:liveexam4/providers/attendance_provider.dart';

void main() {
  Widget app() => ChangeNotifierProvider(
        create: (_) => AttendanceProvider(),
        child: const MyApp(),
      );

  testWidgets('add, mark present, and delete a student', (tester) async {
    await tester.pumpWidget(app());
    expect(find.textContaining('No students yet'), findsOneWidget);

    // Empty name is rejected.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    expect(find.text('Student name cannot be empty'), findsOneWidget);

    // Add a student; they start Absent.
    await tester.enterText(find.byType(TextFormField), 'Rahim');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    expect(find.text('Rahim'), findsOneWidget);
    expect(find.text('Absent'), findsNWidgets(2)); // stat label + status

    // Mark present.
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(find.text('Present'), findsNWidgets(2));

    // Delete.
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();
    expect(find.textContaining('No students yet'), findsOneWidget);
  });
}
