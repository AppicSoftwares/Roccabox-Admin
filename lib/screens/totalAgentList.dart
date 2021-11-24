import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:roccabox_admin/ChatModule/chatscreen.dart';
import 'package:roccabox_admin/screens/addAgent.dart';
import 'package:roccabox_admin/screens/agentSearchBar.dart';

import 'package:roccabox_admin/screens/chatDemo.dart';
import 'package:roccabox_admin/screens/editAgent.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:http/http.dart' as http;
import 'package:roccabox_admin/theme/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';

class TotalAgentList extends StatefulWidget {





  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<TotalAgentList> {


  var name = "";
  var email = "";
  var phone = "";
  var image = "";
  var country_code = "";
  var id = "";

  bool isloading = false;


  @override
  void initState() {
    super.initState();
   // agentListApi();
    
  }
  

  List <TotalAgentListApi> apiList = [];



  
 
  String selected = "second";

  ScrollController _controller = new ScrollController();
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(
              "Agent List",
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
                  context, MaterialPageRoute(builder: (context) => AddAgent()));
            },
            child: Container(
              margin: EdgeInsets.only(top: .5.h, right: 1.h, bottom: .5.h),
              height: 5.h,
              width: 20.w,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(2.w)),
              child: Center(
                child: Text("Add Agent",
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AgentSearchbar()));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 7.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.w),
                            border: Border.all(
                              color: Colors.grey
                            )
                          ),

                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text('Search',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp
                              ),
                              ),

                              Icon(
                                    Icons.search,
                                    size: 8.w,
                                    color: Colors.grey
                                  ),

                            ],),
                          )



                          // TextFormField(
                          //    onChanged: (value){
                          //   searchData(value.toString());
                          // },
                          // validator: (val) {

                          // },

                          //   decoration: InputDecoration(
                          //       suffixIcon: Icon(
                          //         Icons.search,
                          //         size: 8.w,
                          //       ),
                          //       hintText: 'Search',
                          //       border: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(3.w),
                          //           borderSide: BorderSide(color: Colors.grey)),
                          //       labelStyle: TextStyle(
                          //           fontSize: 15, color: Color(0xff000000))),
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selected = "first";
                            });
                          },
                          child: Container(
                            height: 6.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                                color: selected == 'first'
                                    ? kPrimaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                    color: selected == 'first'
                                        ? kPrimaryColor
                                        : Color(0xffD5D5D5))),
                            child: Center(
                              child: Text(
                                "New Request",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: selected == 'first'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selected = "second";
                            });
                          },
                          child: Container(
                            height: 6.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                                color: selected == 'second'
                                    ? kPrimaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                    color: selected == 'second'
                                        ? kPrimaryColor
                                        : Color(0xffD5D5D5))),
                            child: Center(
                              child: Text(
                                "Agent List",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: selected == 'second'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),

                    selected == "second" ? AgentList() : NewRequest()
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
      child: FlutterSwitch(
        width: 125.0,
        height: 50.0,
        valueFontSize: 25.0,
        activeColor: Colors.green,
        inactiveColor: Colors.grey,
        toggleSize: 35.0,
        value: status,
        borderRadius: 20.0,
        showOnOff: true,
        onToggle: (val) {
          setState(() {
            status = val;
          });
        },
      ),
    );
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
        TotalAgentListApi modelSearch = new TotalAgentListApi();
        modelSearch.name = jsonArray[i]["name"];
        modelSearch.id = jsonArray[i]["id"].toString();
        modelSearch.email = jsonArray[i]["email"].toString();
        modelSearch.phone = jsonArray[i]["phone"].toString();
        modelSearch.image = jsonArray[i]["image"].toString();
        modelSearch.country_code = jsonArray[i]["country_code"].toString();
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

  void getId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString();
    print("id Print: " +id.toString());
  }




}

class NewRequest extends StatefulWidget {


  

  

