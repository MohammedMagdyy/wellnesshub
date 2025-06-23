import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/profile_info_card.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import '../../core/models/update_model.dart';
import '../../core/services/auth/updateprofile_service.dart';
import '../../core/services/getUserInfo_service.dart';
import '../../core/utils/global_var.dart';
import '../../core/widgets/custom_profile_textfield.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/helper_functions/build_customSnackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

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
  File? _imageFile;
  double height = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadProfileImage();
  }

  Future<void> _loadUserData() async {
    //final storedUserData = await UserInfoLocalStorage.getUserInfoForProfile();
    final userData = await GetUserInfoService().getUserInfo();



    if (mounted) {
      setState(() {
        fName=userData.firstName;
        lName=userData.lastName;
        email=userData.email;
        age=userData.age;
        height=userData.height;
        weight=userData.weight;

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
    try {
      final file = await UpdateProfileService().downloadProfilePicture();

      if (file != null && file.existsSync() && file.lengthSync() > 0) {
        setState(() {
          _imageFile = null;
          profileImageNotifier.value = null;

          _imageFile = file;
          profileImageNotifier.value = file;
        });

      } else {
        print("Profile image file not found or empty.");
      }
    } catch (e) {
      print("Error loading profile picture: $e");
    }
  }




  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);

      try {
        await UpdateProfileService().uploadProfilePicture(file);

        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/profile_uploaded.png';
        final savedImage = await file.copy(imagePath);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image_path', savedImage.path);

        setState(() {
          _imageFile = savedImage;
          profileImageNotifier.value = savedImage;
          profileImageVersionNotifier.value++;
        });

        final snackBar = buildCustomSnackbar(
          title: 'Success!',
          message: 'Profile picture updated.',
          backgroundColor: Colors.green,
          type: ContentType.success,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        final snackBar = buildCustomSnackbar(
          title: 'Error!',
          message: 'Upload failed: ${e.toString()}',
          backgroundColor: Colors.red,
          type: ContentType.failure,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }


void _showNumberPickerDialog(String field) {
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
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            backgroundColor: isDark? darkBmiContainerColor : lightBmiContainerColor,
            title: Text('Select $field'),
            content: SizedBox(
              height: 150,
              child: NumberPicker(
                selectedTextStyle: TextStyle(
                  color: isDark? darkBmiTextColor_1:lightBmiTextColor_1,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
                textStyle: TextStyle(
                  color: isDark? darkBmiTextColor_2 :lightBmiTextColor_2 ,
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
                        height = currentValue.toDouble() ;
                        heightController.text = currentValue.toString();
                        break;
                    }
                  });
                  Navigator.pop(context);
                },
                child: Text('Done', style: TextStyle(
                  color: isDark? darkImportantButtonEnd : lightImportantButtonEnd,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar:  CustomAppbar(title: "Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: profileImageNotifier,
              builder: (context, imageFile, _) {
                return GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: imageFile != null && imageFile.existsSync()
                        ? FileImage(imageFile, scale: DateTime.now().millisecondsSinceEpoch.toDouble()) // force reload
                        : const AssetImage('assets/default_avatar.png') as ImageProvider,

                    child: imageFile == null
                        ? const Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              "$fName $lName",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,
              color: isDark? darkBmiTextColor_1 : lightBmiTextColor_1
              ),
            ),
            Text(
              email,
              style: TextStyle(fontSize: 14, color: isDark? darkSecondaryTextColor : lightSecondaryTextColor),
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
                UpdateData updateData = UpdateData(
                  fName: firstNameController.text,
                  lName: lastNameController.text,
                  email: emailController.text,
                  age: int.tryParse(ageController.text) ?? age ,
                  weight: int.tryParse(weightController.text)??weight,
                  height: int.tryParse(heightController.text)??170
                );
                try {
                  final result = await UpdateProfileService().updateProfile(updateData);

                  if (result['success']) {
                    userNameNotifier.value = firstNameController.text;

                    final updatedUser = await GetUserInfoService().getUserInfo();

                    if (mounted) {
                      setState(() {
                        fName = updatedUser.firstName ?? "";
                        lName = updatedUser.lastName ?? "";
                        email = updatedUser.email ?? "";
                        age = updatedUser.age ?? 0;
                        height = updatedUser.height ?? 0;
                        weight = updatedUser.weight ?? 0;

                        firstNameController.text = fName;
                        lastNameController.text = lName;
                        emailController.text = email;
                        ageController.text = age.toString();
                        weightController.text = weight.toString();
                        heightController.text = height.toString();

                        final snackBar = buildCustomSnackbar(
                          title: 'Success!',
                          message: result['message'],
                          backgroundColor: Colors.green,
                          type: ContentType.success,
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      });
                    }
                  }else {
                    final snackBar = buildCustomSnackbar(
                      title: 'Update Failed!',
                      message: result['message'],
                      backgroundColor: Colors.redAccent,
                      type: ContentType.failure,
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  }
                } catch (e) {
                  final snackBar = buildCustomSnackbar(
                    title: 'Error!',
                    message: e.toString(),
                    backgroundColor: Colors.redAccent,
                    type: ContentType.failure,
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                }






              },
            ),
          ],
        ),
      ),
    );
  }
}

// int parsedAge = int.tryParse(ageController.text) ?? 0;
// int parsedWeight = int.tryParse(weightController.text) ?? 0;
// int parsedHeight = int.tryParse(heightController.text) ?? 0;
//
// await storage.saveUserAge(parsedAge);
// await storage.saveUserWeight(parsedWeight);
// await storage.saveUserHeight(parsedHeight);
//
// setState(() {
//   age = parsedAge;
//   weight = parsedWeight;
//   height = parsedHeight.toDouble();
// });



/*
on_Pressed: () async {
  final updatedUser = FullUserInfo(
    firstName: firstNameController.text,
    lastName: lastNameController.text,
    email: emailController.text,
    age: int.tryParse(ageController.text) ?? 0,
    weight: int.tryParse(weightController.text) ?? 0,
    height: int.tryParse(heightController.text) ?? 0,
    // If your model includes these, provide default/fetched values
    gender: null,
    goal: null,
    activityLevel: null,
    experienceLevel: null,
    daysPerWeek: 0,
    bmi: 0,
  );

  await UserInfoLocalStorage.saveUserInfo(updatedUser);

  if (mounted) {
    setState(() {
      fName = updatedUser.firstName ?? "";
      lName = updatedUser.lastName ?? "";
      email = updatedUser.email ?? "";
      age = updatedUser.age ?? 0;
      height = updatedUser.height ?? 0;
      weight = updatedUser.weight ?? 0;
    });
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Profile updated successfully!')),
  );
},
 */