import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/habit.dart';
import 'package:habit_tracker_app/widgets/input_dialog.dart';

class HabitList extends StatelessWidget {
  final List<Habit> habitsList;
  final Function(int) onDelete;
  final Function(int, Habit) onEdit; // Function to handle habit updates

  const HabitList({
    super.key,
    required this.habitsList,
    required this.onDelete,
    required this.onEdit,
  });

  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this habit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDelete(index);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editHabit(BuildContext context, int index) async {
    Habit? updatedHabit = await showHabitInputDialog(context, initialHabit: habitsList[index]);

    if (updatedHabit != null) {
      onEdit(index, updatedHabit); // Pass updated habit to parent
    }
  }

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
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      habit.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Category: ${habit.category}"),
                        Text("Reminder: ${habit.reminderFrequency} times/day"),
                        if (habit.description.isNotEmpty) Text("Note: ${habit.description}"),
                        Text("Calendar Display: ${habit.isCalendarDisplay ? "Yes" : "No"}"),
                        Text("Completed Today: ${habit.isCompletedToday ? "Yes" : "No"}"),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _editHabit(context, index); // Call edit function
                        } else if (value == 'delete') {
                          _confirmDelete(context, index);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
