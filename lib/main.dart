import 'package:flutter/material.dart';
import 'package:wellnesshub/core/helper_functions/on_generate_route.dart';
// import 'package:wellnesshub/views/sign_in.dart';
import 'package:wellnesshub/views/test.dart';

void main() {
  runApp(WellnessHub());
}

class WellnessHub extends StatelessWidget {
  const WellnessHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: OnGenerateRoute,
      initialRoute: Test.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}

/*
color: Theme.of(context).brightness == Brightness.dark
    ? Colors.white
    : Colors.black

*/