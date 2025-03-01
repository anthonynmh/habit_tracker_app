import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_app/screens/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({}); // Mock SharedPreferences
  });

  testWidgets('Displays message when no habits are present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardPage()));
    await tester.pump(); // Allow state to initialize

    expect(find.text("No habits added yet."), findsOneWidget);
  });

  testWidgets('Adding a habit updates the UI', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardPage()));
    await tester.pump();

    // Tap the FAB to add a habit
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Simulate entering a habit name
    await tester.enterText(find.byType(TextField), 'Exercise');
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    expect(find.text('Exercise'), findsOneWidget);
  });

  testWidgets('Deleting a habit updates the UI', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardPage()));
    await tester.pump();

    // Tap the FAB to add a habit
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Simulate entering a habit name
    await tester.enterText(find.byType(TextField), 'Exercise');
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    // Enable delete mode
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Tap the delete button on the first habit
    await tester.tap(find.text('Exercise'));
    await tester.pumpAndSettle();

    // Tap on delete confirmation
    await tester.tap(find.text("Delete"));
    await tester.pumpAndSettle();

    expect(find.text("Exercise"), findsNothing);
  });

  testWidgets('Toggling delete mode updates UI', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardPage()));
    await tester.pump();

    // Tap the FAB to add a habit
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Simulate entering a habit name
    await tester.enterText(find.byType(TextField), 'Exercise');
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    // Toggle delete mode
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.cancel), findsOneWidget);

    // Toggle back
    await tester.tap(find.byIcon(Icons.cancel));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.delete), findsOneWidget);
  });
}
