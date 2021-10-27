import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:roccabox_admin/screens/mortgagesDetails.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;



class MortgageList extends StatefulWidget {
  const MortgageList({ Key? key }) : super(key: key);

  @override
  _MortgageListState createState() => _MortgageListState();
}

class _MortgageListState extends State<MortgageList> {



  bool isloading = false;


  @override
  void initState() {
    super.initState();

    //userListApi();
    
  }
  

  List <String> mortgageList = [];




  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
        title:  Text("Mortgage Loan List",
        
          style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
        )
      ),

      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MortgagesDetails()));
        },
        child: Column(
          children: [
            SizedBox(height: 1.5.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
               
                children: [
                  Text("Date: 20/10/2021",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
      
                  ),
                  ),
      
                  Text("Name: Naman Sharma",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                    
      
                  ),
                  ),
      
                  Text("Email: naman@gmail.com",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold
      
                  ),
                  ),
      
                  Text("Phone No.: +919876543210",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold
      
                  ),
                  ),
                  Text("Address: 23, block 1, Mansarovar, Jaipur",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
      
                  ),
                  ),
                ],
              ),
            ),
      
            SizedBox(height: 2.h,),
      
            Container(
              height: .1.h,
              width: double.infinity,
              color: Colors.grey.shade400,
            )
          ],
        ),
      );
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
          mortgageList.clear();
    


      for (var i = 0; i < jsonArray.length; i++) {
        MortgageProperties modelSearch = new MortgageProperties();
        // modelSearch.name = jsonArray[i]["name"];
        // modelSearch.id = jsonArray[i]["id"].toString();
        // modelSearch.email = jsonArray[i]["email"].toString();
        // modelSearch.phone = jsonArray[i]["phone"].toString();
        // modelSearch.image = jsonArray[i]["image"].toString();
        // modelSearch.country_code = jsonArray[i]["country_code"].toString();

        // print("id: "+modelSearch.id.toString());

        // mortgageList.add(modelSearch);
        
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




}


class MortgageProperties {

}