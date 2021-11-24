import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Counter with ChangeNotifier {
  int countt = 0;
  int get count => countt;
  String screen = "";
  void getNotify() async{
    countt = notificationCount;

    notifyListeners();
  }

  void getScreen() async{
    screen = screeen;

    notifyListeners();
  }

}
