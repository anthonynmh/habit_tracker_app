import 'dart:convert';

class Habit {
  String name;
  String description;
  String category;
  Set<String> completedDates; // Store completed dates as Strings (yyyy-MM-dd)

  Habit({
    required this.name,
    this.description = '',
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
      'description': description,
      'category': category,
      'completedDates': completedDates.toList(),
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      name: json['name'],
      description: json['description'] ?? '',
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
