import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  int _weight = 70;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "What is your weight ?",
              style: TextStyle(
                color: Colors.black,
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
            color: Colors.black,
            fontSize: 50
          ),
          ),
        SizedBox(height: 50,),
        Image.asset(Assets.assetsImagesArrow),
        SizedBox(height: 50,),
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xff0095FF),
          ),
          child: NumberPicker(
            haptics: true,
            itemWidth: 120,
            axis: Axis.horizontal,
            selectedTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.bold
            ),
            textStyle: TextStyle(
              color: const Color.fromARGB(255, 57, 57, 57),
              fontSize: 20,
            ),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.black , width: 1),
                right: BorderSide(color: Colors.black , width: 1)
              ),
              ),
            value: _weight,
            minValue: 0,
            maxValue: 150,
            onChanged: (value) => setState(() => _weight = value),
          ),
        ),
        SizedBox(height: 100,),
        CustomButton(name: "Continue", width: 200, color: Colors.black , on_Pressed: () {
          Navigator.pushNamed(context, 'HeightPage');
        },)
      ],
    ),
    );
  }
}