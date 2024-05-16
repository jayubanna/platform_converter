import 'dart:io';

import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {

  bool isAndroid = Platform.isIOS;

  void changePlatform(bool isAndroid) {
    this.isAndroid = isAndroid;
    notifyListeners();
  }

  bool Android_Theme_Mode = false;

  void change_Android_Theme() {
    Android_Theme_Mode = !Android_Theme_Mode;
    notifyListeners();
  }


}