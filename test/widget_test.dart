import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_managaer_app/main.dart';

void main() {
  testWidgets('Task Manager app loads and displays initial tasks and statistics',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify AppBar title
    expect(find.text('Task Manager'), findsOneWidget);

    // Verify Statistics Cards exist
    expect(find.text('Total'), findsOneWidget);
    expect(find.text('Completed'), findsAtLeastNWidgets(1));
    expect(find.text('Pending'), findsAtLeastNWidgets(1));

    // Verify FAB exists
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
