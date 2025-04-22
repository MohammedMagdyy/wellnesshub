import 'package:flutter/material.dart';

void showLanguagePicker(BuildContext context) {
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
            Text('Select Language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('English'),
              onTap: () {
                // handle language change here
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('العربية'),
              onTap: () {
                // handle language change here
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Français'),
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
