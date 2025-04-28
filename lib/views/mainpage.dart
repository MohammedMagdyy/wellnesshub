import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wellnesshub/views/bmi_calculator.dart';
import 'package:wellnesshub/views/favorites.dart';
import 'package:wellnesshub/views/homepage.dart';
import 'package:wellnesshub/views/progress.dart';
import 'package:wellnesshub/views/setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static const routeName = 'MainPage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ProgressPage(),
    FavoritesPage(),
    BMICalculator(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GNav(
                rippleColor: Colors.blueGrey,
                hoverColor: Colors.blue,
                backgroundColor: Colors.white,
                gap: 4,
                activeColor: Colors.white,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.blue,
                color: Colors.blueAccent,
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
      ),
    );
  }
}
