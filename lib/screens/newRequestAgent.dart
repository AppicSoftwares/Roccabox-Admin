import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:roccabox_admin/screens/addAgent.dart';
import 'package:roccabox_admin/screens/agentSearchBar.dart';
import 'package:roccabox_admin/services/apiClient.dart';

import 'package:roccabox_admin/theme/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;


class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({ Key? key }) : super(key: key);

  @override
  _NewRequestScreenState createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {


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

    body: ListView(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            
                          },
                          child: Container(
                            height: 6.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                    color: kPrimaryColor)),
                            child: Center(
                              child: Text(
                                "New Request",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AgentSearchbar()));
                          },
                          child: Container(
                            height: 6.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                    color: Color(0xffD5D5D5))),
                            child: Center(
                              child: Text(
                                "Agent List",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),


                    
                    SizedBox(
                      height: 2.h,
                    ),

                     Text(
                    "Total Agent: " + apiAgentList.length.toString(),
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),




                      isloading
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
    )
                    
                    
                  ],
                ),
              ],
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
        RestDatasource.SEARCHNEWAGENTLIST_URL + "admin_id=" + id.toString() + "&key=" + key.toString()
        
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
          apiAgentList.clear();
    


      for (var i = 0; i < jsonArray.length; i++) {
        NewRequestAgentList modelSearch = new NewRequestAgentList();
        modelSearch.name = jsonArray[i]["name"];
        modelSearch.id = jsonArray[i]["id"].toString();
        modelSearch.email = jsonArray[i]["email"].toString();
        modelSearch.phone = jsonArray[i]["phone"].toString();
        modelSearch.image = jsonArray[i]["image"].toString();
        modelSearch.country_code = jsonArray[i]["country_code"].toString();

        print("id: "+modelSearch.id.toString());

        apiAgentList.add(modelSearch);
        
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
      ScaffoldMessenger.of(this.context)
          .showSnackBar(SnackBar(content: Text('Error while fetching data')));

      setState(() {
        isloading = false;
      });
    }
  }








  approveDialog(int index) {
    showDialog(
      context: this.context,
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
                      Navigator.of(context,rootNavigator: true).pop();

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
        //Navigator.pop(this.context);
        ScaffoldMessenger.of(this.context).showSnackBar(
            SnackBar(content: Text(jsonRes["message"].toString())));
            newAgentListApi();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AgentSearchbar()));
        
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
        ScaffoldMessenger.of(this.context).showSnackBar(
            SnackBar(content: Text("Please try later")));
      
      });
    }
  }




  rejectDialog(int index) {
    showDialog(
      context: this.context,
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
                      Navigator.of(context,rootNavigator: true).pop();

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
        ScaffoldMessenger.of(this.context).showSnackBar(
            SnackBar(content: Text(jsonRes["message"].toString())));
            newAgentListApi();
        
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
        ScaffoldMessenger.of(this.context).showSnackBar(
            SnackBar(content: Text("Please try later")));
      
      });
    }
  }



}



class NewRequestAgentList {

  var id = "";
  var name = "";
  var email = "";
  var phone = "";
  var image = "";
  var country_code = "";

}