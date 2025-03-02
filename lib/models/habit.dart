import 'dart:convert';

class Habit {
  String name;
  bool isCompletedToday;
  int reminderFrequency;
  String description;
  bool isCalendarDisplay;
  String category;

  Habit({
    required this.name,
    this.isCompletedToday = false,
    this.reminderFrequency = 1,
    this.description = '',
    this.isCalendarDisplay = false,
    this.category = 'Uncategorized',
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isCompletedToday': isCompletedToday,
      'reminderFrequency': reminderFrequency,
      'description': description,
      'isCalendarDisplay': isCalendarDisplay,
      'category': category,
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      name: json['name'],
      isCompletedToday: json['isCompletedToday'] ?? false,
      reminderFrequency: json['reminderFrequency'] is int
          ? json['reminderFrequency']
          : int.tryParse(json['reminderFrequency'].toString()) ?? 1, // Ensure it's always an int
      description: json['description'] ?? '',
      isCalendarDisplay: json['isCalendarDisplay'] ?? false,
      category: json['category'] ?? 'Uncategorized',
    );
  }

  String toJsonString() => jsonEncode(toJson());

  factory Habit.fromJsonString(String jsonString) {
    return Habit.fromJson(jsonDecode(jsonString));
  }
}
