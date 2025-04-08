import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/bmi_bar.dart';
import 'package:wellnesshub/core/widgets/bmi_infos.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';


class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double height = 180;
  double weight = 70;
  bool gender = true ;
  int age = 23 ;


  double calculateBMI(double height, double weight) {
    return weight / ((height / 100) * (height / 100));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        height = 180;
        weight = 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI(height, weight);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI Calculator ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff0095FF)
          ),
        ),
        
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 70 , horizontal: 10),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color.fromARGB(127, 157, 206, 255),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child:
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("Your BMI :" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text("${bmi.toStringAsFixed(1)}" , style: TextStyle(fontSize: 64 , color: Color(0xff0957DE) , fontWeight: FontWeight.bold),),
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
                          BmiInfos(label: "Gender", value: gender? "male" : "female"),
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
    );
  }
}
