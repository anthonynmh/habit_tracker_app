import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/habit.dart';

class HabitList extends StatelessWidget {
  final List<Habit> habitsList;
  final Function(String, DateTime) onToggleCompletion;
  final Function(int) onDelete;
  final Function(String, Habit) onEdit;
  final DateTime selectedDate;

  const HabitList({
    super.key,
    required this.habitsList,
    required this.onToggleCompletion,
    required this.onDelete,
    required this.onEdit,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return habitsList.isEmpty
        ? const Center(
            child: Text(
              "No habits added yet.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          )
        : ListView.builder(
            itemCount: habitsList.length,
            itemBuilder: (context, index) {
              final habit = habitsList[index];
              final isCompleted = habit.isCompletedOn(selectedDate);

              return ListTile(
                title: Text(habit.name, style: const TextStyle(fontSize: 18)),
                trailing: IconButton(
                  icon: Icon(
                    isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: isCompleted ? Colors.green : Colors.red,
                  ),
                  onPressed: () {
                    onToggleCompletion(habit.name, selectedDate);
                  },
                ),
              );
            },
          );
  }
}
