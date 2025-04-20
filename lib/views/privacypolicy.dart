import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});
  static const routeName = 'PrivacyPolicy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppbar(title: "Privacy Policy"),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Welcome message
              Text(
                "Welcome to The Wellness Hub! We value your privacy and are committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data.",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),

              // Section 2: Information we collect
              Text(
                "1. Information We Collect:\n"
                "- Personal Information: When you use our services, we may collect personal details such as your name, age, weight, and fitness activities.\n\n"
                "- Usage Data: We collect data about how you use the app, including information about your device, usage patterns, and preferences.\n\n"
                "- Location Data: If you use location-based features, we may collect information about your device's location.\n",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),

              // Section 3: How we use your information
              Text(
                "2. How We Use Your Information:\n"
                "- To provide and improve our services, including personalized workout plans.\n\n"
                "- To communicate with you regarding updates, offers, and changes.\n\n"
                "- To ensure the security and integrity of our services.\n\n"
                "- To comply with legal obligations.\n",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),

              // Section 4: Data Sharing and Disclosure
              Text(
                "3. Data Sharing and Disclosure:\n"
                "- We do not sell or share your personal information with third parties, except in the following cases:\n\n"
                "  - With service providers who assist us in delivering services (e.g., hosting, analytics, etc.).\n"
                "  - For legal reasons, such as complying with a court order or governmental request.\n",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),

              // Section 5: Data Security
              Text(
                "4. Data Security:\n"
                "We take reasonable measures to protect your personal information, including using encryption and secure servers. However, no method of transmission over the internet or electronic storage is 100% secure, so we cannot guarantee absolute security.\n",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),

              // Section 6: Your Rights and Choices
              Text(
                "5. Your Rights and Choices:\n"
                "- Access: You can request access to the personal data we hold about you.\n\n"
                "- Correction: You can request corrections to any inaccuracies in your personal information.\n\n"
                "- Deletion: You may request that we delete your personal information, subject to certain legal exceptions.\n\n"
                "- Opt-Out: You can opt-out of receiving marketing communications from us at any time.\n",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),

              // Section 7: Cookies and Tracking Technologies
              Text(
                "6. Cookies and Tracking Technologies:\n"
                "We may use cookies and similar tracking technologies to enhance your experience and collect usage data. You can adjust your browser settings to block or delete cookies, but this may affect your ability to use certain features of the app.\n",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),

              // Section 8: Children's Privacy
              Text(
                "7. Children's Privacy:\n"
                "Our services are not directed to children under the age of 13, and we do not knowingly collect personal information from children. If we become aware that we have inadvertently collected such information, we will take steps to delete it.\n",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),

              // Section 9: Changes to Privacy Policy
              Text(
                "8. Changes to This Privacy Policy:\n"
                "We may update this Privacy Policy from time to time. Any changes will be posted on this page, and the date of the last update will be indicated at the top of the policy.\n",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),

              // Section 10: Contact Information
              Text(
                "9. Contact Us:\n"
                "If you have any questions or concerns about our privacy practices, please contact us at:\n\n"
                "- Email: support@wellnesshub.com\n",
                
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),

              // Ending statement
              Text(
                "By using The Wellness Hub, you agree to this privacy policy.",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
