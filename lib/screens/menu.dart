import 'package:flutter/material.dart';
import 'package:roccabox_admin/screens/banners.dart';
import 'package:roccabox_admin/screens/changePassword.dart';
import 'package:roccabox_admin/screens/dashboard.dart';
import 'package:roccabox_admin/screens/editProfile.dart';
import 'package:roccabox_admin/screens/login.dart';
import 'package:roccabox_admin/screens/mortgagesDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'languageCheck.dart';



class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Menu> {
  var name, email, image;
  @override
  void initState() {
   // getData();
    super.initState();
  }

  LanguageChange languageChange = new LanguageChange();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Menu",
          style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              leading: 
              
              image == null
                                    ? CircleAvatar(
                                      radius:30,
                                      backgroundImage: AssetImage(
                                        'assets/Avatar.png',
                                      ),
                                    )
                                    : CircleAvatar(
                                      radius: 30,
                                        backgroundImage: NetworkImage(image),
                                      ),
              title: Text(
                name == null ? "Admin" : name,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text(email == null ? "admin@gmail.com" : email),
              trailing: TextButton(
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  child: Text(
                    languageChange.EDIT[langCount],
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xffFFBA00),
                      decoration: TextDecoration.underline,
                    ),
                  )),
            ),
            ListTile(
              tileColor: Color(0xffF3F3F3),
              title: Text(
                // settings
                "Settings",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600),
              ),
            ),
            ListTile(
              onTap: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MortgagesDetails()
                        // PropertyList()

                        ));
              },
               
                //tileColor: Color(0xffF3F3F3),
                title: Text(
                  // 'Property Listing ',
                  "Mortagage Loan",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )),
            Divider(
              color: Color(0xff707070),
            ),
            ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Banners()));
                },

             
                //tileColor: Color(0xffF3F3F3),
                title: Text(
                  // 'Banners ',
                  "Banners",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )),

            Divider(
              color: Color(0xff707070),
            ),

             ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePaasword()));
              },
             
                //tileColor: Color(0xffF3F3F3),
                title: Text(
                  // 'Property Listing ',
                  "Change Password",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )),
            Divider(
              color: Color(0xff707070),
            ),


             ListTile(
              //tileColor: Color(0xffF3F3F3),
              title: Text(
                // 'Logout',
                languageChange.LogOut[langCount],
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500),
              ),
              onTap: () async {
                var pref = await SharedPreferences.getInstance();
                pref.clear();
                pref.commit();
                Navigator.pushAndRemoveUntil(
                    context,
                    new MaterialPageRoute(builder: (context) => Login()),
                        (route) => false);
              },
            ),

            
           
          ],
        ),
      ),
    );
  }

  // void getData() async {
  //   var pref = await SharedPreferences.getInstance();
  //   name = pref.getString("name");
  //   email = pref.getString("email");
  //   image = pref.getString("image");
  //   print("name " + name + "");
  //   print("email " + email + "");
  //   setState(() {});
  // }
}
