import 'package:flutter/material.dart';
import 'package:wellnesshub/widgets/custom_comingsoon.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomComingsoon(
      title: "Community Page",
      image: "assets/Community.jpeg"
      );
  }
}