import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/videos.dart';
import 'package:wellnesshub/core/widgets/navigation_bar.dart';
import 'package:wellnesshub/core/widgets/homepage_header.dart';
import 'package:wellnesshub/core/widgets/search_bar.dart';
import 'package:wellnesshub/core/widgets/categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) => setState(() => _selectedIndex = index),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 30),
              Header(),
              SizedBox(height: 10),
              SearchBarWidget(),
              SizedBox(height: 20),
              Categories(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
