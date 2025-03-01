import 'package:flutter/material.dart';
import 'package:habit_tracker_app/utils/habit_manager.dart';

Future<String?> showHabitInputDialog(BuildContext context, HabitManager habitManager) async {
  TextEditingController textController = TextEditingController();
  String? errorMessage;

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Enter Habit"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: "Type a habit...",
                    errorText: errorMessage,
                  ),
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
                  String userInput = textController.text;

                  if (userInput.trim().isEmpty) {
                    setState(() => errorMessage = "Habit cannot be empty!");
                    return;
                  }
                  if (habitManager.containsHabit(userInput)) {
                    setState(() => errorMessage = "This habit already exists!");
                    return;
                  }

                  Navigator.of(context).pop(userInput.trim());
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
