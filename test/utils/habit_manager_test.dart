import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_app/utils/habit_manager.dart';
import 'package:habit_tracker_app/models/habit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('Adding a habit should increase the list size', () {
    final manager = HabitManager();
    final habit = Habit(name: "Exercise");

    manager.addHabit(habit);

    expect(manager.habitsList.length, equals(1));
    expect(manager.habitsList.any((h) => h.name == "Exercise"), isTrue);
  });

  test('Deleting a habit should decrease the list size', () {
    final manager = HabitManager();
    final habit1 = Habit(name: "Exercise");
    final habit2 = Habit(name: "Read");

    manager.addHabit(habit1);
    manager.addHabit(habit2);

    manager.deleteHabit(0); // Remove "Exercise"

    expect(manager.habitsList.length, equals(1));
    expect(manager.habitsList.any((h) => h.name == "Exercise"), isFalse);
  });

  test('Deleting an invalid index should not modify the list', () {
    final manager = HabitManager();
    final habit = Habit(name: "Exercise");

    manager.addHabit(habit);

    manager.deleteHabit(5); // Out-of-bounds index
    manager.deleteHabit(-1); // Negative index

    expect(manager.habitsList.length, equals(1)); // Should remain unchanged
    expect(manager.habitsList.any((h) => h.name == "Exercise"), isTrue);
  });

  test('Adding a duplicate habit should not increase the list size', () {
    final manager = HabitManager();
    final habit = Habit(name: "Exercise");

    manager.addHabit(habit);
    manager.addHabit(habit);

    expect(manager.habitsList.length, equals(1));
  });

  test('Saving and loading habits should persist data', () async {
    final manager = HabitManager();
    final habit1 = Habit(name: "Exercise");
    final habit2 = Habit(name: "Read");

    manager.addHabit(habit1);
    manager.addHabit(habit2);

    await manager.saveHabits();

    final newManager = HabitManager();
    await newManager.loadHabits();

    expect(newManager.habitsList.length, equals(2));
    expect(newManager.habitsList.any((h) => h.name == "Exercise"), isTrue);
    expect(newManager.habitsList.any((h) => h.name == "Read"), isTrue);
  });

  test('Loading habits from empty storage should return an empty list', () async {
    final manager = HabitManager();
    await manager.loadHabits(); // Load from mock storage (empty)

    expect(manager.habitsList.isEmpty, isTrue);
  });
}
