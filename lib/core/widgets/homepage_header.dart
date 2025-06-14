import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/global_var.dart';

import '../helper_class/userInfo_local.dart';
import '../services/getUserInfo_service.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String _name = "User"; // Use _name for private variable

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {

      final userData = await getUserInfoService().getUserInfo();
      await UserInfoLocalStorage.saveUserInfoForProfile(userData);
      if (mounted) {
        setState(() {
          _name = userData.firstName?? "User";
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Row(
        children: [
          CircleAvatar(
            radius: screenWidth * 0.07,
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.person,
              size: screenWidth * 0.07,
              color: Colors.white,
            ),
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
                    color: const Color(0xff0095FF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text( // Added const
                  "Let's make your body stronger today!",
                  style: TextStyle(
                    fontSize: 14, // Changed to a fixed value
                    color: Color(0xff0095FF),
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
              size: screenWidth * 0.065,
              color: const Color(0xff0095FF),
            ),
          ),
        ],
      ),
    );
  }
}