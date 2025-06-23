import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';

class ChallengePlank extends StatefulWidget {
  const ChallengePlank({super.key});
  static const routeName = 'Plank';

  @override
  State<ChallengePlank> createState() => _ChallengePlankState();
}

class _ChallengePlankState extends State<ChallengePlank> {
  int totalSeconds = 120;
  int currentSeconds = 120;
  Timer? timer;
  bool hasStarted = false;

  // Light mode (Sunrise Serenity) theme colors
  final Color lightBackgroundColor = const Color(0xFFFDF8F2); // Soft ivory
  final Color lightPrimaryTextColor = const Color(0xFF3A2D2D); // Deep cocoa
  final Color lightSecondaryTextColor = const Color(0xFF867070); // Muted mauve
  final Color lightImportantButtonStart = const Color(0xFFFF9A6C); // Bright coral
  final Color lightImportantButtonEnd = const Color(0xFFFF6F61); // Passion orange
  final Color lightButtonColorInactive = const Color(0xFFF2E5D7); // Almond milk
  final Color lightCardBorderColor = const Color(0xFFE8D5C5); // Soft cinnamon

  // Dark mode theme colors
  final Color darkBackgroundColor = const Color(0xFF1A1A1A); // Deep charcoal
  final Color darkPrimaryTextColor = const Color(0xFFEADBCB); // Warm ivory
  final Color darkSecondaryTextColor = const Color(0xFFB9AFA7); // Earth clay
  final Color darkImportantButtonStart = const Color(0xFFFF8C5E); // Flame orange
  final Color darkImportantButtonEnd = const Color(0xFFFF5F49); // Bold sunrise
  final Color darkButtonColorInactive = const Color(0xFF3A3A3A); // Midnight slate
  final Color darkCardBorderColor = const Color(0xFF3F3F3F); // Coal edge

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentSeconds > 0) {
        setState(() {
          currentSeconds--;
        });
      } else {
        timer.cancel();
        _showCongratsDialog();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _showCongratsDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.celebration,
                          size: 60,
                          color: isDark
                              ? darkImportantButtonStart
                              : lightImportantButtonStart,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "🎉 Congratulations! 🎉",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? darkPrimaryTextColor
                                : lightPrimaryTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            currentSeconds = totalSeconds;
                            hasStarted = false;
                          });
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: isDark
                                ? darkImportantButtonStart
                                : lightImportantButtonStart,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showMotivationDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_alarm,
                          size: 60,
                          color: isDark
                              ? darkImportantButtonStart
                              : lightImportantButtonStart,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "💪 YOU CAN DO BETTER NEXT TIME 💪",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? darkPrimaryTextColor
                                : lightPrimaryTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            currentSeconds = totalSeconds;
                            hasStarted = false;
                          });
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: isDark
                                ? darkImportantButtonStart
                                : lightImportantButtonStart,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: isDark? darkBackgroundColor : lightBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: isDark ? darkCardBorderColor : lightCardBorderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: (isDark ? darkSecondaryTextColor : lightSecondaryTextColor)
                .withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(Assets.assetsImagesPlank),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildTimerButton() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    double percent = currentSeconds / totalSeconds;
    int minutes = currentSeconds ~/ 60;
    int seconds = currentSeconds % 60;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(150),
        onTap: () {
          if (!hasStarted) {
            startTimer();
            setState(() {
              hasStarted = true;
            });
          } else {
            timer?.cancel();
            setState(() {
              _showMotivationDialog();
            });
          }
        },
        child: CircularPercentIndicator(
          header: Column(
            children: [
              Text(
                "Press Here",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: isDark ? darkPrimaryTextColor : lightPrimaryTextColor,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
          radius: 150,
          lineWidth: 12,
          percent: percent.clamp(0.0, 1.0),
          center: Text(
            "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: isDark ? darkPrimaryTextColor : lightPrimaryTextColor,
            ),
          ),
          backgroundColor:
          isDark ? darkButtonColorInactive : lightButtonColorInactive,
          linearGradient: LinearGradient(
            colors: [
              isDark ? darkImportantButtonStart : lightImportantButtonStart,
              isDark ? darkImportantButtonEnd : lightImportantButtonEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          circularStrokeCap: CircularStrokeCap.round,
          animation: false,
          animationDuration: 300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppbar(title: "Plank Challenge"),
      backgroundColor: isDark ? darkBackgroundColor : lightBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildImageCard(),
            Expanded(child: Center(child: _buildTimerButton())),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
