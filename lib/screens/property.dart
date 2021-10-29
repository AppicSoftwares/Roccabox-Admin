import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roccabox_admin/screens/propertyDetails.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:roccabox_admin/theme/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;



class Property extends StatefulWidget {
  const Property({ Key? key }) : super(key: key);

  @override
  _PropertyState createState() => _PropertyState();
}

class _PropertyState extends State<Property> {
  ScrollController _controller = new ScrollController();

  bool remember = false;
 
  String selected = "first";

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
          elevation: 1,
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: Text(
                "Listed Property",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp),
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  CustomBottomSheet();
                },
                icon: SvgPicture.asset(
                  "assets/filter1.svg",
                  width: 3.h,
                ))
          ],
        ),

        body:  SafeArea(
          child: ListView(
            shrinkWrap: true,
            controller: _controller,
            children: [
              Column(
                children: [

                  

                AllProperty()


                ],
              )
            ],
          ))


        






      
    );
  }

   CustomBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //Alll
                leading: Checkbox(
                    activeColor: kPrimaryColor,
                   shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(1.w),
                          topRight: Radius.circular(1.w),
                          bottomLeft: Radius.circular(1.w),
                          bottomRight: Radius.circular(1.w)),
                    ),
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return kPrimaryColor;
                      }
                      return kPrimaryColor;
                    }),
                    value: remember,
                    onChanged: (val) {
                      setState(() {
                        remember = val!;
                      });
                    }),
                title: Text(
                  "All",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

                ListTile(

                  //Assigned
                leading: Checkbox(
                    activeColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(1.w),
                          topRight: Radius.circular(1.w),
                          bottomLeft: Radius.circular(1.w),
                          bottomRight: Radius.circular(1.w)),
                    ),
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return kPrimaryColor;
                      }
                      return kPrimaryColor;
                    }),
                    value: remember,
                    onChanged: (val) {
                      setState(() {
                        remember = val!;
                      });
                    }),
                title: Text(
                  "Attendent",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

                ListTile(

                  //Un Assigned
                leading: Checkbox(
                    activeColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(1.w),
                          topRight: Radius.circular(1.w),
                          bottomLeft: Radius.circular(1.w),
                          bottomRight: Radius.circular(1.w)),
                    ),
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return kPrimaryColor;
                      }
                      return kPrimaryColor;
                    }),
                    value: remember,
                    onChanged: (val) {
                      setState(() {
                        remember = val!;
                      });
                    }),
                title: Text(
                  "Un Attendent",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}



class AllProperty extends StatefulWidget {
  const AllProperty({ Key? key }) : super(key: key);

  @override
  _AllPropertyState createState() => _AllPropertyState();
}

class _AllPropertyState extends State<AllProperty> {
  bool isloading = false;
List<AllPropertyProperties> allPropertyList = [];

@override
void initState() {
  super.initState();
  allPropertyApi();
}








  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
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
                         // searchData(value.toString());
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

