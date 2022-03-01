import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:roccabox_admin/screens/homenave.dart';
import 'package:roccabox_admin/services/apiClient.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  String? email;
  bool obscure = true;
  String? password;
  bool isloading = false;
  late FirebaseAuth mAuth;


  @override
  void initState() {
    super.initState();
    mAuth = FirebaseAuth.instance;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 60, left: 10, bottom: 70),
                height: 53,
                width: 145,
                child: SvgPicture.asset('assets/roccabox-logo.svg'),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text('Admin,',
                    style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000))),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 60),
                child: Text('Sign in to connect!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 22,
                      color: Color(0xff8A8787),
                    )),
              ),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                        inputFormatters: [FilteringTextInputFormatter.deny(
                            RegExp(r'\s'))],
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please Enter your Email Id';
                          }
                          if (!EmailValidator.validate(email.toString())) {
                            return 'Please Enter valid Email Id';
                          }

                          return null;
                        },
                        onChanged: (val) {
                          email = val;
                        },
                        decoration: InputDecoration(
                            label: Text(
                              'Email',
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(0xffD2D2D2))),
                            labelStyle: TextStyle(
                                fontSize: 15, color: Color(0xff000000))),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please Enter your Password';
                          }

                          return null;
                        },
                        onChanged: (val) {
                          password = val;
                        },
                        obscureText: obscure,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: obscure
                                    ? Icon(
                                        Icons.visibility_outlined,
                                      )
                                    : Icon(
                                        Icons.visibility_off_outlined,
                                      ),
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                }),
                            label: Text(
                              'Password',
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(0xffD2D2D2))),
                            labelStyle: TextStyle(
                                fontSize: 15, color: Color(0xff000000))),
                      ),
                    ),
                  ],
                ),
              ),
              isloading
                  ? Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (Context) => HomeNav()));
                        if (formkey.currentState!.validate()) {
                          adminlogin(email.toString(), password.toString());
                         }

                        //    if (formkey.currentState!.validate()) {
                        //   if (EmailValidator.validate(email.toString())) {
                        //     setState(() {
                        //       isloading = true;
                        //     });
                        //     adminlogin(email.toString(), password.toString(), );
                        //   } else {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //          SnackBar(
                        //             content:
                        //                 Text('Please enter a valid email')));
                        //   }
                        // }
                      

                      






                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffFFBA00)),
                        child: Center(
                            child: Text(
                          'Login',
                          style:
                              TextStyle(fontSize: 15, color: Colors.white),
                        )),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> adminlogin(String email, String password, ) async {
    setState(() {
      isloading = true;
    });
    print(email);
    print(password);
    String msg = "";
    var jsonRes;
    http.Response? res;
    var request = http.post(
        Uri.parse(

          RestDatasource.LOGIN_URL,
          //'https://appicsoftwares.in/development/roccabox/api/Login',
        ),
        body: {
          "email": email.toString().trim(),
          "password": password.toString().trim(),
          "role_id": "3"
        });

    await request.then((http.Response response) {
      res = response;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Response: " + response.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      print("status: " + jsonRes["status"].toString() + "_");
      print("message: " + jsonRes["message"].toString() + "_");
      msg = jsonRes["message"].toString();
    });
    if (res!.statusCode == 200) {
      if (jsonRes["status"] == true) {
        var mCustomToken = jsonRes["token"];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('id', jsonRes["data"]["id"].toString());
        prefs.setString('email', jsonRes["data"]["email"].toString());
        prefs.setString('name', jsonRes["data"]["name"].toString());
        prefs.setString('image', jsonRes["data"]["image"].toString());
        prefs.setString('auth_token', jsonRes["auth_token"].toString());

        prefs.commit();

        mAuth.signInWithCustomToken(mCustomToken).then((value) {
          User? user = value.user;
          print("FirebaseUSer " + user!.uid.toString());
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeNav()),
            (route) => false);

        setState(() {
          isloading = false;
        });
      }else{
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(jsonRes["message"])));

        setState(() {
          isloading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error while fetching data')));

      setState(() {
        isloading = false;
      });
    }
  }
}
