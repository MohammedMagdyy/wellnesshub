import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/utils/global_var.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/getUserInfo_service.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String _name = "User"; // Use _name for private variable

  File? _profileImage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProfileImage();  // Force reload every time this widget is visible
    _initializeUserName(); // Optional: also refresh name
  }

  Future<void> _initializeUserName() async {
    final userData = await GetUserInfoService().getUserInfo();
    userNameNotifier.value = userData.firstName ?? " ";
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image_path');
    if (path != null) {
      final file = File(path);
      if (file.existsSync() && file.lengthSync() > 0) {
        profileImageNotifier.value = file;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Row(
        children: [
          ValueListenableBuilder<File?>(
            valueListenable: profileImageNotifier,
            builder: (context, imageFile, _) {
              return CircleAvatar(
                radius: screenWidth * 0.07,
                backgroundColor: Colors.grey,
                backgroundImage: imageFile != null && imageFile.existsSync()
                    ? FileImage(
                  imageFile,
                  scale: DateTime.now().millisecondsSinceEpoch.toDouble(), // 🔥 Bust cache
                )
                    : null,
                child: imageFile == null
                    ? Icon(
                  Icons.person,
                  size: screenWidth * 0.07,
                  color: Colors.white,
                )
                    : null,
              );
            },
          ),

          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<String>(
                  valueListenable: userNameNotifier,
                  builder: (context, name, _) {
                    return Text(
                      "Hi, $name",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: isDark? darkPrimaryTextColor : lightPrimaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                Text(
                  // Added const
                  "Let's make your body stronger today!",
                  style: TextStyle(
                    fontSize: 14, // Changed to a fixed value
                    color: isDark? darkSecondaryTextColor : lightSecondaryTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "Profile").then((_) {
                // Force HomePage (and Header) to rebuild when returning
                if (mounted) {
                  setState(() {});
                }
              });
            },
            child: Icon(
              Icons.person,
              size: screenWidth * 0.07,
              color: isDark? darkIconColor : lightIconColor,
            ),
          ),

        ],
      ),
    );
  }
}


