import 'package:flutter/material.dart';
import 'package:habit_tracker_app/screens/habit_list_page.dart';
import 'package:habit_tracker_app/widgets/input_dialog.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final habitsList = <String>[];
  bool isDeleteMode = false;

  void _addHabit(String habit) {
    setState(() {
      habitsList.add(habit);
    });
  }

  void _deleteHabit(int index) {
    setState(() {
      habitsList.removeAt(index);
    });
  }

  void _toggleDeleteMode() {
    setState(() {
      isDeleteMode = !isDeleteMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Habits"),
        actions: habitsList.isNotEmpty
          ? [
              IconButton(
                icon: Icon(isDeleteMode ? Icons.cancel : Icons.delete),
                onPressed: _toggleDeleteMode,
              ),
            ]
          : null,
      ),
      body: HabitList(
        habitsList: habitsList,
        onDelete: _deleteHabit,
        isDeleteMode: isDeleteMode,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? habit = await showHabitInputDialog(context, habitsList);
          if (habit != null) _addHabit(habit);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
