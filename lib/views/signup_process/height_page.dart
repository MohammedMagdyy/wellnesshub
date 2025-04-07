import 'package:flutter/material.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
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
                  color: Colors.black,
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
              color: Colors.black,
              fontSize: 50
            ),
            ),
          Container(
            height: 300,
            width: 130,
            margin: EdgeInsets.all(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xff80C9FC),
            ),
            // padding: EdgeInsets.symmetric(horizontal: 90),
            child: SimpleRulerPicker(
              axis: Axis.vertical,
              height: 150,
              initialValue: _height,
              labelColor: Colors.black,
              lineColor: Colors.black,
              maxValue: 280,
              minValue: 100,
              selectedColor: Color(0xff0095ff),
              scaleBottomPadding: 15,
              scaleLabelSize: 15,
              onValueChanged: (value) => setState(() => _height = value),
              
            ),
          ),
          SizedBox(height: 10,),
          CustomButton(name: "Continue", width: 200, color: Colors.black , on_Pressed: () {
            Navigator.pushNamed(context, 'GoalPage');
          },)
          ],
        ),
      ),
    );
  }
}