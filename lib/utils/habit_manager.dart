import 'package:shared_preferences/shared_preferences.dart';

class HabitManager {
  List<String> _habitsList = []; // Private list

  List<String> get habitsList => List.unmodifiable(_habitsList); // Expose as read-only

  Future<void> loadHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _habitsList = prefs.getStringList('habits') ?? [];
  }

  Future<void> saveHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (habitsList.isEmpty) {
      await prefs.remove('habits');
    } else {
      await prefs.setStringList('habits', habitsList);
    }
  }

  void addHabit(String habit) {
    final trimmedHabit = habit.trim();
    if (trimmedHabit.isNotEmpty && !containsHabit(trimmedHabit)) {
      _habitsList.add(trimmedHabit);
    }
  }

  void deleteHabit(int index) {
    if (index >= 0 && index < habitsList.length) {
      _habitsList.removeAt(index);
    }
  }

  bool containsHabit(String habit) {
    return _habitsList.contains(habit.trim());
  }
}
