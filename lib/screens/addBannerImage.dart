import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';


class AddBannerImage extends StatefulWidget {
  const AddBannerImage({ Key? key }) : super(key: key);

  @override
  _AddBannerImageState createState() => _AddBannerImageState();
}

class _AddBannerImageState extends State<AddBannerImage> {

    String image = "";
    String base64Image = "";
  String fileName = "";
  File? file;
  bool isLoading = false;
  final picker = ImagePicker();
  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
        title: Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Center(
            child: Text(
              "Add Banner Image",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            
            children: [
        
              SizedBox(height: 4.h,),
        
              Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                    child: TextFormField(
                      
                      
                      // controller: uptemail,
                      decoration: InputDecoration(
                        hintText: "Image Title",
                        hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            
                            
                              borderRadius: BorderRadius.circular(3.w),
                              
                              )),
                    ),
                  ),
        
                
        
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                    child: TextFormField(
                      
                      
                      // controller: uptemail,
                      decoration: InputDecoration(
                        hintText: "Select Redirection Page",
                        hintStyle: TextStyle(color: Colors.black),
                        suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              size: 8.w,
                            ),
                          border: OutlineInputBorder(
                            
                            
                              borderRadius: BorderRadius.circular(3.w),
                             
                              
                              )),
                    ),
                  ),
        
        
                  SizedBox(height: 3.h,),
        
        
                   InkWell(
                     onTap: () {
                       getImage();
                     },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                      child: Container(
                        height: 20.h,
                        width: double.infinity,
                  
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(3.w),
                          border: Border.all(
                                       color: Colors.grey,
                                       //Color(0xffD5D5D5)
                                       )
                        ),
                  
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                  
                            Icon(Icons.image,
                            color: Colors.grey.shade300,
                            size: 10.h,
                            ),
                  
                            SizedBox(height: 2.h
                            ,),
                  
                            Text("Choose Image",
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 15.sp
                            ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
        
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 5.h),
                    child: GestureDetector(
                            onTap: () {
                              
                              
                            },
                            child: Container(
                              height: 7.h,
                              // width: 122,
                              // height: 30,
                              
                              
                              decoration: BoxDecoration(
                                color: Color(0xffFFBA00),
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: Center(
                                child: Text(
                                  'Add Image',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                  ),
        
        
                  
        
            ],
          ),
        ) ),
   
      
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


