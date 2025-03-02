import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/habit.dart';

Future<Habit?> showHabitInputDialog(BuildContext context, {Habit? initialHabit}) async {
  TextEditingController nameController = TextEditingController(text: initialHabit?.name ?? '');
  TextEditingController descriptionController = TextEditingController(text: initialHabit?.description ?? '');
  TextEditingController reminderController = TextEditingController(
    text: initialHabit?.reminderFrequency.toString() ?? '1',
  );
  bool isCalendarDisplay = initialHabit?.isCalendarDisplay ?? false;
  String category = initialHabit?.category ?? 'General';

  String? errorMessage;

  return showDialog<Habit>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(initialHabit == null ? "Enter Habit" : "Edit Habit"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Habit Name",
                    errorText: errorMessage,
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
                TextField(
                  controller: reminderController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Reminder Frequency (times/day)"),
                ),
                SwitchListTile(
                  title: const Text("Show in Calendar"),
                  value: isCalendarDisplay,
                  onChanged: (value) => setState(() => isCalendarDisplay = value),
                ),
                DropdownButtonFormField<String>(
                  value: category,
                  items: ['General', 'Health', 'Work', 'Personal'].map((cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat));
                  }).toList(),
                  onChanged: (value) => setState(() => category = value ?? 'General'),
                  decoration: const InputDecoration(labelText: "Category"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  String name = nameController.text.trim();
                  String description = descriptionController.text.trim();
                  int reminder = int.tryParse(reminderController.text) ?? 1;

                  if (name.isEmpty) {
                    setState(() => errorMessage = "Habit name cannot be empty!");
                    return;
                  }

                  Navigator.of(context).pop(
                    Habit(
                      name: name,
                      description: description,
                      reminderFrequency: reminder,
                      isCalendarDisplay: isCalendarDisplay,
                      category: category,
                      isCompletedToday: initialHabit?.isCompletedToday ?? false,
                    ),
                  );
                },
                child: const Text("Submit"),
              ),
            ],
          );
        },
      );
    },
  );
}
