import 'package:flutter/material.dart';

Future<String?> showHabitInputDialog(BuildContext context, List<String> habitsList) async {
  TextEditingController textController = TextEditingController();
  String? errorMessage;

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder( // Allows the dialog to rebuild when errorMessage changes
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
                    errorText: errorMessage, // Shows validation error
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(), // Close dialog
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  String userInput = textController.text.trim();

                  if (userInput.isEmpty) {
                    setState(() => errorMessage = "Habit cannot be empty!");
                    return;
                  }
                  if (habitsList.contains(userInput)) {
                    setState(() => errorMessage = "This habit already exists!");
                    return;
                  }

                  Navigator.of(context).pop(userInput); // Return valid input
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
