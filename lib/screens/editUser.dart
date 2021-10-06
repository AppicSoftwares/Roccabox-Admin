import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<EditUser> {
  String image = "";
    String base64Image = "";
  String fileName = "";
  File? file;
  bool isLoading = false;
  final picker = ImagePicker();
  get kPrimaryColor => null;

   final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Center(
            child: Text(
              "Edit User",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
            ),
          ),
        ),
      ),
      body: SizerUtil.deviceType == DeviceType.mobile
          ? SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    height: 100,
                    width: 110,
                    child: GestureDetector(
                      onTap: () => getImage(),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          FittedBox(

                            child: CircleAvatar(
                             
                                        backgroundImage: AssetImage("assets/image.jpeg"),
                                        
                                      )
                                
                          ),
                          Positioned(
                              right: 0.w,
                              bottom: 0.h,
                              child: CircleAvatar(
                                  radius: 5.w,
                                  backgroundColor: Color(0xffEEEEEE),
                                  child: Icon(Icons.camera_alt_outlined,
                                  color: Colors.grey,)))
                        ],
                      ),
                    ),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 1.h),
                  child: TextFormField(
                    
                    decoration: InputDecoration(
                      hintText: "Jitendra",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.w))),
                  ),
                ),
               
                Padding(
                  padding:  EdgeInsets.only(top: 1.h, ),
                  child: TextFormField(
                    
                    
                    // controller: uptemail,
                    decoration: InputDecoration(
                      hintText: "Jitendra@gmail.com",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.w))),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: TextField(
                    
                    decoration: InputDecoration(
                      hintText: "9876543210",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                      
                        border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(3.w))),
                  ),
                ),
                 GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          height: 7.h,
                          // width: 122,
                          // height: 30,
                          margin: EdgeInsets.only(top: 5.h),
                          padding:
                              EdgeInsets.symmetric(horizontal: 2.w, ),
                          decoration: BoxDecoration(
                            color: Color(0xffFFBA00),
                            borderRadius: BorderRadius.circular(3.w),
                          ),
                          child: Center(
                            child: Text(
                              'Edit User',
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
      )
          : Container(
              // Widget for Tablet
              width: 100.w,
              height: 12.5.h,
            ),
    );
  }
   Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
      });
      base64Image = base64Encode(file!.readAsBytesSync());
    } else {
      print('No image selected.');
    }

    fileName = file!.path.split("/").last;
    print("ImageName: " + fileName.toString() + "_");
    print("Image: " + base64Image.toString() + "_");
    setState(() {});
  }
}
