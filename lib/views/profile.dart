import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/profile_info_card.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import '../core/utils/global_var.dart';
import '../core/widgets/custom_profile_textfield.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const routeName = 'Profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  // Data for display (can be split or parsed if needed)
  String fName = "User";
  String lName = " ";
  String email = " ";
  int age = 0;
  int weight = 0;
  int height = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await storage.getUserData();
    final userAge = await storage.getUserAge();
    final userHeight = await storage.getUserHeight();
    final userWeight = await storage.getUserWeight();

    if (mounted) {
      setState(() {
        fName = userData['fname'] ?? "User";
        lName = userData['lname'] ?? " ";
        email = userData['email'] ?? " ";
        age = userAge ?? 0;
        height = userHeight ?? 0;
        weight = userWeight ?? 0;

        firstNameController.text = fName;
        lastNameController.text = lName;
        emailController.text = email;
        ageController.text = age.toString();
        weightController.text = weight.toString();
        heightController.text = height.toString();
      });
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppbar(title: "Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              "$fName $lName",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              email,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileInfoCard(value: "$weight Kg", label: "Weight"),
                ProfileInfoCard(value: "$age", label: "Years Old"),
                ProfileInfoCard(value: "$height CM", label: "Height"),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextFieldProfile(name: "First Name", controller: firstNameController),
            const SizedBox(height: 15),
            CustomTextFieldProfile(name: "Last Name", controller: lastNameController),
            const SizedBox(height: 15),
            CustomTextFieldProfile(name: "Email", controller: emailController,
              readOnly: true,),
            const SizedBox(height: 15),
            CustomTextFieldProfile(name: "Age", controller: ageController),
            const SizedBox(height: 15),
            CustomTextFieldProfile(name: "Weight", controller: weightController),
            const SizedBox(height: 15),
            CustomTextFieldProfile(name: "Height", controller: heightController),

            const SizedBox(height: 25),
            CustomButton(
              name: "Update",
              width: 200,
              color: Colors.white,
              on_Pressed: () {
                String fullName = firstNameController.text;
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                print(lastNameController);
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
              },
            ),
          ],
        ),
      ),
    );
  }
}
