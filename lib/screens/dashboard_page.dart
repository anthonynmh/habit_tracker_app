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
  bool _showCompleted = false;

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

  void _editHabit(String habitName, Habit updatedHabit) {
    setState(() {
      habitManager.updateHabit(habitName, updatedHabit);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Separate completed and incomplete habits
    List<Habit> incompleteHabits = habitManager.habitsList.where((h) => !h.isCompletedToday).toList();
    List<Habit> completedHabits = habitManager.habitsList.where((h) => h.isCompletedToday).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Habit Tracker"),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              Habit? habit = await showHabitInputDialog(context);
              if (habit != null && !habitManager.dupeNameExists(habit)) _addHabit(habit);
            },
          ),
        ],
      ),
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        children: [
          // Incomplete Habits Section
          ListTile(
            title: Text("Incomplete Habits (${incompleteHabits.length})", style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: HabitList(
              habitsList: incompleteHabits,
              onDelete: _deleteHabit,
              onEdit: _editHabit,
            ),
          ),

          // Completed Habits Section
          ListTile(
            title: Text("Completed Habits (${completedHabits.length})", style: const TextStyle(fontWeight: FontWeight.bold)),
            trailing: IconButton(
              icon: Icon(_showCompleted ? Icons.expand_more : Icons.expand_less),
              onPressed: () {
                setState(() {
                  _showCompleted = !_showCompleted;
                });
              },
            ),
          ),
          if (_showCompleted)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35, // 50% of screen height
              child: HabitList(
                habitsList: completedHabits,
                onDelete: _deleteHabit,
                onEdit: _editHabit,
              ),
            ),
        ],
      ),
    );
  }
}