  @override
  _NewRequestState createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {

  var name = "";
  var email = "";
  var phone = "";
  var image = "";
  var country_code = "";

  bool isloading = false;


  @override
  void initState() {
    super.initState();
newAgentListApi();
    
    
  }
  

  List <NewRequestAgentList> apiAgentList = [];



  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return  isloading
        ? Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            
          ),
        )
        :
    
    ListView.builder(
      shrinkWrap: true,
      controller: _controller,
      itemCount: apiAgentList.length,
      itemBuilder: (BuildContext context, int index) {
        return 

       
        
        Container(
          child: Column(
            children: [
              

              
              ListTile(
                leading: CircleAvatar(
                    maxRadius: 9.w, child: Image.asset("assets/Avatar.png")),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //"Testing User",
                      apiAgentList[index].name.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                     // "test@gmail.com",
                     apiAgentList[index].email.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                    ),
                      Row(
                                  children: [
                                     Text(
                                      apiAgentList[index].country_code.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(fontSize: 8.sp, color: Colors.grey),
                                    ),
                                    Text(
                                      apiAgentList[index].phone.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(fontSize: 8.sp, color: Colors.grey),
                                    ),
                                  ],
                                ),
                  ],
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        approveDialog(index);
                      },
                      child: Container(
                        
                        height: 2.5.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            color: kGreenColor,
                            borderRadius: BorderRadius.circular(2.w)),
                        child: Center(
                          child: Text("Approve",
                              style: TextStyle(
                                  fontSize: 8.sp, color: Colors.white)),
                        ),
                      ),
                    ),

                    SizedBox(
                      height:0.5.h
                    ),

                    InkWell(
                      onTap: () {
                        rejectDialog(index);
                      },
                      child: Container(
                        
                        height: 2.5.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            color: kRedColor,
                            borderRadius: BorderRadius.circular(2.w)),
                        child: Center(
                          child: Text("Reject",
                              style: TextStyle(
                                  fontSize: 8.sp, color: Colors.white)),
                        ),
                      ),
                    ),
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
    );
  }

   Future<dynamic> newAgentListApi() async {
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

          RestDatasource.NEWREQUESTAGENTLIST_URL + "admin_id=" + id.toString()
          
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
          apiAgentList.clear();
    


      for (var i = 0; i < jsonArray.length; i++) {
        NewRequestAgentList modelAgentSearch = new NewRequestAgentList();
        modelAgentSearch.name = jsonArray[i]["name"];
        modelAgentSearch.id = jsonArray[i]["id"].toString();
        modelAgentSearch.email = jsonArray[i]["email"].toString();
        modelAgentSearch.phone = jsonArray[i]["phone"].toString();
        modelAgentSearch.image = jsonArray[i]["image"].toString();
        modelAgentSearch.country_code = jsonArray[i]["country_code"].toString();

        print("id: "+modelAgentSearch.id.toString());

        apiAgentList.add(modelAgentSearch);
        
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








  approveDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: SingleChildScrollView(
            child: Container(
              //width: MediaQuery.of(context).size.width*.60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

               


                  Text("Are you sure\n"
                  "You want to approve this agent?",
                  style: TextStyle(
                    fontSize: 10.sp
                  ),
                  textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 20,),
                 
                 
                  GestureDetector(
                    onTap: () {
                      approveData(index);
                      
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: kGreenColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Approve',
                          style: TextStyle(
                              
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
        );
      },
    );
    }


     Future<dynamic> approveData(int index) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
    setState(() {
       isloading = true;
    });



    var request = http.post(
      Uri.parse(
        RestDatasource.APPROVEAGENTLIST_URL,
      ),
      body: {
        "admin_id":id.toString(),
        "user_id":apiAgentList[index].id.toString()
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
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonRes["message"].toString())));
            newAgentListApi();
        
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




  rejectDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: SingleChildScrollView(
            child: Container(
              //width: MediaQuery.of(context).size.width*.60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

               


                  Text("Are you sure\n"
                  "You want to reject this agent?",
                  style: TextStyle(
                    fontSize: 10.sp
                  ),
                  textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 20,),
                 
                 
                  GestureDetector(
                    onTap: () {
                      rejectData(index);
                      
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: kRedColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Reject',
                          style: TextStyle(
                              
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
        );
      },
    );
    }


 Future<dynamic> rejectData(int index) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
    setState(() {
       isloading = true;
    });



    var request = http.post(
      Uri.parse(
        RestDatasource.REJECTAGENTLIST_URL,
      ),
      body: {
        "admin_id":id.toString(),
        "user_id":apiAgentList[index].id.toString()
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
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonRes["message"].toString())));
            newAgentListApi();
        
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

class AgentList extends StatefulWidget {


  @override
  _AgentListState createState() => _AgentListState();
}

class _AgentListState extends State<AgentList> {


  var name = "";
  var email = "";
  var phone = "";
  var image = "";
  var country_code = "";
  var id = "";
  var total = "36";
  bool isloading = false;


  @override
  void initState() {
    super.initState();

    agentListApi();
    
  }
  

  List <TotalAgentListApi> apiList = [];




  bool status = false;
  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
   // print("Main:" + widget.agents.toString());
    return isloading
    ?
    Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator()
    )
    :

    ListView(
      shrinkWrap: true,
            controller: _controller,

            children: [
              Column(
                children: [

                  Text(
                    "Total Agent: " + apiList.length.toString(),
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),

                  ListView.builder(
      shrinkWrap: true,
      controller: _controller,
      itemCount: apiList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 12.h,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                    maxRadius: 9.w, child: Image.asset("assets/Avatar.png")),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //"Testing User",
                      apiList[index].name.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                     // "test@gmail.com",
                     apiList[index].email.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 8.sp, color: Colors.grey),
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
                                      overflow: TextOverflow.ellipsis,
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
                            Navigator.push(context, MaterialPageRoute(builder: (Context) => ChatScreen(image: apiList[index].image,name: apiList[index].name,receiverId: apiList[index].id,senderId: id,fcm: apiList[index].firebase_token,userType: "agent",)));
                          },
                          child: Image.asset(
                            "assets/comment.png",
                            width: 6.w,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            "assets/callicon.png",
                            width: 6.w,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:  (context) => EditAgent(
                              name: apiList[index].name.toString(),
                                            phone: apiList[index].phone.toString(),
                                            email: apiList[index].email.toString(),
                                            country_code: apiList[index].country_code.toString(),
                                            id: apiList[index].id.toString(),



                            )));
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
                          onTap: () {



                            customDialog(index);
                          },
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
                    customSwitch()
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
              )
            ],
    );

   
    
    
    
  }

   customSwitch() {
    return Expanded(
      child: Container(
        height: 3.1.h,
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
          ),
    );
  }

   Future<dynamic> agentListApi() async {
       SharedPreferences prefs = await SharedPreferences.getInstance();
       id = prefs.getString("id").toString();
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

          RestDatasource.TOTALAGENTLIST_URL + "admin_id=" + id.toString()+"&PageNumber=1&PageSize=36"
          
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
          apiList.clear();
        total = jsonRes["total"].toString();


      for (var i = 0; i < jsonArray.length; i++) {
        TotalAgentListApi modelSearch = new TotalAgentListApi();
        modelSearch.name = jsonArray[i]["name"];
        modelSearch.id = jsonArray[i]["id"].toString();
        modelSearch.email = jsonArray[i]["email"].toString();
        modelSearch.phone = jsonArray[i]["phone"].toString();
        modelSearch.image = jsonArray[i]["image"].toString();
        modelSearch.country_code = jsonArray[i]["country_code"].toString();
        modelSearch.firebase_token = jsonArray[i]["firebase_token"].toString();

        print("id: "+modelSearch.id.toString());

        apiList.add(modelSearch);
        
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


  Future<dynamic> agentListApi2() async {
    print("AgentList2 "+"Running");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString();
    print(id.toString());

    // print(email);
    // print(password);
    String msg = "";
    var jsonRes;
    http.Response? res;
    var jsonArray;
    var request = http.get(
      Uri.parse(

          RestDatasource.TOTALAGENTLIST_URL + "admin_id=" + id.toString()+"&PageNumber=1&PageSize=$total"

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
        apiList.clear();
        total = jsonRes["total"].toString();


        for (var i = 0; i < jsonArray.length; i++) {
          TotalAgentListApi modelSearch = new TotalAgentListApi();
          modelSearch.name = jsonArray[i]["name"];
          modelSearch.id = jsonArray[i]["id"].toString();
          modelSearch.email = jsonArray[i]["email"].toString();
          modelSearch.phone = jsonArray[i]["phone"].toString();
          modelSearch.image = jsonArray[i]["image"].toString();
          modelSearch.country_code = jsonArray[i]["country_code"].toString();
          modelSearch.firebase_token = jsonArray[i]["firebase_token"].toString();

          print("id: "+modelSearch.id.toString());

          apiList.add(modelSearch);

        }

        print("SizeAgentList2 "+apiList.length.toString());

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
                          "to delete this agent",
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
                      deleteData(index);
                     
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



   Future<dynamic> deleteData( int index) async {

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

        setState(() {
          isloading = false;
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonRes["message"].toString())));
            agentListApi();
        
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


class TotalAgentListApi {
  var id = "";
  var name = "";
  var email = "";
  var phone = "";
  var image = "";
  var country_code = "";
  var firebase_token = "";

}

class NewRequestAgentList {

  var id = "";
  var name = "";
  var email = "";
  var phone = "";
  var image = "";
  var country_code = "";

}




