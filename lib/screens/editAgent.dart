import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roccabox_admin/screens/totalAgentList.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class EditAgent extends StatefulWidget {
var  name, phone, email, country_code, id;

  EditAgent({required this.name,  required this.phone,  
  required this.email, required this.country_code, required this.id, });

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<EditAgent> {
  var name, email, phone, id;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();




@override
void initState() {
  super.initState();
  nameController.text=widget.name;
  emailController.text = widget.email;
}
  





  String? uptname;
  String? uptemail;
  String? uptoPhone;

  String? code = "44";
  bool isloading = false;
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

     print("phone: "+widget.phone.toString());
    print("id: "+widget.id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Center(
            child: Text(
              "Edit Agent",
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
                      //name
                      hintText: widget.name.toString(),
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
                  child: Container(
                    child: TextFormField(
                      controller: emailController,
                      
                      
                      // controller: uptemail,
                      decoration: InputDecoration(
                  
                        //email
                        hintText: widget.email.toString(),
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.w))),
                  
                              
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                  child: TextField(
                    controller: phoneController,
                    enabled: false,
                    decoration: InputDecoration(

                       hintText: widget.phone.toString(),
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),






                        prefixIcon: CountryCodePicker(
                          // showFlag: false,
                          onChanged: print,
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                 GestureDetector(
                        onTap: () {

                          if (formkey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                       
                        uptname = nameController.text.toString();
                         if (uptname == null){
                          uptname = widget.name.toString();
                          
                          } 
                          print("name: "+uptname.toString());

                          uptemail= emailController.text.toString();


                          if (uptemail == null) {

                          uptemail=  widget.email.toString();

                            
                          }
                        
                            
                              
                              print("email : " +uptemail.toString());
                            

                            if(uptoPhone==null){
                              uptoPhone = phoneController.text.toString();
                              print("phone Number: " +phoneController.text.toString());
                            }

                          
                            uploadData(uptname.toString(), uptemail.toString(), widget.phone.toString());

                            // userRegister(email.toString(), phone.toString(),
                            //     firstname.toString() + ' ' + lastname.toString());
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
                              'Edit Agent',
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




  
   Future<dynamic> uploadData( String name, String email, String phone) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
    setState(() {
       isloading = true;
    });


    
        print("name update: " +name.toString());
        print("admin id update: " +id.toString());
        print("user id update: " +widget.id.toString());
        print("email update: " +email.toString());

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        RestDatasource.EDITAGENT_URL,
      ),
    );
    if(name.toString() != "null" || name.toString()!="") {
      request.fields["name"] = name;
      print("Name: " +name.toString());
    }
    
    if(email.toString() != "null" || email.toString()!="") {
      request.fields["email"] = email;
      print("email: " +email.toString());
    }
    
    if(phone.toString() != "null" || phone.toString()!="") {
      request.fields["phone"] = phone.toString();
      print("phone number 1 : " +phone.toString());
    }

     if(code.toString() != "null" || code.toString()!="") {
      request.fields["country_code"] = code.toString();
    }

    request.fields["admin_id"] = id.toString();
    request.fields["user_id"] = widget.id.toString();
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
