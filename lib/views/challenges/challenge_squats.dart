import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ChallengeSquats extends StatefulWidget {
  const ChallengeSquats({super.key});
  static const routeName = 'Squats';

  @override
  State<ChallengeSquats> createState() => _ChallengeSquatsState();
}

class _ChallengeSquatsState extends State<ChallengeSquats> {
  double progress = 0;
  int counter = 0;

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
                            color: isDark ? darkPrimaryTextColor : lightPrimaryTextColor,
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
                            counter = 0;
                            progress = 0;
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
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark? darkBackgroundColor : lightBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? darkCardBorderColor : lightCardBorderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: (isDark ? darkSecondaryTextColor : lightSecondaryTextColor).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(Assets.assetsImagesSquats),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildCounterButton() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(150),
        onTap: () {
          setState(() {
            counter++;
            progress = counter / 20;
            if (counter >= 20) {
              Future.delayed(const Duration(milliseconds: 100), () {
                _showCongratsDialog();
              });
            }
          });
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
          percent: progress.clamp(0.0, 1.0),
          center: Text(
            "$counter",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: isDark ? darkPrimaryTextColor : lightPrimaryTextColor,
            ),
          ),
          backgroundColor: isDark ? darkButtonColorInactive : lightButtonColorInactive,
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
      appBar: CustomAppbar(title: "Squats Challenge"),
      backgroundColor: isDark ? darkBackgroundColor : lightBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildImageCard(),
            const SizedBox(height: 24),
            Expanded(child: Center(child: _buildCounterButton())),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Every squat builds strength. Stay focused and feel the burn!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? darkSecondaryTextColor : lightSecondaryTextColor,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
