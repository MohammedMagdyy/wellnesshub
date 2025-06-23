import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/bmi_bar.dart';
import 'package:wellnesshub/core/widgets/bmi_infos.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import '../core/helper_class/accesstoken_storage.dart';
import '../core/services/getUserInfo_service.dart';
import '../core/utils/global_var.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});
  static const routeName = 'BMIPage';

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double height = 180;
  int weight = 70;
  String gender = 'Unknown' ;
  int age = 23 ;


  double calculateBMI(double height, int weight) {
    return weight / ((height / 100) * (height / 100));
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();

  }
  Future<void> _loadUserData() async {
    final userData = await GetUserInfoService().getUserInfo();
    final userAge = userData.age;
    final userHeight = userData.height;
    final userWeight = userData.weight;
    final userGender = userData.gender;

    if (mounted) {
      setState(() {
        age = userAge ?? 0;
        height = userHeight ?? 170;
        weight = userWeight ?? 80;
        gender = userGender ;
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
        child:SingleChildScrollView(
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 70 , horizontal: 10),
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: isDark? Color(0xff9DCEFF) : Color.fromARGB(127, 157, 206, 255),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child:
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("Your BMI :" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text(bmi.toStringAsFixed(1) , style: TextStyle(fontSize: 64 , color: Color(0xff0957DE) , fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      BMIBar(bmi: bmi),
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BmiInfos(label: "Weight", value: "$weight KG"),
                          BmiInfos(label: "Height", value: "$height cm"),
                          BmiInfos(label: "Age", value: "$age"),
                          BmiInfos(label: "Gender", value: gender),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  name: "Show Fitness Plan",
                  width: 300,
                  color: Colors.white,
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
