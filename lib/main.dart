import 'package:flutter/material.dart';
import 'package:roccabox_admin/screens/splash.dart';
import 'package:roccabox_admin/theme/theme.dart';
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
          theme: theme(),
          home: Splash(),
        );
      },
    );
  }
}
