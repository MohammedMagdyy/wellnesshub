import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';

class ChallengeCard extends StatelessWidget {
  final String title;
  final String image;
  final String nextPage;

  const ChallengeCard({
    super.key,
    required this.title,
    required this.image,
    required this.nextPage
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, nextPage);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark? darkCardColor : lightCardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark? darkCardBorderColor : lightCardBorderColor)
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
                      color: isDark? darkCardTextColor : lightCardTextColor ,
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
