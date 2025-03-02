import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/habit.dart';
import 'package:habit_tracker_app/widgets/input_dialog.dart';

class HabitList extends StatelessWidget {
  final List<Habit> habitsList;
  final Function(int) onDelete;
  final Function(String, Habit) onEdit;

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

  void _editHabit(BuildContext context, String habitName) async {
    int index = habitsList.indexWhere((habit) => habit.name == habitName);
    Habit? updatedHabit = await showHabitInputDialog(context, initialHabit: habitsList[index]);
    if (updatedHabit != null) {
      onEdit(habitName, updatedHabit);
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1 - Category with filled secondary color
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          habit.category,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row 2 - Name, Spacer, Calendar, Popup Menu
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    habit.name,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  habit.isCalendarDisplay ? Icons.calendar_today : Icons.calendar_month_outlined,
                                  color: theme.colorScheme.secondary,
                                ),
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      _editHabit(context, habit.name);
                                    } else if (value == 'delete') {
                                      _confirmDelete(context, index);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                                    const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                                  ],
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 8),

                            // Row 3 - Description with fixed height and outline
                            Container(
                              height: 50,
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                habit.description.isNotEmpty ? habit.description : "No description provided",
                                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Row 4 - Frequency, Spacer, Completion Status
                            Row(
                              children: [
                                Text(
                                  "Remind: ${habit.reminderFrequency}x/day",
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Habit updatedHabit = Habit(
                                      name: habit.name,
                                      category: habit.category,
                                      reminderFrequency: habit.reminderFrequency,
                                      isCalendarDisplay: habit.isCalendarDisplay,
                                      description: habit.description,
                                      isCompletedToday: !habit.isCompletedToday,
                                    );
                                    onEdit(habit.name, updatedHabit);
                                  },
                                  child: Row(
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
