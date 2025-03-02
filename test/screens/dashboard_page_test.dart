import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_app/screens/dashboard_page.dart';
import 'package:habit_tracker_app/utils/habit_manager.dart';
import 'package:habit_tracker_app/models/habit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Displays message when no habits are present', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DashboardPage()));
    await tester.pump();

    expect(find.text("Incomplete Habits (0)"), findsOneWidget);
  });

  testWidgets('Adding a habit updates the UI', (WidgetTester tester) async {
    final habitManager = HabitManager();
    habitManager.addHabit(Habit(name: "Exercise", completedDates: <String>{}));

    await tester.pumpWidget(const MaterialApp(home: DashboardPage()));
    await tester.pump();

    expect(find.text("Exercise"), findsOneWidget);
  });

  testWidgets('Completed habits toggle visibility', (WidgetTester tester) async {
    final habitManager = HabitManager();
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    habitManager.addHabit(Habit(name: "Exercise", completedDates: <String>{today}));

    await tester.pumpWidget(const MaterialApp(home: DashboardPage()));
    await tester.pump();

    // Toggle show completed
    await tester.tap(find.byIcon(Icons.expand_less));
    await tester.pump();

    expect(find.text("Exercise"), findsOneWidget);
  });
}
