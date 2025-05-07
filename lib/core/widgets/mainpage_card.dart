import 'package:flutter/material.dart';

class MainpageCard extends StatelessWidget {
  final String title;
  final String image;
  final String nextPage;

  const MainpageCard({
    Key? key,
    required this.title,
    required this.image,
    required this.nextPage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, nextPage);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.lightBlueAccent)
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.lightBlueAccent ,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child:
                  Image.asset(image , fit: BoxFit.fill,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
