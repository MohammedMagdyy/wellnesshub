import 'package:flutter/material.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';

class HeightPage extends StatefulWidget {
  const HeightPage({super.key});

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: 150,
        child: SimpleRulerPicker(
          minValue: 100,
          maxValue: 300,
          initialValue: 150,
          onValueChanged: (value) {
            print("Selected value: $value");
          },
          scaleLabelSize: 16,
         
          scaleBottomPadding: 8,
          scaleItemWidth: 12,
          longLineHeight: 50,
          shortLineHeight: 15,
          lineColor: Colors.black,
          selectedColor: Colors.blue,
          labelColor: Colors.red,
          lineStroke: 5,
          height: 250,
          axis: Axis.vertical,
        ),
      ),
    );
  }
}
