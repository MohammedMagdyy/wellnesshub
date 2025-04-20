import 'package:flutter/material.dart';

void showFontSizePicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select Font Size',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            ListTile(
              leading: Icon(Icons.font_download),
              title: Text('Small'),
              onTap: () {
                // handle language change here
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.font_download),
              title: Text('Meduim'),
              onTap: () {
                // handle language change here
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.font_download),
              title: Text('Large'),
              onTap: () {
                // handle language change here
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
