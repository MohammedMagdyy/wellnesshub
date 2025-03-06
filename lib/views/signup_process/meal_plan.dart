import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/meal_plan_section.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

class MealPlan extends StatefulWidget {
  const MealPlan({super.key});
  static const routeName = 'MealPlan';

  @override
  _MealPlanState createState() => _MealPlanState();
}

class _MealPlanState extends State<MealPlan> {
  String? selectedDietaryPreference;
  String? selectedAllergy;
  String? selectedMealType;
  String? selectedCaloricGoal;
  String? selectedCookingTime;
  String? selectedServings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Meal Plan"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MealPlanSection(
              title: "Dietary Preferences",
              options: ["Vegetarian", "Vegan", "Gluten-Free", "Keto", "Paleo", "No preferences"],
              selectedValue: selectedDietaryPreference,
              onChanged: (value) => setState(() => selectedDietaryPreference = value),
            ),
            MealPlanSection(
              title: "Allergies",
              options: ["Nuts", "Dairy", "Shellfish", "Eggs", "No allergies"],
              selectedValue: selectedAllergy,
              onChanged: (value) => setState(() => selectedAllergy = value),
            ),
            MealPlanSection(
              title: "Meal Types",
              options: ["Breakfast", "Lunch", "Dinner", "Snacks"],
              selectedValue: selectedMealType,
              onChanged: (value) => setState(() => selectedMealType = value),
            ),
            MealPlanSection(
              title: "Caloric Goal",
              options: ["Less than 1500 calories", "1500-2000 calories", "More than 2000 calories", "Not sure/Don't have a goal"],
              selectedValue: selectedCaloricGoal,
              onChanged: (value) => setState(() => selectedCaloricGoal = value),
            ),
            MealPlanSection(
              title: "Cooking Time",
              options: ["Less than 15 minutes", "15-30 minutes", "More than 30 minutes"],
              selectedValue: selectedCookingTime,
              onChanged: (value) => setState(() => selectedCookingTime = value),
            ),
            MealPlanSection(
              title: "Servings",
              options: ["1", "2", "3-4", "More than 4"],
              selectedValue: selectedServings,
              onChanged: (value) => setState(() => selectedServings = value),
            ),
            const SizedBox(height: 20),
            CustomButton(
              width: 200,
              color: Colors.black,
              name: 'Continue',
              on_Pressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
