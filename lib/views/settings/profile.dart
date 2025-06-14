import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/profile_info_card.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/utils/global_var.dart';
import 'package:wellnesshub/core/widgets/custom_profile_textfield.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadProfileImage();
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


  Future<void> _loadProfileImage() async {
  final prefs = await SharedPreferences.getInstance();
  final path = prefs.getString('profile_image_path');
  if (path != null && File(path).existsSync()) {
    setState(() {
      _imageFile = File(path);
    });
  }
  profileImageNotifier.value = _imageFile;
}

Future<void> _pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final directory = await getApplicationDocumentsDirectory();
    
    // Give each saved image a unique name using timestamp
    final imagePath = '${directory.path}/profile_${DateTime.now().millisecondsSinceEpoch}.png';

    final savedImage = await File(pickedFile.path).copy(imagePath);

    // Save path in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', savedImage.path);

    // Update notifier
    profileImageNotifier.value = File(savedImage.path);
  }
}

void _showNumberPickerDialog(String field) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  int currentValue;
  switch (field) {
    case 'Age':
      currentValue = int.tryParse(ageController.text) ?? 20;
      break;
    case 'Weight':
      currentValue = int.tryParse(weightController.text) ?? 60;
      break;
    case 'Height':
      currentValue = int.tryParse(heightController.text) ?? 170;
      break;
    default:
      currentValue = 0;
  }

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            backgroundColor: isDark? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 200, 200, 200),
            title: Text('Select $field'),
            content: SizedBox(
              height: 150,
              child: NumberPicker(
                selectedTextStyle: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
                textStyle: TextStyle(
                  color: isDark? Colors.white : Colors.black,
                  fontSize: 20
                ),
                value: currentValue,
                minValue: 0,
                maxValue: 200,
                onChanged: (newValue) {
                  setStateDialog(() {
                    currentValue = newValue;
                  });
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    switch (field) {
                      case 'Age':
                        age = currentValue ;
                        ageController.text = currentValue.toString();
                        break;
                      case 'Weight':
                        weight = currentValue ;
                        weightController.text = currentValue.toString();
                        break;
                      case 'Height':
                        height = currentValue ;
                        heightController.text = currentValue.toString();
                        break;
                    }
                  });
                  Navigator.pop(context);
                },
                child: const Text('Done', style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              )
            ],
          );
        },
      );
    },
  );
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppbar(title: "Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: profileImageNotifier,
              builder: (context,imageFile,_) {
                return GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: imageFile != null ? FileImage(imageFile) :
                    AssetImage('assets/default_avatar.png') as ImageProvider,
                    child: imageFile == null
                        ? const Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  ),
                );
              }
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
            AbsorbPointer(
              child: CustomTextFieldProfile(name: "Email", controller: emailController,
                readOnly: true,),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => _showNumberPickerDialog("Age"),
              child: AbsorbPointer(
                child: CustomTextFieldProfile(name: "Age", controller: ageController ,
                  readOnly: true, editable: true,),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => _showNumberPickerDialog("Weight"),
              child: AbsorbPointer(
                child: CustomTextFieldProfile(name: "Weight", controller: weightController,
                  readOnly: true , editable:  true,),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => _showNumberPickerDialog("Height"),
              child: AbsorbPointer(
                child: CustomTextFieldProfile(name: "Height", controller: heightController,
                  readOnly: true, editable: true,),
              ),
            ),

            const SizedBox(height: 25),
            CustomButton(
              name: "Update",
              width: 200,
              color: Colors.white,
              on_Pressed: ()async {
                String fullName = firstNameController.text;
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                print(lastNameController);
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

                int parsedAge = int.tryParse(ageController.text) ?? 0;
                int parsedWeight = int.tryParse(weightController.text) ?? 0;
                int parsedHeight = int.tryParse(heightController.text) ?? 0;

                await storage.saveUserAge(parsedAge);
                await storage.saveUserWeight(parsedWeight);
                await storage.saveUserHeight(parsedHeight);

                setState(() {
                  age = parsedAge;
                  weight = parsedWeight;
                  height = parsedHeight;
                });

              },
            ),
          ],
        ),
      ),
    );
  }
}
