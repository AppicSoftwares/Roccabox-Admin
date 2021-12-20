import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roccabox_admin/agora/callModel.dart';

import 'package:roccabox_admin/screens/homenave.dart';
import 'package:roccabox_admin/screens/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String id = "";
  FirebaseMessaging? auth;
  var token;
  final firestoreInstance = FirebaseFirestore.instance;
  @override
  void initState() {
    auth = FirebaseMessaging.instance;
    auth?.getToken().then((value){
      print("FirebaseToken "+value.toString());
      token = value.toString();
    });

    getLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          child: SvgPicture.asset('assets/roccabox-logo.svg'),
        ),
      ),
    );
  }
  void updateChatHead(String id, String time, String sender_id, String status) async {
    Map<String, String> map = new Map();
    map["status"] = "end";
    FirebaseFirestore.instance
        .collection('call_master')
        .doc("call_head")
        .collection(id.toString())
        .doc(time).update(map).then((value) {
      FirebaseFirestore.instance
          .collection("call_master")
          .doc("call_head")
          .collection(sender_id)
          .doc(time)
          .update(map);
    });
  }

  getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString();
    print("id :" + id + "^");
    if(id!=null){

      var documentReference = FirebaseFirestore.instance
          .collection('token')
          .doc(id.toString());

      firestoreInstance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'token': token
          },
        );
      });
    }
    Future.delayed(Duration(seconds: 2), () {
      id.toString() == "" || id.toString() == "null" || id == null
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()))
          : Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeNav()));
    });


  }
}
