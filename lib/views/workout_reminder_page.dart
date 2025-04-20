import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_workout_reminder.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class WorkoutReminderPage extends StatefulWidget {
  const WorkoutReminderPage({super.key});
  static const routeName = 'WorkoutReminder';

  @override
  State<WorkoutReminderPage> createState() => _WorkoutReminderPageState();
}

class _WorkoutReminderPageState extends State<WorkoutReminderPage> {
  List<Map<String, String>> reminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final remindersJson = jsonEncode(reminders);
    await prefs.setString('reminders', remindersJson);
  }

  Future<void> _loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final remindersJson = prefs.getString('reminders');
    if (remindersJson != null) {
      final List decoded = jsonDecode(remindersJson);
      setState(() {
        reminders = decoded.map<Map<String, String>>((e) => Map<String, String>.from(e)).toList();
      });
    }
  }

  void _showAddReminderDialog() {
    String title = '';
    String subtitle = '';
    final TextEditingController timeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("Add Workout Reminder"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => title = value,
              ),
              SizedBox(height: 10),
              TextField(
                controller: timeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Time",
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? pickedDateTime = await showOmniDateTimePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                    is24HourMode: true,
                    isShowSeconds: false,
                  );

                  if (pickedDateTime != null) {
                    subtitle =
                        "${pickedDateTime.hour.toString().padLeft(2, '0')}:${pickedDateTime.minute.toString().padLeft(2, '0')}";
                    timeController.text = subtitle;
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty && subtitle.isNotEmpty) {
                  setState(() {
                    reminders.add({'title': title, 'subtitle': subtitle});
                  });
                  _saveReminders(); // Save to SharedPreferences
                  Navigator.of(context).pop();
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Workout Reminder"),
      body: SafeArea(
        child: ListView.builder(
          itemCount: reminders.length,
          itemBuilder: (context, index) {
            return CustomWorkoutReminder(
              title: reminders[index]['title'] ?? '',
              subtitle: reminders[index]['subtitle'] ?? '',
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: "Add Workout Reminder",
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: _showAddReminderDialog,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
