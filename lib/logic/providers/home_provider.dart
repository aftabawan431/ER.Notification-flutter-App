import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool isAlarmPressed = false;

  setIsAlarmPressed() {
    isAlarmPressed = !isAlarmPressed;
    notifyListeners();
  }
}
