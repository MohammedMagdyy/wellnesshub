import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';

class CustomComingsoon extends StatelessWidget {
  const CustomComingsoon(
      {super.key,
      required this.title,
      this.image = Assets.assetsImagesCommingsoon});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: title),
      body: Stack(
        //fit: StackFit.expand,
        children: [
          Center(
            child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                )),
          ),

          // Center(
          //   child: Container(
          //     width: double.infinity,
          //     height: 120,
          //     color: const Color(0xFF0095FF),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Text(
          //           title,
          //           style: TextStyle(
          //             fontSize: 28,
          //             color: Colors.black,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         Text(
          //           'Coming Soon',
          //           style: TextStyle(fontSize: 24),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
