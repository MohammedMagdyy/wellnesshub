import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';

class VersioninfoPage extends StatelessWidget {
  const VersioninfoPage({super.key});
  static const String routeName = 'VersioninfoPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "About Us"),
      body: SafeArea(
          child: Center(
        child: Text("Version Info"),
      )),
    );
  }
}
