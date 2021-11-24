
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roccabox_admin/screens/dashboard.dart';
import 'package:roccabox_admin/screens/enquiry.dart';
import 'package:roccabox_admin/screens/languageCheck.dart';
import 'package:roccabox_admin/screens/menu.dart';
import 'package:roccabox_admin/screens/property.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


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

  String id = "";
  FirebaseMessaging? auth;
  var token;
  final firestoreInstance = FirebaseFirestore.instance;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.unfocus();
    focusNode.dispose();
    auth = FirebaseMessaging.instance;
    auth?.getToken().then((value){
      print("FirebaseToken "+value.toString());
      token = value.toString();
      updateToken(token);
    });
  }
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

  Future<dynamic> updateToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userid = pref.getString("id");

    var documentReference = FirebaseFirestore.instance
        .collection('token')
        .doc(userid.toString());
    firestoreInstance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        {
          'token': token
        },
      );
    });

    print("user_id "+userid.toString());
    print("token "+token.toString());
    // print(email);
    var jsonRes;
    http.Response? res;
    var request = http.post(Uri.parse(RestDatasource.UPDATE_TOKEN),
        body: {

          "token": token.toString(),
          "user_id": userid.toString()


        });

    await request.then((http.Response response) {
      res = response;

      // msg = jsonRes["message"].toString();
      // getotp = jsonRes["otp"];
      // print(getotp.toString() + '123');t
    });
    if (res!.statusCode == 200) {
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(res!.body.toString());
      print("Response: " + res!.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");


    } else {

    }
  }







}
