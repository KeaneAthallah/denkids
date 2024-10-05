import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:denkidsv4/main.dart';

void main() {
  testWidgets('add new item to Firestore', (tester) async {
    // Create a test widget
    await tester.pumpWidget(const MyApp());

    // Enter text into the text field
    await tester.enterText(find.byType(TextField), 'New Item');

    // Tap the add button
    await tester.tap(find.byType(ElevatedButton));

    // Verify that the new item is displayed in the list
    expect(find.text('New Item'), findsOneWidget);
  });
}
