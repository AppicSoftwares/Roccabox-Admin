import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roccabox_admin/theme/constant.dart';




class NotificationScreen extends StatefulWidget {
  const NotificationScreen({ Key? key }) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Notification",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Container(
           child: Column(
             children: [
               Container(
          margin:
              EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.all(12),
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/Bell.svg",
                color: kPrimaryColor,
              ),
            ),
            title: Text(
              "This page provides an overview of where notifications appear and the available features.",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            trailing: Text("Yesterday",
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ),
             
        ),

        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey,
        )
             ],
           ),
        );
      },
    ),
      
    );
  }
}