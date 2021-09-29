import 'package:flutter/material.dart';
import 'package:roccabox_admin/screens/splash.dart';
import 'package:sizer/sizer.dart';


int langCount = 0;

void main() {
  runApp(RoccoBoxAdminApp());
}


class RoccoBoxAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'RoccoBox Admin',
          theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          fontFamily: "Poppins"),
          home:  Splash(),
        );
      },
    );
  }
}
