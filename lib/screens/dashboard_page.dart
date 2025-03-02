import 'package:flutter/material.dart';
import 'package:habit_tracker_app/widgets/habit_list.dart';
import 'package:habit_tracker_app/widgets/input_dialog.dart';
import 'package:habit_tracker_app/utils/habit_manager.dart';
import 'package:habit_tracker_app/models/habit.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final HabitManager habitManager = HabitManager();

  @override
  void initState() {
    super.initState();
    habitManager.loadHabits().then((_) => setState(() {}));
  }

  void _addHabit(Habit habit) {
    setState(() {
      habitManager.addHabit(habit);
    });
  }

  void _deleteHabit(int index) {
    setState(() {
      habitManager.deleteHabit(index);
    });
  }

  void _editHabit(int index, Habit updatedHabit) {
    setState(() {
      habitManager.updateHabit(index, updatedHabit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Habits")),
      body: HabitList(
        habitsList: habitManager.habitsList,
        onDelete: _deleteHabit,
        onEdit: _editHabit, // Enable editing
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Habit? habit = await showHabitInputDialog(context);
          if (habit != null) _addHabit(habit);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
