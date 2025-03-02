import 'dart:convert';

class Habit {
  String name;
  int reminderFrequency;
  String description;
  bool isCalendarDisplay;
  String category;
  Set<String> completedDates; // Store completed dates as Strings (yyyy-MM-dd)

  Habit({
    required this.name,
    this.reminderFrequency = 1,
    this.description = '',
    this.isCalendarDisplay = false,
    this.category = 'Uncategorized',
    Set<String>? completedDates,
  }) : completedDates = completedDates ?? {};

  bool isCompletedOn(DateTime date) {
    String dateString = _formatDate(date);
    return completedDates.contains(dateString);
  }

  void toggleCompletion(DateTime date) {
    String dateString = _formatDate(date);
    if (completedDates.contains(dateString)) {
      completedDates.remove(dateString);
    } else {
      completedDates.add(dateString);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'reminderFrequency': reminderFrequency,
      'description': description,
      'isCalendarDisplay': isCalendarDisplay,
      'category': category,
      'completedDates': completedDates.toList(),
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      name: json['name'],
      reminderFrequency: json['reminderFrequency'] ?? 1,
      description: json['description'] ?? '',
      isCalendarDisplay: json['isCalendarDisplay'] ?? false,
      category: json['category'] ?? 'Uncategorized',
      completedDates: (json['completedDates'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toSet() ??
          {},
    );
  }

  String toJsonString() => jsonEncode(toJson());

  factory Habit.fromJsonString(String jsonString) {
    return Habit.fromJson(jsonDecode(jsonString));
  }

  static String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
