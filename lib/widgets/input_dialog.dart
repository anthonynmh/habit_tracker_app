import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/habit.dart';

Future<Habit?> showHabitInputDialog(BuildContext context, {Habit? initialHabit}) async {
  TextEditingController nameController = TextEditingController(text: initialHabit?.name ?? '');
  TextEditingController descriptionController = TextEditingController(text: initialHabit?.description ?? '');
  String category = initialHabit?.category ?? 'General';

  String? errorMessage;

  return showDialog<Habit>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(initialHabit == null ? "Enter Habit" : "Edit Habit"),
            content: SingleChildScrollView(
              child: Column(
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
                  DropdownButtonFormField<String>(
                    value: category,
                    items: ['General', 'Health', 'Work', 'Personal'].map((cat) {
                      return DropdownMenuItem(value: cat, child: Text(cat));
                    }).toList(),
                    onChanged: (value) => setState(() => category = value ?? 'General'),
                    decoration: const InputDecoration(labelText: "Category"),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
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

                  if (name.isEmpty) {
                    setState(() => errorMessage = "Habit name cannot be empty!");
                    return;
                  }

                  Navigator.of(context).pop(
                    Habit(
                      name: name,
                      description: description,
                      category: category,
                      completedDates: initialHabit?.completedDates ?? {},
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
