import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:roccabox_admin/screens/addUser.dart';
import 'package:roccabox_admin/screens/chatDemo.dart';
import 'package:roccabox_admin/screens/editUser.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:http/http.dart' as http;
import 'package:roccabox_admin/theme/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';

class TotalUserList extends StatefulWidget {

  var customers;
  TotalUserList({required this.customers});


  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<TotalUserList> {

  var name = "";
  var email = "";
  var phone = "";
  var image = "";

  bool isloading = false;


  @override
  void initState() {
    super.initState();

    userListApi();
    
  }
  

  List <TotalUserListApi> apiList = [];




ScrollController _controller = new ScrollController();
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Center(
            child: Text(
              "Users List",
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddUser()));
            },
            child: Container(
              margin: EdgeInsets.only(top: .5.h, right: 1.h, bottom: .5.h),
              height: 5.h,
              width: 20.w,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(2.w)),
              child: Center(
                child: Text("Add User",
                    style: TextStyle(fontSize: 9.sp, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
      body: SizerUtil.deviceType == DeviceType.mobile
          ? ListView(
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
                    "Total User: " + widget.customers,
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),



                  ListView.builder(
                    shrinkWrap: true,
                     controller: _controller,
                    itemCount: 12,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 12.h,
                        child: Column(
                          children: [
                            ListTile(
                    leading: image == null
                                    ? Image.asset(
                                        'assets/Avatar.png',
                                      )
                                    : CircleAvatar(
                                      radius: 30,
                                        backgroundImage: NetworkImage(apiList[index].image.toString()),
                                      ),
                    title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiList[index].name.toString(),
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                               apiList[index].email.toString(),
                               overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(fontSize: 8.sp, color: Colors.grey),
                              ),
                              Text(
                                apiList[index].phone.toString(),
                                style:
                                    TextStyle(fontSize: 8.sp, color: Colors.grey),
                              ),
                            ],
                    ),
                    trailing: Column(
                            children: [
                              
                              Row(
                               mainAxisSize: MainAxisSize.min,
                               
                               
                                children: [
                                   InkWell(
                                     onTap: () {
                                       Navigator.push(context, MaterialPageRoute(builder: (Context) => ChatDemo()));
                                     },

                                    child: Image.asset("assets/comment.png",
                                    width: 6.w,
                                    
                                    ),
                                  ),
                                   
                                   SizedBox(width: 1.w,),
                                  InkWell(
                                     onTap: () {},

                                    child: Image.asset("assets/callicon.png",
                                    width: 6.w,
                                    
                                    ),
                                  ),
                                   
                                   SizedBox(width: 1.w,),
                                 InkWell(
                                     onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditUser()));
                                     },

                                    child: Image.asset("assets/edit.png",
                                    width: 6.w,
                                    
                                    ),
                                  ),
                                   
                                   SizedBox(width: 1.w,),
                                  InkWell(
                                     onTap: () {
                                      
                                     },

                                    child: Image.asset("assets/delete.png",
                                    width: 6.w,
                                    
                                    ),
                                  ),
                                   
                                   SizedBox(width: 1.w,),
                                ],
                              ),

                              SizedBox(height: 0.5.h,),
                             customSwitch()
                            ],
                    ),
                  ),

                  SizedBox(height: 1.5.h,),

                  Container(
                    width: double.infinity,
                    height: 0.1.h,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 1.5.h,),


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

  customSwitch() {
    return Container(
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
            value: status,
            borderRadius: 2.0,
            activeText: "Active",
            inactiveText: "Deactive",
            inactiveTextColor: Colors.black,

            
            
            
            showOnOff: true,
            onToggle: (val) {
              setState(() {
                status = val;
              });
            },
          ),
        );
  }


    Future<dynamic> userListApi() async {
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

          RestDatasource.TOTALUSERLIST_URL + "admin_id=" + id.toString()
          
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

      name = jsonRes["data"][0]["name"].toString();
      print(name.toString());


      for (var i = 0; i < jsonArray.length; i++) {
        TotalUserListApi modelSearch = new TotalUserListApi();
        modelSearch.name = jsonArray[i]["name"];
        modelSearch.email = jsonArray[i]["email"].toString();
        modelSearch.phone = jsonArray[i]["phone"].toString();
        modelSearch.image = jsonArray[i]["image"].toString();

        print(modelSearch.name.toString());

        apiList.add(modelSearch);
        
      }

      // for (var i = 0; i < apiList.length; i++) {

      //   print(apiList[1].toString());
        
      // }

      // agents = jsonRes["data"]["agents"].toString();
      // print(agents.toString());
      
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => HomeNav()),
          //  (route) => false);

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


class TotalUserListApi {

  var name = "";
  var email = "";
  var phone = "";
  var image = "";
  
}
