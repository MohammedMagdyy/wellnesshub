import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/helper_functions/on_generate_route.dart';
import 'package:wellnesshub/core/utils/global_var.dart';
import 'package:wellnesshub/views/mainpage.dart';
import 'core/helper_class/Dio_Interceptor _Handling401.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalVar().init();
  await GlobalVar().loadDarkMode();
  await GlobalVar().loadProfileImage();
  final dioInterceptor = DioInterceptorHandlingError();
  dioInterceptor.setupDio();
  runApp(const WellnessHub());
}

class WellnessHub extends StatelessWidget {
  const WellnessHub({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GlobalVar().isDarkModeNotifier,
      builder: (context, value, child) {
        final bool isDarkMode = value;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          onGenerateRoute: OnGenerateRoute,
          initialRoute:MainPage.routeName,
          theme: ThemeData(
            scaffoldBackgroundColor: lightBackgroundColor,
            brightness: Brightness.light
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: darkBackgroundColor,
            brightness: Brightness.dark
          ),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}

