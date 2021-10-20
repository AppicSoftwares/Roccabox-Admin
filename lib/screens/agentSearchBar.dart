import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:roccabox_admin/screens/totalAgentList.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;


class AgentSearchbar extends StatefulWidget {
  var agents;
  AgentSearchbar({required this.agents});

  @override
  _AgentSearchbarState createState() => _AgentSearchbarState();
}

class _AgentSearchbarState extends State<AgentSearchbar> {

   var name = "";
  var email = "";
  var phone = "";
  var image = "";
  var country_code = "";

  bool isloading = false;


  @override
  void initState() {
    super.initState();

  //  agentListApi();
    
  }
  

  List <TotalAgentListApi> apiList = [];




  bool status = false;
  ScrollController _controller = new ScrollController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:  Text("Search Agent List",
        
          style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
        )
      ),


      body: ListView(
        shrinkWrap: true,
        controller: _controller,

        children: [
          Column(
            children: [
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


                    AgentList(agents: widget.agents)





            ],
          ),





        ],
      ),
      
    );
  }

  // Future<dynamic> agentListApi() async {
  //      SharedPreferences prefs = await SharedPreferences.getInstance();
  //      var id = prefs.getString("id");
  //      print(id.toString());
  //   setState(() {
  //      isloading = true;
  //   });
  //   // print(email);
  //   // print(password);
  //   String msg = "";
  //   var jsonRes;
  //   http.Response? res;
  //   var jsonArray;
  //   var request = http.get(
  //       Uri.parse(

  //         RestDatasource.TOTALAGENTLIST_URL + "admin_id=" + id.toString()
          
  //       ),
  //      );

  //   await request.then((http.Response response) {
  //     res = response;
  //     final JsonDecoder _decoder = new JsonDecoder();
  //     jsonRes = _decoder.convert(response.body.toString());
  //     print("Response: " + response.body.toString() + "_");
  //     print("ResponseJSON: " + jsonRes.toString() + "_");
  //     print("status: " + jsonRes["status"].toString() + "_");
  //     print("message: " + jsonRes["message"].toString() + "_");
  //     msg = jsonRes["message"].toString();
  //     jsonArray = jsonRes['data'];
  //   });
  //   if (res!.statusCode == 200) {

  //     if (jsonRes["status"] == true) {
  //         apiList.clear();
    


  //     for (var i = 0; i < jsonArray.length; i++) {
  //       TotalAgentListApi modelSearch = new TotalAgentListApi();
  //       modelSearch.name = jsonArray[i]["name"];
  //       modelSearch.id = jsonArray[i]["id"].toString();
  //       modelSearch.email = jsonArray[i]["email"].toString();
  //       modelSearch.phone = jsonArray[i]["phone"].toString();
  //       modelSearch.image = jsonArray[i]["image"].toString();
  //       modelSearch.country_code = jsonArray[i]["country_code"].toString();

  //       print("id: "+modelSearch.id.toString());

  //       apiList.add(modelSearch);
        
  //     }

     

  //       setState(() {
  //         isloading = false;
  //       });
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Error while fetching data')));

  //     setState(() {
  //       isloading = false;
  //     });
  //   }
  // }



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
        RestDatasource.SEARCHAGENT_URL + "admin_id=" + id.toString() + "&key=" + key.toString()
        
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

class TotalAgentListApi {
  var id = "";
  var name = "";
  var email = "";
  var phone = "";
  var image = "";
  var country_code = "";
  
}