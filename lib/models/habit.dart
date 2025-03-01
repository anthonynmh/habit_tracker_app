import 'dart:convert';

class Habit {
  String name;
  bool isCompleted;
  int streak;

  Habit({required this.name, this.isCompleted = false, this.streak = 0});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isCompleted': isCompleted,
      'streak': streak,
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      name: json['name'],
      isCompleted: json['isCompleted'] ?? false,
      streak: json['streak'] ?? 0,
    );
  }

  String toJsonString() => jsonEncode(toJson());

  factory Habit.fromJsonString(String jsonString) {
    return Habit.fromJson(jsonDecode(jsonString));
  }
}
