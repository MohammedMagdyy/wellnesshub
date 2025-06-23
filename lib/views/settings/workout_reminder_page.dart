import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark? darkBmiContainerColor : lightBmiContainerColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("Add Workout Reminder" ,
            style: TextStyle(
              fontSize: 22,
              color: isDark? darkBmiTextColor_1 : lightBmiTextColor_1,
              fontWeight: FontWeight.bold
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style:TextStyle(color: isDark? darkChatInputTextColor : lightChatInputTextColor) ,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(color: isDark? darkChatInputTextColor : lightChatInputTextColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDark? darkChatInputBarFocusedBorderColor : lightChatInputBarFocusedBorderColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDark? darkChatInputBarEnabledBorderColor : lightChatInputBarEnabledBorderColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                onChanged: (value) => title = value,
              ),
              SizedBox(height: 10),
              TextField(
                controller: timeController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Time',
                  hintStyle: TextStyle(color: isDark? darkChatInputTextColor : lightChatInputTextColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDark? darkChatInputBarFocusedBorderColor : lightChatInputBarFocusedBorderColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDark? darkChatInputBarEnabledBorderColor : lightChatInputBarEnabledBorderColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
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
              child: Text("Cancel" ,
                style: TextStyle(
                  color: isDark? darkBmiTextColor_3 : lightBmiTextColor_3,
                ),
              ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark? darkImportantButtonStart : lightImportantButtonStart,
              ),
              child: Text("Add" ,
                style: TextStyle(
                  color: isDark? darkButtonTextColor : lightButtonTextColor
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppbar(title: "Workout Reminder"),
      body: SafeArea(
        child: ListView.builder(
          itemCount: reminders.length,
          itemBuilder: (context, index) {
            return CustomWorkoutReminder(
              title: reminders[index]['title'] ?? '',
              subtitle: reminders[index]['subtitle'] ?? '',
              onDelete: () {
              setState(() {
                reminders.removeAt(index);
              });
              _saveReminders();
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDark? darkButtonColor : lightButtonColor,
        tooltip: "Add Workout Reminder",
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: _showAddReminderDialog,
        child: Icon(Icons.add, color: isDark? darkButtonTextColor : lightButtonTextColor),
      ),
    );
  }
}
