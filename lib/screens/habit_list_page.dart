import 'package:flutter/material.dart';

class HabitList extends StatelessWidget {
  final List<String> habitsList;

  const HabitList({super.key, required this.habitsList});

  @override
  Widget build(BuildContext context, ) {
    return habitsList.isEmpty
      ? Center(
          child: Text(
            "No habits added yet.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        )
      : ListView.builder(
          itemCount: habitsList.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 50,
              child: Center(
                child: Text(habitsList[index]),
              ),
            );
          },
        );
  }
}
