import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

import '../../core/utils/global_var.dart';
import '../../core/widgets/custom_appbar.dart';

class YearPage extends StatefulWidget {
  const YearPage({super.key});
  static const routeName = 'AgePage';

  @override
  State<YearPage> createState() => _YearPageState();
}

class _YearPageState extends State<YearPage> {
  int _age = 20 ;

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
              "How old are you ?",
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
          '$_age',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark? darkBmiTextColor_1 : lightBmiTextColor_1,
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
            color: isDark? darkBmiContainerColor : lightBmiContainerColor,
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
                left: BorderSide(color: isDark? darkButtonTextColor:lightButtonTextColor, width: 1),
                right: BorderSide(color: isDark? darkButtonTextColor:lightButtonTextColor , width: 1)
              ),
              ),
            value: _age,
            minValue: 0,
            maxValue: 100,
            onChanged: (value) => setState(() => _age = value),
          ),
        ),
        SizedBox(height: 100,),
        CustomButton(name: "Continue", width: 200, color: Colors.black , on_Pressed: () async{
          await storage.saveUserAge(_age);
          Navigator.pushNamed(context, 'WeightPage');
        },)
      ],
    ),
    );
  }
}