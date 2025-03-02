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
  DateTime _selectedDate = DateTime.now();

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

  void _toggleHabitCompletion(String habitName, DateTime date) {
    setState(() {
      habitManager.toggleHabitCompletion(habitName, date);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Separate completed and incomplete habits based on the selected date
    List<Habit> incompleteHabits = habitManager.habitsList
        .where((h) => !h.isCompletedOn(_selectedDate))
        .toList();
    List<Habit> completedHabits = habitManager.habitsList
        .where((h) => h.isCompletedOn(_selectedDate))
        .toList();

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
              if (habit != null) _addHabit(habit);
            },
          ),
        ],
      ),
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        children: [
          // Date Picker Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _selectedDate =
                          _selectedDate.subtract(const Duration(days: 1));
                    });
                  },
                ),
                Text(
                  "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}",
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _selectedDate =
                          _selectedDate.add(const Duration(days: 1));
                    });
                  },
                ),
              ],
            ),
          ),

          // Incomplete Habits Section
          ListTile(
            title: Text("Incomplete Habits (${incompleteHabits.length})",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: HabitList(
              habitsList: incompleteHabits,
              onToggleCompletion: _toggleHabitCompletion,
              onDelete: _deleteHabit,
              onEdit: _editHabit,
              selectedDate: _selectedDate,
            ),
          ),

          // Completed Habits Section
          ListTile(
            title: Text("Completed Habits (${completedHabits.length})",
                style: const TextStyle(fontWeight: FontWeight.bold)),
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
              height: MediaQuery.of(context).size.height * 0.35, // 35% of screen height
              child: HabitList(
                habitsList: completedHabits,
                onToggleCompletion: _toggleHabitCompletion,
                onDelete: _deleteHabit,
                onEdit: _editHabit,
                selectedDate: _selectedDate,
              ),
            ),
        ],
      ),
    );
  }
}
