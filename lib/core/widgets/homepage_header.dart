import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/utils/global_var.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper_class/userInfo_local.dart';
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
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadProfileImage();
  }

  Future<void> _loadUserInfo() async {
    final userData = await getUserInfoService().getUserInfo();
    await UserInfoLocalStorage.saveUserInfoForProfile(userData);
    if (mounted) {
      setState(() {
        _name = userData.firstName ?? "User";
      });
    }
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image_path');
    if (path != null && mounted) {
      setState(() {
        _profileImage = File(path);
      });
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
                backgroundImage:
                    imageFile != null ? FileImage(imageFile) : null,
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
                Text(
                  "Hi, $_name", // Use _name here
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: isDark? darkPrimaryTextColor : lightPrimaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
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
              Navigator.pushNamed(context, "Profile");
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
