import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_switchtoggle.dart';
import 'package:wellnesshub/views/about_us_page.dart';
import 'package:wellnesshub/views/appinfo_page.dart';
import 'package:wellnesshub/views/changepassword_page.dart';
import 'package:wellnesshub/views/main_exercises_page.dart';
import 'package:wellnesshub/views/facebookLoginPage.dart';
import 'package:wellnesshub/views/fitnessplanpage.dart';
import 'package:wellnesshub/views/mainpage.dart';
import 'package:wellnesshub/views/community_page.dart';
import 'package:wellnesshub/views/favorites.dart';
import 'package:wellnesshub/views/homepage.dart';
import 'package:wellnesshub/views/nutrition_page.dart';
import 'package:wellnesshub/views/privacypolicy.dart';
import 'package:wellnesshub/views/profile.dart';
import 'package:wellnesshub/views/profilesettings_page.dart';
import 'package:wellnesshub/views/rate_app.dart';
import 'package:wellnesshub/views/progress.dart';
import 'package:wellnesshub/views/setting_page.dart';
import 'package:wellnesshub/views/sign_in.dart';
import 'package:wellnesshub/views/signup_process/activity_page.dart';
import 'package:wellnesshub/views/signup_process/experiencelevel_page.dart';
import 'package:wellnesshub/views/signup_process/gender_page.dart';
import 'package:wellnesshub/views/signup_process/goal_page.dart';
import 'package:wellnesshub/views/signup_process/height_page.dart';
import 'package:wellnesshub/views/signup_process/injuries_page.dart';
import 'package:wellnesshub/views/signup_process/meal_plan.dart';
import 'package:wellnesshub/views/signup_process/physical_page.dart';
import 'package:wellnesshub/views/signup_process/sign_up.dart';
import 'package:wellnesshub/views/signup_process/verify_email_page.dart';
import 'package:wellnesshub/views/signup_process/weight_page.dart';
import 'package:wellnesshub/views/signup_process/workoutdays_page.dart';
import 'package:wellnesshub/views/signup_process/year_page.dart';
import 'package:wellnesshub/core/widgets/categories.dart';
import 'package:wellnesshub/views/bmi_calculator.dart';
import 'package:wellnesshub/views/specificexercise_page.dart';
import 'package:wellnesshub/views/splash_screen.dart';
import 'package:wellnesshub/views/startup.dart';
import 'package:wellnesshub/views/test.dart';
import 'package:wellnesshub/views/exercise_page.dart';
import 'package:wellnesshub/views/versioninfo_page.dart';
import 'package:wellnesshub/views/workout_reminder_page.dart';

Route<dynamic> OnGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'StartUp':
      return MaterialPageRoute(builder: (context) => Startup());
    case 'LoginPage':
      return MaterialPageRoute(builder: (context) => SignInPage());
    case 'SignUpPage':
      return MaterialPageRoute(builder: (context) => SignUp());
    case 'GenderPage':
      return MaterialPageRoute(builder: (context) => GenderPage());
    case 'GoalPage':
      return MaterialPageRoute(builder: (context) => GoalPage());
    case 'PhysicalPage':
      return MaterialPageRoute(builder: (context) => PhysicalPage());
    case 'InjuriesPage':
      return MaterialPageRoute(builder: (context) => InjuriesPage());
    case 'ActivityPage':
      return MaterialPageRoute(builder: (context) => ActivityPage());
    case 'MealPlan':
      return MaterialPageRoute(builder: (context) => MealPlan());
    case 'AgePage':
      return MaterialPageRoute(builder: (context) => YearPage());
    case 'WeightPage':
      return MaterialPageRoute(builder: (context) => WeightPage());
    case 'HeightPage':
      return MaterialPageRoute(builder: (context) => HeightPage());
    case 'CommunityPage':
      return MaterialPageRoute(builder: (context) => CommunityPage());
    case 'NutritionPage':
      return MaterialPageRoute(builder: (context) => NutritionPage());
    case 'ExercisePage':
      return MaterialPageRoute(builder: (context) => ExercisePage());
    case 'SettingPage':
      return MaterialPageRoute(builder: (context) => SettingPage());
    case 'Favorites':
      return MaterialPageRoute(builder: (context) => FavoritesPage());
    case 'PrivacyPolicy':
      return MaterialPageRoute(builder: (context) => PrivacyPolicyPage());
    case 'Profile':
      return MaterialPageRoute(builder: (context) => ProfilePage());
    case 'VerifyEmailPage':
      return MaterialPageRoute(builder: (context) => VerifyEmailPage());
    case 'BMICalculator':
      return MaterialPageRoute(builder: (context) => BMICalculator());
    case 'Categories':
      return MaterialPageRoute(builder: (context) => Categories());
    case 'HomePage':
      return MaterialPageRoute(builder: (context) => HomePage());
    case 'MainPage':
      return MaterialPageRoute(builder: (context) => MainPage());
    case 'FitnessPlanPage':
      return MaterialPageRoute(builder: (context) => FitnessPlanPage());
    case 'Test':
      return MaterialPageRoute(builder: (context) => Test());
    case 'Splash_Screen':
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case 'AboutUsPage':
      return MaterialPageRoute(builder: (context) => AboutUsPage());
    case 'ChangepasswordPage':
      return MaterialPageRoute(builder: (context) => ChangepasswordPage());
    case 'RateAppPage':
      return MaterialPageRoute(builder: (context) => RateAppPage());
    case 'AppinfoPage':
      return MaterialPageRoute(builder: (context) => AppinfoPage());
    case 'VersionInfoPage':
      return MaterialPageRoute(builder: (context) => VersionInfoPage());
    case 'ProfilesettingsPage':
      return MaterialPageRoute(builder: (context) => ProfilesettingsPage());
    case 'CustomToggleSwitch':
      return MaterialPageRoute(builder: (context) => CustomToggleSwitch());
    case 'WorkoutReminder':
      return MaterialPageRoute(builder: (context) => WorkoutReminderPage());
    case 'FacebookLoginPage':
      return MaterialPageRoute(builder: (context) => FacebookLoginPage());
    case 'ExperienceLevelPage':
      return MaterialPageRoute(builder: (context) => ExperienceLevelPage());
    case 'WorkoutDaysPage':
      return MaterialPageRoute(builder: (context) => WorkoutDaysPage());
    case 'MainExercisesPage':
      return MaterialPageRoute(builder: (context) => MainExercisesPage());
    case 'SpecificExercisePage':
      return MaterialPageRoute(builder: (context) => SpecificExercisePage(title: " ",));
      
    case 'ProgressPage':
      return MaterialPageRoute(builder: (context) => ProgressPage());

    default:
      return MaterialPageRoute(
          builder: (context) =>
              Scaffold(body: Center(child: Text('Page not found'))));
  }
}
