import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Privacy Policy'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome to The Wellness Hub! We collect data like name, age, weight, and fitness activities to provide personalized workout plans.", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text("Your data helps us improve recommendations and track progress. We prioritize security and do not sell your data.", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text("You can update or delete your data anytime in settings. By using The Wellness Hub, you agree to this policy.", style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}