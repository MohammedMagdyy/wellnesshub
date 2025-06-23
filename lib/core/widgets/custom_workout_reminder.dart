import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:wellnesshub/constant_colors.dart';

class CustomWorkoutReminder extends StatefulWidget {
  const CustomWorkoutReminder({
    super.key,
    required this.title,
    required this.subtitle, // Format should be "HH:mm"
    required this.onDelete, // Add this
  });

  final String title;
  final String subtitle;
  final void Function() onDelete;

  @override
  State<CustomWorkoutReminder> createState() => _CustomWorkoutReminderState();
}

class _CustomWorkoutReminderState extends State<CustomWorkoutReminder> {
  bool isToggled = false;
  bool hasRungToday = false;
  Timer? timer;
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 30), (_) {
      _checkAlarm();
      _resetHasRungFlagAtMidnight();
    });
  }

  void _checkAlarm() async {
    if (!isToggled || hasRungToday) return;

    final now = DateTime.now();
    final parts = widget.subtitle.split(":");

    if (parts.length != 2) return;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) return;

    if (now.hour == hour && now.minute == minute) {
      await _player.play(AssetSource("sounds/mixkit-morning-clock-alarm-1003.wav"));
      setState(() {
        hasRungToday = true;
      });
    }
  }

  void _resetHasRungFlagAtMidnight() {
    final now = DateTime.now();
    if (now.hour == 0 && now.minute == 0 && hasRungToday) {
      setState(() {
        hasRungToday = false;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    _player.dispose();
    super.dispose();
  }

  void _showDeleteDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark? darkBmiContainerColor : lightBmiContainerColor,
          title: Text('Delete Reminder' ,
            style: TextStyle(
                fontSize: 22,
                color: isDark? darkBmiTextColor_1 : lightBmiTextColor_1,
                fontWeight: FontWeight.bold
            ),
          ),
          content: Text('Are you sure you want to delete this reminder?' ,
            style: TextStyle(
                color: isDark? darkBmiTextColor_2 : lightBmiTextColor_2,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancel
              child: Text('Cancel' ,
                style: TextStyle(
                  color: isDark? darkBmiTextColor_3 : lightBmiTextColor_3,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                widget.onDelete();
              },
              style: TextButton.styleFrom(
                backgroundColor: isDark? darkImportantButtonStart : lightImportantButtonStart,
              ),
              child: Text('Delete' ,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onLongPress: _showDeleteDialog,
        child: ListTile(
          title: Text(widget.title),
          titleTextStyle: TextStyle(
            color: isDark? darkSettingsBtnTextColor : lightSettingsBtnTextColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          subtitle: Text(widget.subtitle),
          subtitleTextStyle: TextStyle(
            fontSize: 18,
            color: isDark? darkSettingsBtnTextColor : lightSettingsBtnTextColor,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: isDark? darkSettingsButtonColor : lightSettingsButtonColor,
          leading: Icon(
            Icons.alarm,
            color: isDark? darkSettingsBtnTextColor : lightSettingsBtnTextColor,
          ),
          trailing: Switch(
            value: isToggled,
            onChanged: (value) {
              setState(() {
                isToggled = value;
              });
            },
            activeColor: isDark? darkSwitchThumbOnColor : lightSwitchThumbOnColor,
            activeTrackColor: isDark? darkSwitchTrackOnColor : lightSwitchTrackOnColor,
            inactiveThumbColor: isDark? darkSwitchThumbOffColor : lightSwitchThumbOffColor,
            inactiveTrackColor: isDark? darkSwitchTrackOffColor : lightSwitchTrackOffColor,
          ),
        ),
      ),
    );
  }
}
