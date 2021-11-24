import 'dart:convert';
import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roccabox_admin/screens/banners.dart';
import 'package:roccabox_admin/screens/languageCheck.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class AddBannerImage extends StatefulWidget {
  const AddBannerImage({Key? key}) : super(key: key);

  @override
  _AddBannerImageState createState() => _AddBannerImageState();
}

class _AddBannerImageState extends State<AddBannerImage> {



  var name, redirect;
  TextEditingController nameController = new TextEditingController();
  TextEditingController redirectController = new TextEditingController();
  String selected = "For Sale";
  String? _chosenValue = "List your property";


  List svgs = ['forsale', 'develop', 'svg1', 'apartment'];
  LanguageChange languageChange = new LanguageChange();
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
                    hintText: "Type reference Id of Property",
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
            Visibility(
              visible:  _chosenValue == "List your property" ? true : false,
              child: Text(
                'Select Category of Property',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000)),
              ),
            ),
            Visibility(
              visible:  _chosenValue == "List your property" ? true : false,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 20),
                child:  Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {

                              setState(() {
                                selected = "For Sale";
                              });

                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              height: 105,
                              width: MediaQuery.of(context).size.width * .42,
                              decoration: BoxDecoration(
                                  color: selected == 'For Sale' ? Color(0xffF0EBE7) : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color(0xffD5D5D5))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/${svgs.elementAt(0)}.svg',
                                    width: 40,
                                  ), //for sale
                                  SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(languageChange.FORSALE[langCount],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            color: Color(0xff111111))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {

                              setState(() {
                                selected = "New Developments";
                              });

                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              height: 105,
                              width: MediaQuery.of(context).size.width * .42,
                              decoration: BoxDecoration(
                                  color: selected == 'New Developments' ? Color(0xffF0EBE7) : Colors.white,
                                  //Color(0xffF0EBE7),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color(0xffD5D5D5))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/${svgs.elementAt(3)}.svg',
                                    width: 35, //new developers
                                    color: Color(0xffFFBA00),
                                  ),
                                  SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(languageChange.DEVELOP[langCount],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            color: Color(0xff111111))),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = "Long-term Rental";
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 105,
                                width: MediaQuery.of(context).size.width * .42,
                                decoration: BoxDecoration(
                                    color: selected == 'Long-term Rental' ? Color(0xffF0EBE7) : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Color(0xffD5D5D5))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/${svgs.elementAt(1)}.svg',
                                      width: 32,
                                    ), // long term rental,
                                    SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(languageChange.LONGTERM[langCount],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color: Color(0xff111111))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {

                                setState(() {
                                  selected = "Holiday Rental";
                                });


                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 105,
                                width: MediaQuery.of(context).size.width * .42,
                                decoration: BoxDecoration(
                                    color: selected == 'Holiday Rental' ? Color(0xffF0EBE7) : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Color(0xffD5D5D5))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/${svgs.elementAt(2)}.svg',
                                      width: 45,
                                      color: Color(0xffFFBA00),
                                    ),
                                    SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(languageChange.HOLIDAY[langCount],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color: Color(0xff111111))),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // child: DropdownButtonFormField(
                //     decoration: InputDecoration(
                //         isDense: true,
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10))),
                //     hint: Text(
                //       '---Select---',
                //       style: TextStyle(fontSize: 16, color: Color(0xff666666)),
                //     ),
                //     value: listing,
                //     onChanged: (String? newvalue) {
                //       setState(() {
                //         listing = newvalue.toString();
                //       });
                //     },
                //     items: name.map((e) {
                //       return DropdownMenuItem(
                //         child: Text(e),
                //         value: e,
                //       );
                //     }).toList()),
              ),
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
                          redirectController.text.toString(),selected);
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

  Future<dynamic> uploadData(String name, String _chosenValue, String redirect,String filterId ) async {
    var P_Agency_FilterId = "1";

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

    if(_chosenValue == "List your property") {

      if (redirect.toString() != "null" || redirect.toString() != "") {
        request.fields["refId"] = redirect.toString();
        print("redirect: " + redirect.toString());
      }
      if (filterId.toString() != "null" || filterId.toString() != "") {
        if (filterId.toString() == "For Sale") {
          P_Agency_FilterId = "1";
        } else if (filterId.toString() == "Long-term Rental") {
          P_Agency_FilterId = "3";
        } else if (filterId.toString() == "Holiday Rental") {
          P_Agency_FilterId = "2";
        }
        // else if (widget.title == "New Developments") {
        //   P_Agency_FilterId = "5";
        // }
        else {
          P_Agency_FilterId = "5";
        }
        request.fields["filter_id"] = P_Agency_FilterId.toString();
        print("redirect: " + redirect.toString());
      }
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
