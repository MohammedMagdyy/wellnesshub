import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/profile_info_card.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static const routeName = 'Profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Colors.grey, child: Icon(Icons.person, size: 50, color: Colors.white)),
            const SizedBox(height: 10),
            const Text("Madison Smith", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("madisons@example.com", style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                ProfileInfoCard(value: "75 Kg", label: "Weight"),
                ProfileInfoCard(value: "24", label: "Years Old"),
                ProfileInfoCard(value: "165 CM", label: "Height"),
              ],
            ),
            const SizedBox(height: 20),
            const CustomTextfield(name: "Full Name"),
            const SizedBox(height: 15),
            const CustomTextfield(name: "Email"),
            const SizedBox(height: 15),
            const CustomTextfield(name: "Mobile Number"),
            const SizedBox(height: 15),
            const CustomTextfield(name: "Date of Birth"),
            const SizedBox(height: 15),
            const CustomTextfield(name: "Weight"),
            const SizedBox(height: 15),
            const CustomTextfield(name: "Height"),
            const SizedBox(height: 25),
            CustomButton(
              name: "Update Profile",
              width: 200,
              color: Colors.white,
              on_Pressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
