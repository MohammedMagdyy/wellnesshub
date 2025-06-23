import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/views/bmi_calculator.dart';
import 'package:wellnesshub/views/favorites.dart';
import 'package:wellnesshub/views/homepage.dart';
import 'package:wellnesshub/views/progress.dart';
import 'package:wellnesshub/views/settings/setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.selectedIndex});
  final int selectedIndex;
  static const routeName = 'MainPage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;

  final List<Widget> _pages = [
    const HomePage(),
    const ProgressPage(),
    const FavoritesPage(),
    const BMICalculator(),
     SettingPage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Adjust icon size based on screen width
    final iconSize = screenWidth * 0.06; // ~24 for 400px wide screens
    final tabPadding = EdgeInsets.symmetric(
      horizontal: screenWidth * 0.04,
      vertical: screenHeight * 0.015,
    );

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? darkBackgroundColor : lightBackgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              rippleColor: isDark ? darkButtonColor : lightButtonColor,
              hoverColor: isDark ? darkButtonColor : lightButtonColor,
              backgroundColor: isDark ? darkBackgroundColor : lightBackgroundColor,
              gap: screenWidth * 0.01,
              activeColor: isDark ? darkNavBarBackgroundColor : lightNavBarBackgroundColor,
              iconSize: iconSize,
              padding: tabPadding,
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: isDark ? darkNavBarIconActiveColor : lightNavBarIconActiveColor,
              color: isDark ? darkNavBarIconInactiveColor : lightNavBarIconInactiveColor,
              tabs: const [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.show_chart, text: 'Progress'),
                GButton(icon: Icons.favorite, text: 'Favourites'),
                GButton(icon: Icons.calculate, text: 'BMI'),
                GButton(icon: Icons.settings, text: 'Settings'),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() => _selectedIndex = index);
              },
            ),
          ),
        ),
      ),
    );
  }

}
