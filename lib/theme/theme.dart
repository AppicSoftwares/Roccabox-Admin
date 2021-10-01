

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:roccabox_admin/theme/constant.dart';
import 'package:sizer/sizer.dart';



ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Poppins",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
  
    visualDensity: VisualDensity.adaptivePlatformDensity,

  );
}



TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 1,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black, fontSize: 10.sp, fontWeight: FontWeight.bold),
    ),
  );
}
