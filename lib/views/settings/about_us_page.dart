import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});
  static const String routeName = 'AboutUsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "About Us"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Image.asset(Assets.assetsImagesImg, height: 120),
              ),
              const SizedBox(height: 30),
              const Text(
                "🧠 About WellnessHub",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "Welcome to WellnessHub, your trusted companion on the journey to a healthier, happier you.\n\n"
                "At WellnessHub, we believe that well-being is more than just fitness — it's a balance of body, mind, and soul. "
                "Our mission is to empower individuals with the tools, knowledge, and support they need to live their best life every single day.",
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 24),
              const Text(
                "🌿 Our Vision",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "To create a world where wellness is accessible to everyone—anytime, anywhere.",
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 24),
              const Text(
                "💡 What We Offer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "✅ Personalized health and fitness tracking\n"
                "✅ Goal-oriented challenges and progress insights\n"
                "✅ Guided mindfulness and mental health support\n"
                "✅ Nutritious meal plans and expert wellness tips\n"
                "✅ A supportive AI Chat Coach that uplifts and motivates",
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 24),
              const Text(
                "🤝 Why Choose Us?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Because we care. Our team is made up of passionate developers, health coaches, and medical consultants working together to build a platform that adapts to your lifestyle—not the other way around.\n\n"
                "We listen. Your feedback drives our innovation, and we're constantly evolving to serve you better.",
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 24),
              const Text(
                "📬 Get in Touch",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Have suggestions, feedback, or just want to say hello?\n"
                "We’d love to hear from you!\n"
                "📧 support@wellnesshub.com",
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 24),
              const Text(
                "🙏 Thank You",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Thank you for choosing WellnessHub. Let’s grow healthier together — one step at a time. 🌱",
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
