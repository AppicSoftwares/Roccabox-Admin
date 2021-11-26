import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:roccabox_admin/ChatModule/chat.dart';
import 'package:roccabox_admin/services/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'homenave.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List names = [
    'Rajveer Place',
    'Taj Place',
    'Amar Place',
    'KLM Place',
    'Calibration Place',
    'Special Place',
    'Moti Place',
    'Rajvansh Place',
    'Taj Place',
    'Amar Place',
    'KLM Place',
    'Calibration Place',
    'Special Place',
  ];


  List<String> titleList = [];
  List<String> bodyList = [];
  List<String> isread = [];
  List<String> imageList = [];
  List<String> screenList = [];
  List<String> idList = [];
  List<String> chatTypeList = [];



  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Color(0xff000000),
          onPressed: (){
            Navigator.pushReplacement(context, new MaterialPageRoute(builder: (con)=> HomeNav()));
          },
        ),
        backgroundColor: Color(0xffFFFFFF),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
              fontWeight: FontWeight.w600),
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10, top: 5),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {

                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("titleList");
                pref.remove("bodyList");
                pref.remove("isRead");
                pref.remove("imageList");
                pref.remove("screenList");
                pref.remove("idList");
                pref.remove("chatTypeList");
                //pref.getStringList("timeList" ).clear();
                titleList.clear();
                bodyList.clear();
                chatTypeList.clear();
                screenList.clear();
                imageList.clear();
                idList.clear();
                notificationCount = 0;
                context.read<Counter>().getNotify();

                setState(() {

                });
              },
              child: Container(
                padding: EdgeInsets.all(12),
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: Color(0xFF979797).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  "assets/delete.svg",
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: titleList.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Color(0xff707070),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            isThreeLine: true,
            onTap: (){
              if(chatTypeList!=null && chatTypeList.isNotEmpty){
                if(chatTypeList.elementAt(index)!=""){
                  if(chatTypeList.elementAt(index)=="user-admin"){
                    if(idList!=null) {
                      if (idList.elementAt(index) != "") {
                        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> Chat("user")));
                      }else{
                        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> Chat("user")));

                      }
                    }else{
                      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> Chat("user")));

                    }
                  }else{
                    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> Chat("agent")));

                  }
                }
              }
            },
            leading: CircleAvatar(
              backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
              // backgroundImage: AssetImage('assets/img1.png'),
              child: Text(
                titleList.elementAt(index).toString().substring(0, 1),
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
            ),
            title: Text(
              titleList.elementAt(index),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
            ),
            subtitle: Text(
              bodyList[index],
              style: TextStyle(fontSize: 12, color: Color(0xff818181)),
            ),
          );
        },
      ),
    );
  }




  Future<void> getData() async {
    List<String> isRead = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey("titleList")) {
      titleList = preferences.getStringList("titleList")!;
    }
    bodyList = preferences.getStringList("bodyList")!;

    if(preferences.containsKey("isRead")) {
      isread = preferences.getStringList("isRead")!;
    }
    if(preferences.containsKey("imageList")) {
      imageList = preferences.getStringList("imageList")!;
    }
    if(preferences.containsKey("screenList")) {
      screenList = preferences.getStringList("screenList")!;
    }
    if(preferences.containsKey("idList")) {
      idList = preferences.getStringList("idList")!;
    }
    if(preferences.containsKey("chatTypeList")) {
      chatTypeList = preferences.getStringList("chatTypeList")!;
    }
    isread.forEach((element) {
      isRead.add("true");
    });
    preferences.setStringList("isRead", isRead);
    preferences.commit();
    notificationCount = 0;
    context.read<Counter>().getNotify();

    setState(() {
      titleList = titleList.reversed.toList();
      bodyList = bodyList.reversed.toList();
      imageList = imageList.reversed.toList();
      idList = idList.reversed.toList();
      screenList = screenList.reversed.toList();
    });
  }
}
/*
ListView.separated(
        itemCount: names.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Color(0xff707070),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            isThreeLine: true,
            leading: CircleAvatar(
              backgroundColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              // backgroundImage: AssetImage('assets/img1.png'),
              child: Text(
                names.elementAt(index).toString().substring(0, 1),
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
            ),
            title: Text(
              names.elementAt(index),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
            ),
            subtitle: Text(
              'Hi! We have assigned you  a new agent for your previous enquiry. They will message you shortly',
              style: TextStyle(fontSize: 12, color: Color(0xff818181)),
            ),
          );
        },
      ),*/