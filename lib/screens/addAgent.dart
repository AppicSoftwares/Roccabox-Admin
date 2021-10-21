import 'dart:convert';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roccabox_admin/screens/totalAgentList.dart';
import 'package:roccabox_admin/screens/totalUserList.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AddAgent extends StatefulWidget {

  
  

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddAgent> {
  var name, email, phone, id;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  void initState() {
   
    super.initState();
  }
  String twodigitnumber = "";
  
 







  String? code = "44";

  
  String image = "";
    String base64Image = "";
  String fileName = "";
  File? file;
  bool isloading = false;
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
              "Add Agent",
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

                            child: file == null
                            ? 
                            Image.asset("assets/Avatar.png")
                            : CircleAvatar(
                              backgroundImage: 
                              FileImage(File(file!.path)),
                            ),
                                
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
                    controller: nameController,
                    
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.w))),
                  ),
                ),
               
                Padding(
                  padding:  EdgeInsets.only(top: 1.h, ),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    
                    
                    // controller: uptemail,
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.w))),
                  ),
                ),
                
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      child: TextFormField(
                        controller: phoneNumberController,
                        onChanged: (val) {
                          phone = val;
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please Enter Your phone number';
                          }
                          return null;
                        },
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            prefixIcon: CountryCodePicker(
                              // showFlag: false,
                              onChanged: (val)=>{
                                phone = "",
                                code = val.toString().substring(1),
                                print(code.toString()),


                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: 'gb',
                              // favorite: ['+91', 'FR'],
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                            ),
                            counterText: "",
                            hintText: "Enter Phone Number",

                        
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.w),
                                borderSide:
                                    BorderSide(color: Color(0xffD2D2D2))),
                            labelStyle: TextStyle(
                                fontSize: 15, color: Color(0xff000000))),
                      ),
                    ),

                 Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: TextField(
                    controller: passwordController,
                    
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.w))),
                  ),
                ),
                 
                 isloading
                 ?
                 Align(
                   alignment: Alignment.center,
                   child: CircularProgressIndicator(),
                 )
                 :
                 
                 GestureDetector(
                        onTap: () {

                              if (formkey.currentState!.validate()) {
                          uploadData(nameController.text.toString(),

                          
                         
                          emailController.text.toString(),
                           phoneNumberController.text.toString(),

                          passwordController.text.toString()

                          );
                          print("name: " +nameController.text.toString());
                          print("email: " +emailController.text.toString());
                          print("phone: " +phoneNumberController.text.toString());
                          print("password: " +passwordController.text.toString());

                         }
                          
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
                              'Add Agent',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
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





   Future<dynamic> uploadData( String name, String email, String phone, String password) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
    setState(() {
       isloading = true;
    });


    
        print("phone "+ phone.toString() +"");
        print("email "+ email.toString() +"");

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        RestDatasource.ADDAGENT_URL,
      ),
    );
    if(name.toString() != "null" || name.toString()!="") {
      request.fields["name"] = name;
    }
    
    if(email.toString() != "null" || email.toString()!="") {
      request.fields["email"] = email;
    }
    
    if(phone.toString() != "null" || name.toString()!="") {
      request.fields["phone"] = phone;
    }

     if(code.toString() != "null" || code.toString()!="") {
      request.fields["country_code"] = code.toString();
    }

    if (password.toString() != "null" || password.toString() != "") {
      request.fields["password"] = password.toString();
      
    }

    request.fields["admin_id"] = id.toString();
    //request.files.add(await http.MultipartFile.fromPath(base64Image, fileName));
    if (file != null) {
      request.files.add(http.MultipartFile(
          'image',
          File(file!.path).readAsBytes().asStream(),
          File(file!.path).lengthSync(),
          filename: fileName));
          print("image: " + fileName.toString());
    }
    var jsonRes;
    var res = await request.send();
 // print("ResponseJSON: " + respone.toString() + "_");
    // print("status: " + jsonRes["success"].toString() + "_");
    // print("message: " + jsonRes["message"].toString() + "_");

    if (res.statusCode == 200) {
      var respone = await res.stream.bytesToString();
      final JsonDecoder _decoder = new JsonDecoder();
     
      jsonRes = _decoder.convert(respone.toString());
      print("Response: " + jsonRes.toString() + "_");
      print(jsonRes["status"]);
      
      if (jsonRes["status"].toString() == "true") {

       

        


        // prefs.setString('phone', jsonRes["data"]["phone"].toString());
        prefs.commit();
        setState(() {
          isloading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonRes["message"].toString())));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TotalAgentList()));
        
      } else {
        setState(() {
          isloading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(jsonRes["message"].toString())));
         
        });
      }
    } else {
      setState(() {
        isloading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please try leter")));
      
      });
    }
  }






}
