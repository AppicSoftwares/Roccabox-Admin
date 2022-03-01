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
import 'package:roccabox_admin/main.dart';
import 'package:roccabox_admin/screens/addUser.dart';
import 'package:roccabox_admin/screens/chatDemo.dart';
import 'package:roccabox_admin/screens/editUser.dart';
import 'package:roccabox_admin/screens/enquiry.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:http/http.dart' as http;
import 'package:roccabox_admin/theme/constant.dart';
import 'package:select_dialog/select_dialog.dart';
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
  List<TotalAgentListApi> agentList = [];




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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddUser(customers: widget.customers,)));
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
                    apiList.length==0?Center(child: Text("No Users found", style: TextStyle(fontSize: 20),),):ListView.builder(
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
                      leading: apiList[index].image.toString() == "null"
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
                                         // print(apiList[index].id.toString());
                                          assignAgentDialoge(apiList[index].id.toString());
                                        },

                                        child: Image.asset("assets/assign_agent.png",
                                          width: 6.w,

                                        ),
                                      ),

                                      SizedBox(width: 1.w,),
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
                                           if(!isPressed) {
                                             getAccessToken(
                                                 apiList[index].id, "VOICE");
                                           }
                                         },

                                        child: Image.asset("assets/callicon.png",
                                        width: 6.w,

                                        ),
                                      ),

                                       SizedBox(width: 1.w,),
                                     InkWell(
                                         onTap: () {
                                           print("Iddd "+apiList[index].name.toString()+"^");
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditUser(
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


  assignAgentDialoge(String user_id) {
    var selectedAgent = "";
    TextEditingController nameController = new TextEditingController();
    TextEditingController emailController = new TextEditingController();
    TextEditingController phoneController = new TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
          title: SingleChildScrollView(
            child: Container(
              //width: MediaQuery.of(context).size.width*.60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Assign Lead',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 7.w,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  Container(
                    color: Colors.grey,
                    height: 0.1.h,
                    width: double.infinity,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Name',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000)),
                  ),
                  InkWell(

                      onTap: () {
                        print("Hello: "+apiList.length.toString());
                        SelectDialog.showModal<TotalAgentListApi>(


                          context,
                          label: "Please select an agent",
                          items: agentList,
                          showSearchBox: false,
                          itemBuilder: (BuildContext context,
                              TotalAgentListApi item, bool isSelected) {
                            return Container(
                              decoration: !isSelected
                                  ? null
                                  : BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                border: Border.all(
                                    color:
                                    Theme.of(context).primaryColor),
                              ),
                              child: InkWell(
                                onTap: () {
                                  print("lendth: "+apiList.length.toString());
                                  print("email: "+item.email.toString()+"^^^");
                                  print("number: "+item.phone.toString()+"^^^");
                                  selectedAgent = item.id;


                                  setState(() {
                                    nameController.text = item.name.toString();

                                    //   serviceController.text = "";
                                    emailController.text =
                                        item.email.toString();

                                    phoneController.text =
                                        item.phone.toString();

                                    // isLoading = true;
                                    //  personalInfoPresenter.getSubCat(catId.toString());
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: ListTile(
                                  leading: item.name == "null"
                                      ? null
                                      : Text(
                                    item.name.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),


                                  selected: isSelected,
                                ),
                              ),
                            );
                          },

                        );
                      },
                      child: Container(
                        height: 5.h,
                        child: TextField(
                          enabled: false,
                          controller: nameController,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                size: 8.w,
                              ),
                              hintText: "Agent's Name",
                              hintStyle: TextStyle(fontSize: 9.sp),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      )),





                  SizedBox(
                    height: 1.h,
                  ),

                  Text(
                    'Email Address',
                    style: TextStyle(

                        fontFamily: 'Poppins',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000)),
                  ),
                  Container(
                    height: 5.h,
                    child: TextField(
                      controller: emailController,
                      enabled: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                          counterText: "",
                          hintText: "email@gmail.com",
                          hintStyle: TextStyle(fontSize: 9.sp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'Mobile Number',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000)),
                  ),
                  Container(
                    height: 5.h,
                    child: TextField(
                      controller: phoneController,
                      enabled: false,
                      maxLength: 10,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                          counterText: "",
                          hintText:"9876543210",
                          hintStyle: TextStyle(fontSize: 9.sp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.w))),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      assignAgentApi(user_id, selectedAgent);
                    },
                    child: Container(
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Color(0xffFFBA00),
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      child: Center(
                        child: Text(
                          'Assign Agent',
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

  customSwitch(int index) {
    return Expanded(
      child: Container(
        height: 3.2.h,
        width: 33.w,
        
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

                    apiList[index].status = "0";
                  } else {

                    apiList[index].status = "1";
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
   isPressed = true;
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


        }, headers: mapheaders);

    await request.then((http.Response response) {
      res = response;
      isPressed = false;
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

  Future<dynamic> assignAgentApi(String userId, String selectedAgent) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");

    print("id Print: " + id.toString());
    print("agentId: " +selectedAgent.toString());
    print("userId: " +userId.toString());
    setState(() {
      isloading = true;
    });

    var request = http.post(
        Uri.parse(
          RestDatasource.ENQUIRYASSIGN_URL,
        ),
        body: {
          "agent_id": selectedAgent.toString(),
          "user_id": userId.toString(),
          "admin_id" : id.toString()
          //"enquiry_id":
        });

    var jsonRes;
    var res;
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
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(this.context).showSnackBar(
            SnackBar(content: Text(jsonRes["message"].toString())));

      } else {
        setState(() {
          isloading = false;
          ScaffoldMessenger.of(this.context).showSnackBar(
              SnackBar(content: Text(jsonRes["message"].toString())));
        });
      }
    } else {
      setState(() {
        isloading = false;
        ScaffoldMessenger.of(this.context)
            .showSnackBar(SnackBar(content: Text("Please try later")));
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
        agentListApi();
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

  Future<dynamic> agentListApi() async {

    print("Total Agent "+totalAgent.toString());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    print(id.toString());

    // print(email);
    // print(password);
    String msg = "";
    var jsonRes;
    http.Response? res;
    var jsonArray;
    var request = http.get(
      Uri.parse(
          RestDatasource.TOTALAGENTLIST_URL + "admin_id=" + id.toString()+"&PageNumber=1&PageSize="+totalAgent.toString()),
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
        agentList.clear();

        for (var i = 0; i < jsonArray.length; i++) {
          TotalAgentListApi modelSearch = new TotalAgentListApi();
          modelSearch.name = jsonArray[i]["name"];
          modelSearch.id = jsonArray[i]["id"].toString();
          modelSearch.email = jsonArray[i]["email"].toString();
          modelSearch.phone = jsonArray[i]["phone"].toString();
          //modelSearch.image = jsonArray[i]["image"].toString();
          modelSearch.country_code = jsonArray[i]["country_code"].toString();



          agentList.add(modelSearch);
        }
        //allData();


      }
    } else {
      ScaffoldMessenger.of(this.context)
          .showSnackBar(SnackBar(content: Text('Error while fetching data')));

      setState(() {
        isloading = false;
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
                          'Yes',
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
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> TotalUserList(customers: widget.customers)));
        
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