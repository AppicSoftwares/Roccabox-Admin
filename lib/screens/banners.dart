import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:roccabox_admin/screens/addBannerImage.dart';
import 'package:roccabox_admin/screens/addUser.dart';
import 'package:roccabox_admin/screens/editBannerImage.dart';
import 'package:http/http.dart' as http;
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:roccabox_admin/theme/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Banners extends StatefulWidget {
  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Banners> {

  var id = "";
  var name = "";
  var url = "";
  var redirect = "";
  var status = "";
  var created_at = "";
  var updated_at = "";

    @override
  void initState() {
    super.initState();

    sliderBannerApi();
    
  }
  

  List <BannerProperties> bannerList = [];





  bool isloading = false;
  ScrollController _controller = new ScrollController();
  bool status1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Center(
            child: Text(
              "Banners",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddBannerImage()));
            },
            child: Container(
              margin: EdgeInsets.only(top: .5.h, right: 1.h, bottom: .5.h),
              height: 5.h,
              width: 20.w,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(3.w)),
              child: Center(
                child: Text("Add Image",
                    style: TextStyle(fontSize: 9.sp, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
      body: SizerUtil.deviceType == DeviceType.mobile
          ? isloading ?

          Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
          :
          ListView(
              shrinkWrap: true,
              controller: _controller,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 7.h,
                        child: TextFormField(
                          validator: (val) {},
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                size: 8.w,
                              ),
                              hintText: 'Search',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.w),
                                  borderSide: BorderSide(color: Colors.grey)),
                              labelStyle: TextStyle(
                                  fontSize: 15, color: Color(0xff000000))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Total Image: " +bannerList.length.toString(),
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      controller: _controller,
                      itemCount: bannerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 12.h,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 10.h,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(2.w),
                                    image: DecorationImage(
                                      image:
                                          NetworkImage(bannerList[index].url.toString()),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      //"Rajveer Place",
                                      bannerList[index].name.toString(),
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      //"28-09-2021",

                                      bannerList[index].created_at.toString() == "null" ?

                                      ""

                                      :

                                      bannerList[index].created_at.substring(0,9).toString(),
                                      style: TextStyle(
                                          fontSize: 8.sp, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        InkWell(
                                          onTap: () {

                                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditBannerImage()));
                                          },
                                          child: Image.asset(
                                            "assets/edit.png",
                                            width: 6.w,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Image.asset(
                                            "assets/delete.png",
                                            width: 6.w,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 0.5.h,),
                                    customSwitch(index)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Container(
                                width: double.infinity,
                                height: 0.1.h,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            )
          : Container(
              // Widget for Tablet
              width: 100.w,
              height: 12.5.h,
            ),
    );
  }




    Future<dynamic> sliderBannerApi() async {
       SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print(id.toString());
    setState(() {
       isloading = true;
    });
    // print(email);
    // print(password);
    String msg = "";
    var jsonRes;
    http.Response? res;
    var jsonArray;
    var request = http.get(
        Uri.parse(

          RestDatasource.SLIDERBANNER_URL + "admin_id=" + id.toString() + "&status=all"
          
        ),
       );

    await request.then((http.Response response) {
      res = response;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Response: " + response.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      print("status: " + jsonRes["status"].toString() + "_");
      print("message: " + jsonRes["message"].toString() + "_");
      msg = jsonRes["message"].toString();
      jsonArray = jsonRes['data'];
    });
    if (res!.statusCode == 200) {

      if (jsonRes["status"] == true) {
          bannerList.clear();
    


      for (var i = 0; i < jsonArray.length; i++) {
        BannerProperties modelSearch = new BannerProperties();
        modelSearch.id = jsonArray[i]["id"].toString();
        modelSearch.name = jsonArray[i]["name"];
        
        modelSearch.url = jsonArray[i]["url"].toString();
        modelSearch.redirect = jsonArray[i]["redirect"].toString();
        modelSearch.status = jsonArray[i]["status"].toString();
        modelSearch.created_at = jsonArray[i]["created_at"].toString();
        modelSearch.updated_at = jsonArray[i]["updated_at"].toString();

        print("id: "+modelSearch.id.toString());

        bannerList.add(modelSearch);
        
      }

     

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









 customSwitch(int index) {
    return Expanded(
      child: Container(
        height: 3.2.h,
        width: 28.w,
        
            child: FlutterSwitch(
               width: 125
               ,
              // height: 50.0,
              valueFontSize: 10.0,
              activeColor: kGreenColor,
              inactiveColor: Colors.grey.shade300,
              toggleSize: 20.0,
              value: bannerList[index].status ==  1 ? true  : false  ,
              borderRadius: 2.0,
              activeText: "Active",
              inactiveText: "Deactive",
              inactiveTextColor: Colors.black,
    
              
              
              
              showOnOff: true,
              onToggle: (val) {
                setState(() {
                 // status1 = val;
                });
              },
            ),
          ),
    );
  }
}



class BannerProperties {
  var id = "";
  var name = "";
  var url = "";
  var redirect = "";
  var status = "";
  var created_at = "";
  var updated_at = "";
}
