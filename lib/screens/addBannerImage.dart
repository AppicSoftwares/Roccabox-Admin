import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roccabox_admin/screens/banners.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AddBannerImage extends StatefulWidget {
  const AddBannerImage({Key? key}) : super(key: key);

  @override
  _AddBannerImageState createState() => _AddBannerImageState();
}

class _AddBannerImageState extends State<AddBannerImage> {



  var name, redirect;
  TextEditingController nameController = new TextEditingController();
  TextEditingController redirectController = new TextEditingController();





  String? _chosenValue;
  String image = "";
  String base64Image = "";
  String fileName = "";
  File? file;
  bool isLoading = false;
  final picker = ImagePicker();
  //get kPrimaryColor => null;

  bool isloading = false;
   final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            SizedBox(
              height: 4.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
              child: TextFormField(
               controller: nameController,
                decoration: InputDecoration(
                    hintText: "Image Title",
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
                    "Please select reffrence screen",
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
                child:file == null
                    ?  Padding(
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
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                color: Colors.grey.shade300,
                                size: 10.h,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "Choose Image",
                                style: TextStyle(
                                    color: Colors.grey.shade300,
                                    fontSize: 15.sp),
                              )
                            ],
                          ),
                        ),
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
                                  image: FileImage(File(file!.path))
                                  )
                                  ),
                        ),
                      )),

            
            
            isloading == true ?

            Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
            :
            
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 5.h),
              child: GestureDetector(
                onTap: () {
                   
                     print("name: "+nameController.text.toString());
                     print("value: " + _chosenValue.toString());
                     print("reffrence id: "+ redirectController.toString());
                          uploadData(
                           nameController.text.toString(),

                           



                          

                         

                          _chosenValue.toString(),

                          

                          redirectController.text.toString()

                          
                         
                         
                          
                          );
                          print("name: " +nameController.text.toString());
                          print("redirect: " +_chosenValue.toString());

                          

                       
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
        RestDatasource.ADDBANNER_URL,
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
