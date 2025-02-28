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

  void _addHabit(String habit) {
    setState(() {
      habitsList.add(habit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HabitList(habitsList: habitsList),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => _showInputDialog(),
        onPressed: () async {
          String? habit = await showHabitInputDialog(context, habitsList);
          if (habit != null) _addHabit(habit);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
