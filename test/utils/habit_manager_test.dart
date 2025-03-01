import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_app/utils/habit_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('Adding a habit should increase the list size', () {
    final manager = HabitManager();
    
    manager.addHabit("Exercise");

    expect(manager.habitsList.length, equals(1));
    expect(manager.habitsList.contains("Exercise"), isTrue);
  });

  test('Deleting a habit should decrease the list size', () {
    final manager = HabitManager();
    
    manager.addHabit("Exercise");
    manager.addHabit("Read");

    manager.deleteHabit(0); // Remove "Exercise"

    expect(manager.habitsList.length, equals(1));
    expect(manager.habitsList.contains("Exercise"), isFalse);
  });

  test('Deleting an invalid index should not modify the list', () {
    final manager = HabitManager();
    manager.addHabit("Exercise");

    manager.deleteHabit(5); // Out-of-bounds index
    manager.deleteHabit(-1); // Negative index

    expect(manager.habitsList.length, equals(1)); // Should remain unchanged
    expect(manager.habitsList.contains("Exercise"), isTrue);
  });

  test('Adding a duplicate habit should not increase the list size', () {
    final manager = HabitManager();
    
    manager.addHabit("Exercise");
    manager.addHabit("Exercise");

    expect(manager.habitsList.length, equals(1));
  });

  test('Adding a habit name with whitespace should be trimmed', () {
    final manager = HabitManager();
    
    manager.addHabit(" Exercise ");

    expect(manager.habitsList.contains("Exercise"), isTrue);
  });

  test('Adding an empty habit should not be added', () {
    final manager = HabitManager();
    
    manager.addHabit("");
    manager.addHabit("  "); // Only whitespace

    expect(manager.habitsList.isEmpty, isTrue);
  });


  test('Saving and loading habits should persist data', () async {
    final manager = HabitManager();
    manager.addHabit("Exercise");
    manager.addHabit("Read");

    await manager.saveHabits();

    final newManager = HabitManager();
    await newManager.loadHabits();

    expect(newManager.habitsList, equals(["Exercise", "Read"]));
  });

  test('Loading habits from empty storage should return an empty list', () async {
    final manager = HabitManager();
    await manager.loadHabits(); // Load from mock storage (empty)

    expect(manager.habitsList.isEmpty, isTrue);
  });
}
