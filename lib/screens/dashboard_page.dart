import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:habit_tracker_app/widgets/habit_list.dart';
import 'package:habit_tracker_app/widgets/input_dialog.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<String> habitsList = [];
  bool isDeleteMode = false;

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      habitsList = prefs.getStringList('habits') ?? []; // Defaults to empty list
    });
  }

  Future<void> _saveHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    if (habitsList.isEmpty) {
      await prefs.remove('habits'); // Remove key if list is empty
    } else {
      await prefs.setStringList('habits', habitsList);
    }
  }

  void _addHabit(String habit) {
    setState(() {
      habitsList.add(habit);
    });
    _saveHabits();
  }

  void _deleteHabit(int index) {
    setState(() {
      habitsList.removeAt(index);
    });
    _saveHabits();

    // default to non-deleteMode when no habits
    if (habitsList.isEmpty) {
      _toggleDeleteMode();
    }
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
