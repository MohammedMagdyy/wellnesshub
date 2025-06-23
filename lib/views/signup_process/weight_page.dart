import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

import '../../core/services/auth/signup_service.dart';
import '../../core/utils/global_var.dart';
import '../../core/widgets/custom_appbar.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});
  static const routeName = 'WeightPage';

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {

  int _weight = 70;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppbar(title: "",),
      body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "What is your weight ?",
              style: TextStyle(
                color: isDark? darkPrimaryTextColor : lightPrimaryTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
            )
          ],
        ),
        SizedBox(height: 150,),
        Text(
          '$_weight Kg',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark? darkBmiTextColor_1:lightBmiTextColor_1,
            fontSize: 50
          ),
          ),
        SizedBox(height: 50,),
        Image.asset(Assets.assetsImagesArrow , color: isDark? darkButtonTextColor : lightButtonTextColor,),
        SizedBox(height: 50,),
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: isDark? darkBmiContainerColor:lightBmiContainerColor,
          ),
          child: NumberPicker(
            haptics: true,
            itemWidth: 120,
            axis: Axis.horizontal,
            selectedTextStyle: TextStyle(
              color: isDark? darkButtonTextColor:lightButtonTextColor,
              fontSize: 35,
              fontWeight: FontWeight.bold
            ),
            textStyle: TextStyle(
              color: isDark?darkButtonTextInactiveColor:lightButtonTextInactiveColor,
              fontSize: 20,
            ),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: isDark? darkButtonTextColor:lightButtonTextColor , width: 1),
                right: BorderSide(color: isDark? darkButtonTextColor:lightButtonTextColor , width: 1)
              ),
              ),
            value: _weight,
            minValue: 0,
            maxValue: 150,
            onChanged: (value) => setState(() => _weight = value),
          ),
        ),
        SizedBox(height: 100,),
        CustomButton(
          name: "Continue",
          width: 200,
          color: Colors.black,
          on_Pressed: () async {
            await storage.saveUserWeight(_weight);
            Navigator.pushNamed(context, 'HeightPage');

          },
        )
      ],
    ),
    );
  }
}