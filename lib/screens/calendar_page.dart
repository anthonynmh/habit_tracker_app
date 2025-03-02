import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:habit_tracker_app/utils/habit_manager.dart';
import 'package:habit_tracker_app/models/habit.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final HabitManager _habitManager = HabitManager();
  List<Habit> _completedHabits = [];

  @override
  void initState() {
    super.initState();
    _habitManager.loadHabits().then((_) {
      setState(() {
        _completedHabits = _habitManager.getCompletedHabitsOn(_focusedDay);
      });
    });
  }

  void _updateCompletedHabits(DateTime date) {
    setState(() {
      _completedHabits = _habitManager.getCompletedHabitsOn(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calendar View")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _updateCompletedHabits(selectedDay);
            },
            onFormatChanged: (format) {
              setState(() => _calendarFormat = format);
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: ListView(
              children: _completedHabits
                  .map((habit) => ListTile(
                        title: Text(habit.name),
                        leading: Icon(Icons.check_circle, color: Colors.green),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
