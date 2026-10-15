import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exam4/main.dart';

void main() {
  testWidgets('Quantity never goes below 0', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byIcon(Icons.remove).first);
    await tester.pump();
    expect(find.text('৳0'), findsOneWidget); // subtotal unchanged
  });

  testWidgets('10% discount applied at subtotal >= 3000', (tester) async {
    await tester.pumpWidget(const MyApp());
    // Watch is the 3rd card: 2 x 2000 = 4000
    await tester.tap(find.byIcon(Icons.add).at(2));
    await tester.tap(find.byIcon(Icons.add).at(2));
    await tester.pump();
    expect(find.text('৳4000'), findsOneWidget);
    expect(find.text('- ৳400.00'), findsOneWidget);
    expect(find.text('৳3600.00'), findsOneWidget);
  });

  testWidgets('Search + category filter work together', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byType(TextField), 'SHO');
    await tester.pump();
    expect(find.text('Shoes'), findsOneWidget);
    expect(find.text('Bag'), findsNothing);

    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Clothes').last);
    await tester.pumpAndSettle();
    expect(find.text('No matching products found'), findsOneWidget);
  });
}
