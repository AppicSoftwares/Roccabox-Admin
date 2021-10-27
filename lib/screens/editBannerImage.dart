import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'banners.dart';

class EditBannerImage extends StatefulWidget {
  var name, url, redirect, id;

  EditBannerImage({required this.name, required this.url, 
  required this.redirect, required this.id});

  @override
  _EditBannerImageState createState() => _EditBannerImageState();
}

class _EditBannerImageState extends State<EditBannerImage> {

  String? _chosenValue;

 
  String image = "";
  String base64Image = "";
  String fileName = "";
  File? file;
  bool isLoading = false;
  final picker = ImagePicker();
  get kPrimaryColor => null;

  
  

  bool isloading = false;
   final formkey = GlobalKey<FormState>();



  TextEditingController nameController = new TextEditingController();
  TextEditingController redirectController = new TextEditingController();

@override
void initState() {
  super.initState();
  nameController.text = widget.name;
  redirectController.text = widget.redirect;
  
}

String? uptname;
String? uptredirect;
String? uptchosenValue;






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Center(
            child: Text(
              "Edit Banner Image",
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
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
              child: TextFormField(
                controller: nameController,
                // controller: uptemail,
                decoration: InputDecoration(
                    hintText:"Property type",
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.w),
                    )),
              ),
            ),

             Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
              child: Container(
                height: 7.h,

                child: DropdownButton<String>(
                  
                  focusColor: Colors.white,
                  isExpanded: true,
                  value: _chosenValue,
                  //elevation: 5,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  
                  items: <String>[
                    'List your property',
                    'Categories: For Sale',
                    'Categories: For Developments',
                    'Categories: For Rent',
                    'Categories: For Holiday Rentals',
                    'Guide',
                    'About us',
                    'Contact Us',
                    'Chat',
                    'Mortgage',
                    'Request More info'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    //"Please select reffrence screen"
                    widget.redirect.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _chosenValue = value!;
                     
                      
                    });
                  },
                ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
              child: Visibility(
                 visible:  _chosenValue == "List your property" ? true : false,
                // _chosenValue == "List your property" ? true : false,
                child: TextFormField(
                  
                  
              
                   controller: redirectController,
                  decoration: InputDecoration(
                    hintText: "Type refference Id",
                    hintStyle: TextStyle(color: Colors.black),
                    
                  
                      border: OutlineInputBorder(
              
                          borderRadius: BorderRadius.circular(3.w),
              
                          )),
                ),
              ),
            ),

          
            SizedBox(
              height: 3.h,
            ),




              InkWell(
                onTap: () {
                  getImage();
                },
                child: file == null
                    ? Stack(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                    child: Container(
                      height: 20.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.w),
                    border: Border.all(
                      color: Colors.grey,
                      //Color(0xffD5D5D5)
                    ),
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.url.toString(),
                        ),
                        fit: BoxFit.fill),
                      ),
                    )),
          
                     Padding(
                       padding: EdgeInsets.only(top: 1.h, right: 2.h),
                       child: Align(
                     alignment: Alignment.topRight,
                     child: IconButton(
                      onPressed: () {},
                      icon: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset(
                            'assets/errorsvg.svg',
                            width: 10.w,
                            color: Colors.white,
                          ),
                      ), 
                       )
                       ),
                     )
              
              ],
            )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 1.h),
                        child: Container(
                          height: 20.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.w),
                              border: Border.all(
                                color: Colors.grey,
                                //Color(0xffD5D5D5)
                              ),
                              image: DecorationImage(
                                  image: FileImage(File(file!.path)))),
                        ),
                      )),










           
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 5.h),
              child: GestureDetector(
                onTap: () {

                  
                       
                        uptname = nameController.text.toString();
                         if (uptname == null){
                          uptname = widget.name.toString();
                          
                          } 
                          print("name: "+uptname.toString());


                          

                          uptredirect= _chosenValue.toString();


                          if (uptredirect == null) {

                          uptredirect=  _chosenValue.toString();

                            
                          }
                        
                            
                              
                              print("email : " +uptredirect.toString());
                            

                            

                          
                            uploadData(
                               nameController.text.toString(),

                           



                          

                         

                          _chosenValue.toString(),

                          

                          redirectController.text.toString());

                            // userRegister(email.toString(), phone.toString(),
                            //     firstname.toString() + ' ' + lastname.toString());
                          
                          


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
                      'Edit Image',
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
          )),
    );
  }

   Future<dynamic> uploadData(String name, String _chosenValue, String redirect, ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    print("id Print: " + id.toString());
    setState(() {
      isloading = true;
    });

    print("title " + name.toString() + "");

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        RestDatasource.EDITBANNER_URL,
      ),
    );
    if (name.toString() != "null" || name.toString() != "") {
      request.fields["name"] = name;
      print("name: "+name.toString());
    }

    if (_chosenValue.toString() != "null" || _chosenValue.toString() != "") {
      request.fields["redirect"] = _chosenValue.toString();
       print("choosenValue: "+_chosenValue.toString());
    }

    if (redirect.toString() != "null" || redirect.toString() != "") {
      request.fields["refid"] = redirect.toString();
       print("redirect: "+redirect.toString());
    }

    request.fields["admin_id"] = id.toString();
    request.fields["slider_id"] = widget.id.toString();
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Banners()));
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
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Please try leter")));
      });
    }
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


