import 'package:flutter/material.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

import '../../core/utils/global_var.dart';
import '../../core/widgets/custom_appbar.dart';

class HeightPage extends StatefulWidget {
  const HeightPage({super.key});
   static const routeName = 'HeightPage';

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  int _height = 170;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppbar(
        title: "Height Selection",
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "What is your height ?",
                style: TextStyle(
                  color: isDark? darkPrimaryTextColor:lightPrimaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
              )
            ],
          ),
          SizedBox(height: 70,),
          Text(
            '$_height cm',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark? darkBmiTextColor_1 : lightBmiTextColor_1,
              fontSize: 50
            ),
            ),
          Container(
            height: 300,
            width: 130,
            margin: EdgeInsets.all(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isDark? darkBmiContainerColor : lightBmiContainerColor,
            ),
            // padding: EdgeInsets.symmetric(horizontal: 90),
            child: SimpleRulerPicker(
              axis: Axis.vertical,
              height: 150,
              initialValue: _height,
              labelColor: isDark? darkButtonTextColor : lightButtonTextColor,
              lineColor: isDark? darkButtonTextColor : lightButtonTextColor,
              maxValue: 280,
              minValue: 100,
              selectedColor: isDark? darkBmiTextColor_1 : lightBmiTextColor_1,
              scaleBottomPadding: 15,
              scaleLabelSize: 15,
              onValueChanged: (value) => setState(() => _height = value),
              
            ),
          ),
          SizedBox(height: 10,),
          CustomButton(name: "Continue", width: 200, color: Colors.black , on_Pressed: ()async {
            await storage.saveUserHeight(_height);
            Navigator.pushNamed(context, 'GenderPage');
          },)
          ],
        ),
      ),
    );
  }
}