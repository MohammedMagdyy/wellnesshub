import '../helper_class/userInfo_local.dart';
import 'package:flutter/foundation.dart';

final storage = UserInfoLocalStorage();


class GlobalVar {
  static final GlobalVar _instance = GlobalVar._internal();
  
  factory GlobalVar() => _instance;

  GlobalVar._internal();

  ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);
}