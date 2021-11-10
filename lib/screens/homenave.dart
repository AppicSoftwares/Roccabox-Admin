
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roccabox_admin/screens/dashboard.dart';
import 'package:roccabox_admin/screens/enquiry.dart';
import 'package:roccabox_admin/screens/languageCheck.dart';
import 'package:roccabox_admin/screens/menu.dart';
import 'package:roccabox_admin/screens/property.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../main.dart';


class HomeNav extends StatefulWidget {

  
  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  int _index = 0;
  List widgets = <Widget>[Dashboard(), Enquiry(), Property(), Menu()];

    LanguageChange languageChange = new LanguageChange();
    GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');


   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.elementAt(_index),
      bottomNavigationBar: BottomNavigationBar(
        
          currentIndex: _index,
          type: BottomNavigationBarType.fixed,
          // showSelectedLabels: true,
          selectedIconTheme: IconThemeData(color: Color(0xffFFBA00)),
          unselectedIconTheme: IconThemeData(color: Color(0xff8E8E8E)),
          selectedLabelStyle: TextStyle(fontSize: 12, color: Color(0xffFFBA00)),
          unselectedLabelStyle:
              TextStyle(fontSize: 12, color: Color(0xff8E8E8E)),
          selectedItemColor: Color(0xffFFBA00),
          unselectedItemColor: Color(0xff8E8E8E),
          onTap: (page) {
            setState(() {
              _index = page;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/dashboard.svg',
                  width: 6.w,
                  color: _index == 0 ? Color(0xffFFBA00) : Color(0xff8E8E8E),
                ),
                //dashboard
                label: languageChange.DASHBOARD[langCount],
                ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/enquiry.svg',
                  width: 6.w,
                  color: _index == 1 ? Color(0xffFFBA00) : Color(0xff8E8E8E),
                ),

                //Enquiry
                label: languageChange.ENQUIRY[langCount]),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/property.svg',
                  width: 5.w,
                  color: _index == 2 ? Color(0xffFFBA00) : Color(0xff8E8E8E),
                ),

                //Property
                label: languageChange.PROPERTY1[langCount]),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/profile.svg',
                  width: 6.w,
                  color: _index == 3 ? Color(0xffFFBA00) : Color(0xff8E8E8E),
                ),

                //Menu
                label: languageChange.MENU[langCount])
          ]),
    );
  }

  Future<dynamic> getUserList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("id").toString();
    var email = pref.getString("email").toString();
      final BottomNavigationBar? navigationBar = globalKey.currentWidget as BottomNavigationBar?;
    navigationBar!.onTap!(1);
  }


   

    

}
