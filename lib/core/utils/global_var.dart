import 'package:flutter/foundation.dart';



class GlobalVar {
  static final GlobalVar _instance = GlobalVar._internal();
  
  factory GlobalVar() => _instance;

  GlobalVar._internal();

  ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);
}