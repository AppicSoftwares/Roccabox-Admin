import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:roccabox_admin/ChatModule/chatscreen.dart';
import 'package:roccabox_admin/agora/dialscreen/dialScreeen.dart';
import 'package:roccabox_admin/agora/videoCall/videoCall.dart';
import 'package:roccabox_admin/screens/addUser.dart';
import 'package:roccabox_admin/screens/chatDemo.dart';
import 'package:roccabox_admin/screens/editUser.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:http/http.dart' as http;
import 'package:roccabox_admin/theme/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SearchUserList extends StatefulWidget {

  var customers;
  SearchUserList({required this.customers});


  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUserList> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  var name = "";
  var email = "";
  var phone = "";
  var image = "";
  var country_code = "";

  bool isloading = false;
  var id ;
  int pageno = 1;
  bool isRefresh = false;
  var totalPage  = 0;
  final firestoreInstance = FirebaseFirestore.instance;
  FirebaseMessaging? auth;
  var token;
  @override
  void initState() {
    super.initState();
    dashBoardApi();
    userListApi("1");
    auth = FirebaseMessaging.instance;
    auth?.getToken().then((value){
      print("FirebaseTokenHome "+value.toString());
      token = value.toString();

    });
  }
  void _onRefresh() async{
    isRefresh = true;
    pageno = 1;
    userListApi("1");

  }
  Future<bool> getPassengerData() async {
    if (isRefresh) {
      pageno = 1;
    } else {
      if (apiList.length >= totalPage) {
        _refreshController.loadNoData();
        return false;
      }
    }


    userListApi(pageno.toString());
    setState(() {});
    return true;
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddUser(
                customers: widget.customers,
              )));
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
          ? SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: (){
          if(apiList.length<totalPage){
            pageno = pageno+1;
            getPassengerData();
          }else{
            _refreshController.loadNoData();
          }
        },
            child: ListView(
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
                          onChanged: (value){
                            searchData(value.toString());
                          },
                          validator: (val) {

                          },
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
                      "Total User: " + widget.customers.toString(),
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
/*

                    isloading
                    ? Align(
                      alignment: Alignment.center,
                       child: CircularProgressIndicator(),

                    )
                    :
*/



                    ListView.builder(
                      shrinkWrap: true,
                       controller: _controller,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: apiList.length,
                      itemBuilder: (BuildContext context, int index) {
                        print("Image "+apiList[index].image.toString());
                        return Container(
                          height: 13.h,
                          child: Column(
                            children: [
                              Container(

                                child: ListTile(
                      leading: apiList[index].image == null
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
                                    overflow: TextOverflow.ellipsis,
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
                                  Row(
                                    children: [
                                       Text(
                                        apiList[index].country_code.toString(),
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
                                ],
                      ),
                      trailing: Column(
                                children: [

                                  Row(
                                   mainAxisSize: MainAxisSize.min,


                                    children: [
                                       InkWell(
                                         onTap: () {
                                           Navigator.push(context, MaterialPageRoute(builder: (Context) => ChatScreen(image: apiList[index].image,name: apiList[index].name,receiverId: apiList[index].id,senderId: id,fcm: apiList[index].firebase_token,userType: "user",)));
                                         },

                                        child: Image.asset("assets/comment.png",
                                        width: 6.w,

                                        ),
                                      ),

                                       SizedBox(width: 1.w,),
                                      InkWell(
                                         onTap: () {
                                           getAccessToken(apiList[index].id, "VOICE");

                                         },

                                        child: Image.asset("assets/callicon.png",
                                        width: 6.w,

                                        ),
                                      ),

                                       SizedBox(width: 1.w,),
                                     InkWell(
                                         onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditUser(
                                              name: apiList[index].name.toString(),
                                              phone: apiList[index].phone.toString(),
                                              email: apiList[index].email.toString(),
                                              country_code: apiList[index].country_code.toString(),
                                              id: apiList[index].id.toString(),
                                              image: apiList[index].image.toString(),
                                              customers: widget.customers,

                                              )));
                                         },

                                        child: Image.asset("assets/edit.png",
                                        width: 6.w,

                                        ),
                                      ),

                                       SizedBox(width: 1.w,),
                                      InkWell(
                                         onTap: () {

                                           customDialog(index);

                                         },

                                        child: Image.asset("assets/delete.png",
                                        width: 6.w,

                                        ),
                                      ),

                                       SizedBox(width: 1.w,),
                                    ],
                                  ),

                                  SizedBox(height: 0.5.h,),
                                 customSwitch(index)
                                ],
                      ),
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

            ),
          )
          : Container(
              // Widget for Tablet
              width: 100.w,
              height: 12.5.h,
            ),
    );
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
              value: apiList[index].status ==  1.toString() ? true  : false  ,
              borderRadius: 2.0,
              activeText: "Active",
              inactiveText: "Deactive",
              inactiveTextColor: Colors.black,
    
              
              
              
              showOnOff: true,
              onToggle: (val)  {
                setState(() {

                  

                  //bannerList[index].status = val.toString();
                  if (apiList[index].status == 1.toString()) {
                    true;
                    
                  } else {
                    false;
                  }

                  userStatus(index, pageno.toString());
                 // status1 = val;
                });
              },
            ),
          ),
    );
  }


  Future<dynamic> getAccessToken(String id, String type) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userid = pref.getString("id");

    print("user_id "+userid.toString());
    // print(email)
        ;
    var jsonRes;
    http.Response? res;
    var request = http.post(Uri.parse(RestDatasource.AGORATOKEN),
        body: {

          "type": type,
          "user_id": userid.toString(),
          "receiver_id": id,
          "time":DateTime.now().millisecondsSinceEpoch.toString()


        });

    await request.then((http.Response response) {
      res = response;

      // msg = jsonRes["message"].toString();
      // getotp = jsonRes["otp"];
      // print(getotp.toString() + '123');t
    });
    if (res!.statusCode == 200) {
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(res!.body.toString());
      print("Response: " + res!.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");


      if(jsonRes["status"]==true){
        var agoraToken = jsonRes["agora_token"].toString();
        var channel = jsonRes["channelName"].toString();
        var name = jsonRes["receiver"]["name"].toString();
        var image = jsonRes["receiver"]["image"].toString();
        var time = jsonRes["time"].toString();
        var fcm = jsonRes["receiver"]["firebase_token"].toString();
        registerCall(userid.toString(),name, image, type, fcm, id, "Calling", agoraToken, channel, time);

      }

    } else {

    }
  }
  void registerCall(String userid, String nm, String img, String type, String fcmToken,String idd, String status, String agoraToken, String channel, String time) async {

    var documentReference = FirebaseFirestore.instance
        .collection('call_master')
        .doc("call_head")
        .collection(userid)
        .doc(time);


    firestoreInstance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        {
          'fcmToken': fcmToken,
          'id': idd,
          'image': img,
          'name': nm,
          'timestamp': time,
          'type': type,
          'callType':"incoming",
          'status': status

        },
      );
    }).then((value) {
      var documentReference = FirebaseFirestore.instance
          .collection('call_master')
          .doc("call_head")
          .collection(idd)
          .doc(time);

      firestoreInstance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'fcmToken': token,
            'id': userid,
            'image': image,
            'name': name,
            'timestamp': time,
            'type': type,
            'callType':"outgoing",
            'status':status
          },
        );
      });
    });
    if(type=="VIDEO"){
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> VideoCall(name:nm ,image:img, channel: channel, token: agoraToken, myId: userid.toString(),time: time,senderId: idd)));

    }else{
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> DialScreen(name:nm ,image:img, channel: channel, agoraToken: agoraToken,myId: userid.toString(),time: time, receiverId: idd, )));

    }
  }


      Future<dynamic> userStatus( int index, String pageno) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
    setState(() {
       isloading = true;
    });



    var request = http.post(
      Uri.parse(
        RestDatasource.USERSTATUS_URL,
      ),
      body: {
        "admin_id":id.toString(),
        "user_id":apiList[index].id.toString()
      }
    );
   
  
    var jsonRes;
    var res ;
 await request.then((http.Response response) {
      res = response;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Response: " + response.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
    });

    if (res.statusCode == 200) {
    
      print(jsonRes["status"]);
      
      if (jsonRes["status"].toString() == "true") {

        setState(() {
          isloading = false;
        });
        //Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonRes["message"].toString())));
           //userListApi(pageno);
           //Navigator.pop(context);

           //userListApi(pageno);




        
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



    Future<dynamic> userListApi(String pageno) async {
       SharedPreferences prefs = await SharedPreferences.getInstance();
       id = prefs.getString("id");
       print("Id "+id.toString()+"");
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

          RestDatasource.TOTALUSERLIST_URL + "admin_id=" + id.toString()+"&PageNumber=$pageno&PageSize=10"
          
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
        if (isRefresh) {
          apiList.clear();
        }

        totalPage = jsonRes["total"];
    


      for (var i = 0; i < jsonArray.length; i++) {
        TotalUserListApi modelSearch = new TotalUserListApi();
        modelSearch.name = jsonArray[i]["name"];
        modelSearch.id = jsonArray[i]["id"].toString();
        modelSearch.email = jsonArray[i]["email"].toString();
        modelSearch.phone = jsonArray[i]["phone"].toString();
        modelSearch.image = jsonArray[i]["image"].toString();
        modelSearch.country_code = jsonArray[i]["country_code"].toString();
        modelSearch.status = jsonArray[i]["status"].toString();
        modelSearch.firebase_token = jsonArray[i]["firebase_token"].toString();

        print("id: "+modelSearch.id.toString());

          apiList.add(modelSearch);

        
      }

     

        setState(() {
          print("Hello World");
          isloading = false;
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
          isRefresh = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error while fetching data')));

      setState(() {
        isloading = false;
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        isRefresh = false;
      });
    }
  }



  Future<dynamic> dashBoardApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    print("print id: "+id.toString());
    setState(() {
      isloading = true;
    });
    // print(email);
    // print(password);
    String msg = "";
    var jsonRes;
    http.Response? res;
    var request = http.get(
      Uri.parse(

          RestDatasource.HOMEPAGE_URL + "admin_id=" + id.toString()

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
    });
    if (res!.statusCode == 200) {
      if (jsonRes["status"] == true) {

        widget.customers = jsonRes["data"]["customers"].toString();


        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => HomeNav()),
        //  (route) => false);
        if(mounted) {
          setState(() {
            isloading = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error while fetching data')));

      setState(() {
        isloading = false;
      });
    }
  }







  customDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
          title: SingleChildScrollView(
            child: Container(
              //width: MediaQuery.of(context).size.width*.60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Text(
                          
                          
                          'Are you Sure you want \n'
                          "to delete this user",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                  
                  SizedBox(
                    height: 2.h,
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
                      deleteData(index, pageno.toString());
                     
                    },
                    child: Container(
                      width: 40.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Color(0xffFFBA00),
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      child: Center(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.sp,
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
        );
      },
    );
  }



   Future<dynamic> deleteData( int index, String pageno) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
    setState(() {
       isloading = true;
    });



    var request = http.post(
      Uri.parse(
        RestDatasource.DELETEUSER_URL,
      ),
      body: {
        "admin_id":id.toString(),
        "user_id":apiList[index].id.toString()
      }
    );
   
  
    var jsonRes;
    var res ;
 await request.then((http.Response response) {
      res = response;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Response: " + response.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
    });

    if (res.statusCode == 200) {
    
      print(jsonRes["status"]);
      
      if (jsonRes["status"].toString() == "true") {
        dashBoardApi();
        setState(() {
          isloading = false;
        });
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonRes["message"].toString())));
            userListApi(pageno);
        
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



  Future<dynamic> searchData(String key ) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
       print("key Print: " +key.toString());
    setState(() {
       isloading = true;
    });



    var request = http.get(
      Uri.parse(
        RestDatasource.SEARCHUSER_URL + "admin_id=" + id.toString() + "&key=" + key.toString()
        
      ),
      
    );
   
    var jsonArray;
    var jsonRes;
    var res ;
 await request.then((http.Response response) {
      res = response;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Response: " + response.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      jsonArray = jsonRes['data'];
    });

     if (res!.statusCode == 200) {

      if (jsonRes["status"] == true) {
          apiList.clear();
    


      for (var i = 0; i < jsonArray.length; i++) {
        TotalUserListApi modelSearch = new TotalUserListApi();
        modelSearch.name = jsonArray[i]["name"];
        modelSearch.id = jsonArray[i]["id"].toString();
        modelSearch.email = jsonArray[i]["email"].toString();
        modelSearch.phone = jsonArray[i]["phone"].toString();
        modelSearch.image = jsonArray[i]["image"].toString();
        modelSearch.country_code = jsonArray[i]["country_code"].toString();
        modelSearch.status = jsonArray[i]["status"].toString();
        modelSearch.firebase_token = jsonArray[i]["firebase_token"].toString();

        print("id: "+modelSearch.id.toString());

        apiList.add(modelSearch);
        
      }

     

        setState(() {
          isloading = false;
        });
      } else {
      setState(() {
        isloading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please try leter")));
      
      });
    }
  }









}



}

class TotalUserListApi {
  var id = "";
  var name = "";
  var email = "";
  var phone = "";
  var image = "";
  var country_code = "";
  var status = "";
  var firebase_token = "";

}