             ListView.builder(
                    controller: _controller,
                    shrinkWrap: true,
              
                    itemCount: allPropertyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return 
                  Column(
                    children: [
                      InkWell(
                onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PropertyDetails()));
                },
                child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(6.w),
                      ),
                      child: Container(
                          height: 34.h,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: 19.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6.w),
                                            topRight: Radius.circular(6.w)),
                                        image: DecorationImage(
                                            image:
                                                AssetImage("assets/property.jpeg"),
                                            fit: BoxFit.fill)),
                                  ),
                                ],
                              ),
                              Positioned(
                                left: 5.w,
                                bottom: 8.h,
                                child: FittedBox(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  height: 10.h,
                                  width: 10.h,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/image.jpeg"),
                                  ),
                                )),
                              ),
                              Positioned(
                                  left: 6.w,
                                  bottom: 3.h,
                                  child: Text(
                                    "Urbn Pacific Real Estattte...",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  )),
                              Positioned(
                                  left: 29.w,
                                  bottom: 8.5.h,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        //"John Doe",

                                        allPropertyList[index].name.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                      Text(
                                       // "john@gmail.com",
                                       allPropertyList[index].email.toString(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 11.sp),
                                      ),
                                    ],
                                  )),

                              Positioned(
                                right: 4.w,
                              bottom: 15.h,
                                child: Text(
                                       // r"$9800",

                                      r"$"+ allPropertyList[index].price1.toString(),
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp),
                                      ),),
                              Positioned(
                                  right: 2.w,
                                  bottom: 8.5.h,
                                  child: Text(
                                   // "+91 9876543210",

                                   allPropertyList[index].phone.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp),
                                  )),
                              Positioned(
                                  left: 6.w,
                                  bottom: 1.h,
                                  child: Text(
                                    //"New York",
                                    allPropertyList[index].address.toString(),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp),
                                  )),
                              Positioned(
                                  top: 1.h,
                                  left: 3.5.w,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 4.h,
                                          width: 34.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.w),
                                              color: kPrimaryColor,
                                              border:
                                                  Border.all(color: kPrimaryColor)),
                                          child: Center(
                                            child: Text(
                                              //"12-09-2021",

                                              allPropertyList[index].created_at.substring(0,9).toString(),


                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 23.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          
                                        },
                                        child: Container(
                                          height: 4.h,
                                          width: 34.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.w),
                                              color: kGreenColor,),
                                          child: Center(
                                            child: Text(
                                             // "Attendent",

                                             allPropertyList[index].status.toString(),
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          )),
                ),
              ),

              SizedBox(height: 3.h,)
                    ],
                  );
                    },
                  ),
      
        ],
      ),
      
    );
  }



    Future<dynamic> allPropertyApi() async {
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
      Uri.parse(RestDatasource.PROPERTYLIST_URL +
          "admin_id=" +
          id.toString()),
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
         allPropertyList.clear();

        for (var i = 0; i < jsonArray.length; i++) {
          AllPropertyProperties modelAgentSearch = new AllPropertyProperties();
          modelAgentSearch.id = jsonArray[i]["id"].toString();
          modelAgentSearch.user_id = jsonArray[i]["user_id"].toString();
          modelAgentSearch.name = jsonArray[i]["name"].toString();
          modelAgentSearch.email = jsonArray[i]["email"].toString();
          modelAgentSearch.phone = jsonArray[i]["phone"].toString();
          modelAgentSearch.category = jsonArray[i]["category"].toString();
          modelAgentSearch.place_type = jsonArray[i]["place_type"].toString();
          modelAgentSearch.bedroom = jsonArray[i]["bedroom"].toString();
          modelAgentSearch.bathroom = jsonArray[i]["bathroom"].toString();
          modelAgentSearch.address = jsonArray[i]["address"].toString();
          modelAgentSearch.build = jsonArray[i]["build"].toString();
          modelAgentSearch.plot = jsonArray[i]["plot"].toString();
          modelAgentSearch.terrace = jsonArray[i]["terrace"].toString();
          modelAgentSearch.views1 = jsonArray[i]["views1"].toString();
          modelAgentSearch.views2 = jsonArray[i]["views2"].toString();
          modelAgentSearch.views3 = jsonArray[i]["views3"].toString();
          modelAgentSearch.views4 = jsonArray[i]["views4"].toString();
          modelAgentSearch.views5 = jsonArray[i]["views5"].toString();
          modelAgentSearch.views6 = jsonArray[i]["views6"].toString();
          modelAgentSearch.views7 = jsonArray[i]["views7"].toString();
          modelAgentSearch.views8 = jsonArray[i]["views8"].toString();
          modelAgentSearch.views9 = jsonArray[i]["views9"].toString();
          modelAgentSearch.rooms1 = jsonArray[i]["rooms1"].toString();
          modelAgentSearch.rooms2 = jsonArray[i]["rooms2"].toString();
          modelAgentSearch.rooms3 = jsonArray[i]["rooms3"].toString();
          modelAgentSearch.rooms4 = jsonArray[i]["rooms4"].toString();
          modelAgentSearch.rooms5 = jsonArray[i]["rooms5"].toString();
          modelAgentSearch.rooms6 = jsonArray[i]["rooms6"].toString();
          modelAgentSearch.rooms7 = jsonArray[i]["rooms7"].toString();
          modelAgentSearch.rooms8 = jsonArray[i]["rooms8"].toString();
          modelAgentSearch.rooms9 = jsonArray[i]["rooms9"].toString();
          modelAgentSearch.place_name = jsonArray[i]["place_name"].toString();
          modelAgentSearch.price1 = jsonArray[i]["price1"].toString();
          modelAgentSearch.price2 = jsonArray[i]["price2"].toString();
          modelAgentSearch.description = jsonArray[i]["description"].toString();
          modelAgentSearch.catastral_reference = jsonArray[i]["catastral_reference"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();
          modelAgentSearch.is_approved = jsonArray[i]["is_approved"].toString();
          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          modelAgentSearch.updated_at = jsonArray[i]["updated_at"].toString();
          modelAgentSearch.p_images = jsonArray[i]["p_images"].toString();
          modelAgentSearch.p_documents = jsonArray[i]["p_documents"].toString();
         

          allPropertyList.add(modelAgentSearch);
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















class AllPropertyProperties {

  var id = "";
  var user_id = "";
  var name = "";
  var email = "";
  var phone = "";
  var category = "";
  var place_type = "";
  var bedroom = "";
  var bathroom = "";
  var address = "";
  var build = "";
  var plot = "";
  var terrace = "";
  var views1 = "";
  var views2 = "";
  var views3 = "";
  var views4 = "";
  var views5 = "";
  var views6 = "";
  var views7 = "";
  var views8 = "";
  var views9 = "";
  var rooms1 = "";
  var rooms2 = "";
  var rooms3 = "";
  var rooms4 = "";
  var rooms5 = "";
  var rooms6 = "";
  var rooms7 = "";
  var rooms8 = "";
  var rooms9 = "";
  var place_name = "";
  var price1 = "";
  var price2 = "";
  var description = "";
  var catastral_reference = "";
  var status = "";
  var is_approved = "";
  var created_at = "";
  var updated_at = "";
  var p_images = "";
  var p_documents = "";


}



