import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/widgets/bmi_bar.dart';
import 'package:wellnesshub/core/widgets/bmi_infos.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import '../core/utils/global_var.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});
  static const routeName = 'BMIPage';

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  int height = 180;
  int weight = 70;
  bool gender = true;
  int age = 23;

  double calculateBMI(int height, int weight) {
    return weight / ((height / 100) * (height / 100));
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
    // Future.delayed(Duration(seconds: 5), () {
    //   setState(() {
    //     height = 180;
    //     weight = 50;
    //   });
    // });
  }

  Future<void> _loadUserData() async {
    final userAge = await storage.getUserAge();
    final userHeight = await storage.getUserHeight();
    final userWeight = await storage.getUserWeight();
    final userGender = await storage.getUserGender();

    if (mounted) {
      setState(() {
        age = userAge ?? 0;
        height = userHeight ?? 170;
        weight = userWeight ?? 80;
        gender = userGender == "male" ? true : false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI(height, weight);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppbar(title: "BMI Calculator"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 70, horizontal: 10),
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color:
                        isDark ? darkBmiContainerColor : lightBmiContainerColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: isDark? darkAppbarBackBorderColor : lightAppbarBackBorderColor,
                      width: 2.5
                    )
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Your BMI :",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? darkBmiTextColor_2
                                : lightBmiTextColor_2),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        bmi.toStringAsFixed(1),
                        style: TextStyle(
                            fontSize: 64,
                            color: isDark? darkBmiTextColor_1 : lightBmiTextColor_1,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BMIBar(bmi: bmi),
                      SizedBox(height: 15),
                      Divider(
                        color: isDark? darkButtonTextColor : lightButtonTextColor,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BmiInfos(label: "Weight", value: "$weight KG"),
                          BmiInfos(label: "Height", value: "$height cm"),
                          BmiInfos(label: "Age", value: "$age"),
                          BmiInfos(
                              label: "Gender",
                              value: gender ? "male" : "female"),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  name: "Show Fitness Plan",
                  width: 300,
                  color: isDark? darkButtonTextColor : lightButtonTextColor,
                  on_Pressed: () {
                    Navigator.pushNamed(context, 'FitnessPlanPage');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
