import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/homepage_header.dart';
import 'package:wellnesshub/core/widgets/search_bar.dart';
import 'package:wellnesshub/core/widgets/categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Header(),
            const SizedBox(height: 30),
            SearchBarWidget(),
            const SizedBox(height: 20),
            // Wrap Categories in an Expanded or Flexible if necessary
            const Categories(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
