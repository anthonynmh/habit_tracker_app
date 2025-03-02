import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/habit.dart';
import 'package:habit_tracker_app/widgets/input_dialog.dart';

class HabitList extends StatelessWidget {
  final List<Habit> habitsList;
  final Function(int) onDelete;
  final Function(int, Habit) onEdit;

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
      onEdit(index, updatedHabit);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              habit.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const Spacer(),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  _editHabit(context, index);
                                } else if (value == 'delete') {
                                  _confirmDelete(context, index);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildInfoChip(Icons.category, habit.category),
                              _buildInfoChip(Icons.access_alarm, "Remind: ${habit.reminderFrequency}x/day"),
                              _buildInfoChip(
                                habit.isCalendarDisplay ? Icons.calendar_today : Icons.calendar_month_outlined,
                                habit.isCalendarDisplay ? "Calendar: Yes" : "Calendar: No",
                              ),
                              if (habit.description.isNotEmpty)
                                _buildInfoChip(Icons.note, habit.description),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              habit.isCompletedToday ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: habit.isCompletedToday ? Colors.green : Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              habit.isCompletedToday ? "Completed Today" : "Not Completed",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: habit.isCompletedToday ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  // Helper Function for Info Chips
  Widget _buildInfoChip(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Chip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.grey.shade600,
      ),
    );
  }
}
