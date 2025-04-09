import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_comingsoon.dart';

class RateAppPage extends StatelessWidget {
  const RateAppPage({super.key});
  static const String routeName = 'RateAppPage';

  @override
  Widget build(BuildContext context) {
    return CustomComingsoon(
        title: "Rate App", image: Assets.assetsImagesCommingsoon);
  }
}
