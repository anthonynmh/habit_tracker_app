import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:habit_tracker_app/models/habit.dart';

class HabitManager {
  List<Habit> habitsList = [];

  Future<void> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();// for debugging
    final String? habitsJson = prefs.getString('habits');
    if (habitsJson != null) {
      List<dynamic> decoded = jsonDecode(habitsJson);
      habitsList = decoded.map((habit) => Habit.fromJson(habit)).toList();
    }
  }

  bool dupeNameExists(Habit habit) {
    return habitsList.any((h) => h.name == habit.name);
  }

  void addHabit(Habit habit) {
    habitsList.add(habit);
    saveHabits();
  }

  void deleteHabit(int index) {
    habitsList.removeAt(index);
    saveHabits();
  }

  void updateHabit(String habitName, Habit updatedHabit) {
    int index = habitsList.indexWhere((habit) => habit.name == habitName);
    if (index != -1) {
      habitsList[index] = updatedHabit;
      saveHabits();
    }
  }

  Future<void> saveHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedHabits = jsonEncode(habitsList.map((h) => h.toJson()).toList());
    prefs.setString('habits', encodedHabits);
  }
}
