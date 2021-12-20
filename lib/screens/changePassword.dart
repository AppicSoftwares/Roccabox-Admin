import 'dart:convert';
import 'dart:io';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roccabox_admin/main.dart';
import 'package:roccabox_admin/screens/languageCheck.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChangePaasword extends StatefulWidget {
  const ChangePaasword({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<ChangePaasword> {
  bool isloading = false;

  @override
  void initState() {
    super.initState();
 
  }

  var oldPassword, newPassword, confirmPassword, id;
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    LanguageChange languageChange = new LanguageChange();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Color(0xffFFFFFF),
        elevation: 1,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
            //Update Password
            languageChange.PASSWORDUPDATE[langCount]
            ,
            style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text(
                        // Change Password
                        languageChange.CHANGEPASWWORD[langCount],
                        style:
                            TextStyle(color: Color(0xffFFBA00), fontSize: 24.sp),
                      ),
                      SizedBox(height: 0.8.h),
                      Text(
                        //Create your new secured password
                        languageChange.CREATEYOURNEWPASSWORD[langCount],
                        style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: Text(
                    // Old Password
                    languageChange.OLDPASSWORD[langCount],
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h, bottom: 2.h),
                  child: TextFormField(
                    controller: oldPasswordController,
                  
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please Enter Your Old Password';
                      }

                      return null;
                    },
                    onChanged: (val) {},
                    // controller: uptname,
                    decoration: InputDecoration(
                    
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.w))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    //New Password
                    languageChange.NEWPASSWORD[langCount],
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h, bottom: 2.h),
                  child: TextFormField(
                    controller: newPasswordController,
                    validator: (val) {},
                    // controller: uptemail,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.w))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Text(
                    //Confirm Password
                    languageChange.CONFIRMPASSWORD[langCount],
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h, bottom: 2.h),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please Enter Your Old Password';
                      }

                      return null;
                    },
                    onChanged: (val) {},
                    // controller: uptname,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.w))),
                  ),
                ),
                isloading
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Platform.isAndroid
                                ? CircularProgressIndicator()
                                : CupertinoActivityIndicator()))
                    : GestureDetector(
                        onTap: () {
                          print("hhyy"+oldPasswordController.text.toString().trim());
                          if (newPasswordController.text.toString().trim() !=
                              confirmPasswordController.text
                                  .toString()
                                  .trim()) {
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Confirm Password and new Password should be same')));
                         
                          } else if (oldPasswordController.text.toString().trim().isEmpty) {
                            

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please enter old password')));
                          }else{
                                 changePassword(
                              oldPasswordController.text.toString().trim(),
                              newPasswordController.text.toString().trim(),
                            );
                         }
                        },
                        child: Container(
                          height: 7.h,
                          // width: 122,
                          // height: 30,
                          margin: EdgeInsets.only(top: 3.h),
                          padding:
                              EdgeInsets.symmetric(horizontal: 2.h, vertical: 0),
                          decoration: BoxDecoration(
                            color: Color(0xffFFBA00),
                            borderRadius: BorderRadius.circular(3.w),
                          ),
                          child: Center(
                            child: Text(
                              //Update Password
                              languageChange.PASSWORDUPDATE[langCount],
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> changePassword(String oldPassword, String newPassword) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
    setState(() {
      isloading = true;
    });
    print(id.toString);
    print(oldPassword);
    print(newPassword);
    String msg = "";
    var jsonRes;
    http.Response? res;
    var request = http.post(
        Uri.parse(RestDatasource.CHANGEPASSWORD_URL
            // RestDatasource.SEND_OTP,
            ),
        body: {
          "user_id": id.toString(),
          "oldPassword": oldPassword.toString(),
          "newPassword": newPassword.toString(),
        });

    await request.then((http.Response response) {
      res = response;
      // msg = jsonRes["message"].toString();
      // getotp = jsonRes["otp"];
      // print(getotp.toString() + '123');
    });
    if (res!.statusCode == 200) {
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(res!.body.toString());
      print("Response: " + res!.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      print("status: " + jsonRes["status"].toString() + "_");

      if (jsonRes["status"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonRes["message"].toString())),
        );

        // print('getotp1: ' + getotp.toString());
        Navigator.pop(context);

        setState(() {
          isloading = false;
        });
      }
      if (jsonRes["status"] == false) {
        setState(() {
          isloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonRes["message"].toString())),
        );
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
