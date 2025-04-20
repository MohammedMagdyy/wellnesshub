import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CustomWorkoutReminder extends StatefulWidget {
  const CustomWorkoutReminder({
    super.key,
    required this.title,
    required this.subtitle, // Format should be "HH:mm"
  });

  final String title;
  final String subtitle;

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: ListTile(
        title: Text(widget.title),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        subtitle: Text(widget.subtitle),
        subtitleTextStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: const Icon(Icons.alarm),
        trailing: Switch(
          value: isToggled,
          onChanged: (value) {
            setState(() {
              isToggled = value;
            });
          },
          activeColor: Colors.white,
          activeTrackColor: Colors.blue,
          inactiveThumbColor: Colors.blueAccent,
          inactiveTrackColor: Colors.white,
        ),
      ),
    );
  }
}
