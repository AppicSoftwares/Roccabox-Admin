import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

                  

                selected == "first"
                    ? AllProperty()
                    : selected == "second"
                        ? AttendentProperty()
                        : UnAttendedProperty()


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
                    value: selected == "first" ? true : false,
                    onChanged: (val) {
                       setState(() {
                        selected = "first";
                      }
                      );
                      Navigator.pop(context);
                    }),
                title: Text(
                  "All",
                  style: TextStyle(color: Colors.black),
                ),
                // onTap: () {
                //   Navigator.pop(context);
                // },
              ),

                ListTile(

                  //Attended
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
                    value: selected == "second" ? true : false,
                    onChanged: (val) {
                      setState(() {
                        selected = "second";
                      }
                      );
                      Navigator.pop(context);
                    }),
                title: Text(
                  "Attendent",
                  style: TextStyle(color: Colors.black),
                ),
                // onTap: () {
                //   Navigator.pop(context);
                // },
              ),

                ListTile(

                  //UnAttended
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
                    value: selected == "third" ? true : false,
                    onChanged: (val) {
                       setState(() {
                        selected = "third";
                      });
                      Navigator.pop(context);
                    }),
                title: Text(
                  "Un Attendent",
                  style: TextStyle(color: Colors.black),
                ),
                // onTap: () {
                //   Navigator.pop(context);
                // },
              ),
            ],
          );
        });
  }
}



class UnAttendedProperty extends StatefulWidget {
  const UnAttendedProperty({ Key? key }) : super(key: key);

  @override
  _UnAttendedPropertyState createState() => _UnAttendedPropertyState();
}

class _UnAttendedPropertyState extends State<UnAttendedProperty> {



      bool isloading = false;
List<AllPropertyProperties> unAttendedPropertyList = [];

@override
void initState() {
  super.initState();
  UnAttendedPropertyApi();
}








  ScrollController _controller = new ScrollController();





  @override
  Widget build(BuildContext context) {
    return 

     isloading 
                  ? Align(
                    alignment: Alignment.center,
                     child: CircularProgressIndicator(),
                    
                  )
                  :
    
    Container(

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
                    "UnAttended Property: " + unAttendedPropertyList.length.toString(),
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),

             ListView.builder(
                    controller: _controller,
                    shrinkWrap: true,
              
                    itemCount: unAttendedPropertyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return 
                  Column(
                    children: [
                      InkWell(
                onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PropertyDetails(
                                allPropertyProperties: unAttendedPropertyList[index],
                              )));
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
                                        image: unAttendedPropertyList[index].p_images != "null" ? unAttendedPropertyList[index].p_images.length>0? DecorationImage(
                                            image:
                                                NetworkImage(unAttendedPropertyList[index].p_images.first.images.toString()),
                                            fit: BoxFit.fill)
                                            :
                                          DecorationImage(
                                            image:
                                                AssetImage("assets/property.jpeg"),
                                            fit: BoxFit.fill)

                                        
                                            :DecorationImage(
                                            image:
                                                AssetImage("assets/property.jpeg"),
                                            fit: BoxFit.fill)

                                            ),
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
                                    // backgroundImage:
                                    //     AssetImage("assets/image.jpeg"),
                                        child: Text(
                                              unAttendedPropertyList[index].name.substring(0,1).toString(),
                                              style: TextStyle(
                                                fontSize: 25.sp
                                              ),
                                            )
                                  ),
                                )),
                              ),
                              // Positioned(
                              //     left: 6.w,
                              //     bottom: 3.h,
                              //     child: Text(
                                    
                              //       "Urbn Pacific Real Estattte...",
                              //       overflow: TextOverflow.ellipsis,
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 14.sp),
                              //     )),
                              Positioned(
                                  left: 29.w,
                                  bottom: 6.h,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        //"John Doe",

                                        unAttendedPropertyList[index].name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                      Text(
                                       // "john@gmail.com",
                                       unAttendedPropertyList[index].email.toString(),
                                       overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 11.sp),
                                      ),

                                      Text(
                                   // "+91 9876543210",

                                   unAttendedPropertyList[index].phone.toString(),
                                   overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp),
                                  )
                                    ],
                                  )),

                              Positioned(
                                right: 4.w,
                              bottom: 15.h,
                                child: Text(
                                       // r"$9800",

                                      r"$"+ unAttendedPropertyList[index].price1.toString(),
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp),
                                      ),),
                              // Positioned(
                              //     right: 2.w,
                              //     bottom: 8.5.h,
                              //     child: Text(
                              //      // "+91 9876543210",

                              //      allPropertyList[index].phone.toString(),
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 11.sp),
                              //     )),
                              Positioned(
                                  left: 6.w,
                                  bottom: 1.h,
                                  child: Text(
                                    //"New York",
                                    unAttendedPropertyList[index].address.toString(),
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

                                              unAttendedPropertyList[index].created_at.substring(0,9).toString(),


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
                                          customDialog(index);
                                        },
                                        child: Container(
                                          height: 4.h,
                                          width: 34.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.w),
                                              color:unAttendedPropertyList[index].status ==
                                                                "Unattended"
                                                            ? kPrimaryColor
                                                            : kGreenColor,),
                                          child: Center(
                                            child: Text(
                                             // "Attendent",

                                             unAttendedPropertyList[index].status.toString(),
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
                          "to attend this property",
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
                      statusData(index);
                     
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
                          'Attend this Property',
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



   Future<dynamic> statusData( int index) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
    setState(() {
       isloading = true;
    });



    var request = http.post(
      Uri.parse(
        RestDatasource.PROPERTYSTATUS_URL,
      ),
      body: {
        "admin_id":id.toString(),
        "property_id":unAttendedPropertyList[index].id.toString()
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
            UnAttendedPropertyApi();
        
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



        Future<dynamic> UnAttendedPropertyApi() async {
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
          id.toString() + "&status=UnAttended"),
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
         unAttendedPropertyList.clear();

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
              modelAgentSearch.fearture1 = jsonArray[i]["fearture1"].toString();
          modelAgentSearch.fearture2 = jsonArray[i]["fearture2"].toString();
          modelAgentSearch.fearture3 = jsonArray[i]["fearture3"].toString();
          modelAgentSearch.fearture4 = jsonArray[i]["fearture4"].toString();
          modelAgentSearch.fearture5 = jsonArray[i]["fearture5"].toString();
          modelAgentSearch.fearture6 = jsonArray[i]["fearture6"].toString();
          modelAgentSearch.fearture7 = jsonArray[i]["fearture7"].toString();
          modelAgentSearch.fearture8 = jsonArray[i]["fearture8"].toString();
          modelAgentSearch.fearture9 = jsonArray[i]["fearture9"].toString();
          modelAgentSearch.fearture10 = jsonArray[i]["fearture10"].toString();
          modelAgentSearch.fearture11 = jsonArray[i]["fearture11"].toString();
          modelAgentSearch.fearture12 = jsonArray[i]["fearture12"].toString();
          modelAgentSearch.fearture13 = jsonArray[i]["fearture13"].toString();
          modelAgentSearch.fearture14 = jsonArray[i]["fearture14"].toString();
          modelAgentSearch.fearture15 = jsonArray[i]["fearture15"].toString();
          modelAgentSearch.fearture16 = jsonArray[i]["fearture16"].toString();
          modelAgentSearch.fearture17 = jsonArray[i]["fearture18"].toString();
          modelAgentSearch.fearture19 = jsonArray[i]["fearture19"].toString();
          modelAgentSearch.fearture20 = jsonArray[i]["fearture20"].toString();
          modelAgentSearch.fearture21 = jsonArray[i]["fearture21"].toString();
          modelAgentSearch.fearture22 = jsonArray[i]["fearture22"].toString();
          modelAgentSearch.fearture23 = jsonArray[i]["fearture23"].toString();
          modelAgentSearch.fearture24 = jsonArray[i]["fearture24"].toString();
          modelAgentSearch.fearture25 = jsonArray[i]["fearture25"].toString();
          modelAgentSearch.fearture26 = jsonArray[i]["fearture26"].toString();
          modelAgentSearch.fearture27 = jsonArray[i]["fearture27"].toString();
          modelAgentSearch.fearture28 = jsonArray[i]["fearture28"].toString();
          modelAgentSearch.fearture29 = jsonArray[i]["fearture29"].toString();
          modelAgentSearch.fearture30 = jsonArray[i]["fearture30"].toString();
          modelAgentSearch.fearture18 = jsonArray[i]["fearture18"].toString();
          modelAgentSearch.place_name = jsonArray[i]["place_name"].toString();
          modelAgentSearch.price1 = jsonArray[i]["price1"].toString();
          modelAgentSearch.price2 = jsonArray[i]["price2"].toString();
          modelAgentSearch.description = jsonArray[i]["description"].toString();
          modelAgentSearch.catastral_reference = jsonArray[i]["catastral_reference"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();
          modelAgentSearch.is_approved = jsonArray[i]["is_approved"].toString();
          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          modelAgentSearch.updated_at = jsonArray[i]["updated_at"].toString();
          //modelAgentSearch.p_images = jsonArray[i]["p_images"].toString();
          modelAgentSearch.p_documents = jsonArray[i]["p_documents"].toString();

          try {
          var picArray = jsonArray[i]["p_images"];
          print("picArray: "+picArray.toString()+"^");
          List<PImages> rim = [];
          for (var item in picArray) {
            print("items"+item['images'].toString());
            PImages images = PImages();
            images.images = item['images'].toString();
            rim.add(images);
          }
          modelAgentSearch.p_images = rim;
        
        } catch (e) {
          print(e.toString());
        }
         

          unAttendedPropertyList.add(modelAgentSearch);
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




     Future<dynamic> searchData(String key ) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
       print("key Print: " +key.toString());




    var request = http.get(
      Uri.parse(
        RestDatasource.SEARCHPROPERTY_URL + "admin_id=" + id.toString() + "&status=UnAttended"+ "&key=" + key.toString()
        
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
          unAttendedPropertyList.clear();
    


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
          modelAgentSearch.fearture1 = jsonArray[i]["fearture1"].toString();
          modelAgentSearch.fearture2 = jsonArray[i]["fearture2"].toString();
          modelAgentSearch.fearture3 = jsonArray[i]["fearture3"].toString();
          modelAgentSearch.fearture4 = jsonArray[i]["fearture4"].toString();
          modelAgentSearch.fearture5 = jsonArray[i]["fearture5"].toString();
          modelAgentSearch.fearture6 = jsonArray[i]["fearture6"].toString();
          modelAgentSearch.fearture7 = jsonArray[i]["fearture7"].toString();
          modelAgentSearch.fearture8 = jsonArray[i]["fearture8"].toString();
          modelAgentSearch.fearture9 = jsonArray[i]["fearture9"].toString();
          modelAgentSearch.fearture10 = jsonArray[i]["fearture10"].toString();
          modelAgentSearch.fearture11 = jsonArray[i]["fearture11"].toString();
          modelAgentSearch.fearture12 = jsonArray[i]["fearture12"].toString();
          modelAgentSearch.fearture13 = jsonArray[i]["fearture13"].toString();
          modelAgentSearch.fearture14 = jsonArray[i]["fearture14"].toString();
          modelAgentSearch.fearture15 = jsonArray[i]["fearture15"].toString();
          modelAgentSearch.fearture16 = jsonArray[i]["fearture16"].toString();
          modelAgentSearch.fearture17 = jsonArray[i]["fearture18"].toString();
          modelAgentSearch.fearture19 = jsonArray[i]["fearture19"].toString();
          modelAgentSearch.fearture20 = jsonArray[i]["fearture20"].toString();
          modelAgentSearch.fearture21 = jsonArray[i]["fearture21"].toString();
          modelAgentSearch.fearture22 = jsonArray[i]["fearture22"].toString();
          modelAgentSearch.fearture23 = jsonArray[i]["fearture23"].toString();
          modelAgentSearch.fearture24 = jsonArray[i]["fearture24"].toString();
          modelAgentSearch.fearture25 = jsonArray[i]["fearture25"].toString();
          modelAgentSearch.fearture26 = jsonArray[i]["fearture26"].toString();
          modelAgentSearch.fearture27 = jsonArray[i]["fearture27"].toString();
          modelAgentSearch.fearture28 = jsonArray[i]["fearture28"].toString();
          modelAgentSearch.fearture29 = jsonArray[i]["fearture29"].toString();
          modelAgentSearch.fearture30 = jsonArray[i]["fearture30"].toString();
          modelAgentSearch.fearture18 = jsonArray[i]["fearture18"].toString();

          modelAgentSearch.place_name = jsonArray[i]["place_name"].toString();
          modelAgentSearch.price1 = jsonArray[i]["price1"].toString();
          modelAgentSearch.price2 = jsonArray[i]["price2"].toString();
          modelAgentSearch.description = jsonArray[i]["description"].toString();
          modelAgentSearch.catastral_reference = jsonArray[i]["catastral_reference"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();
          modelAgentSearch.is_approved = jsonArray[i]["is_approved"].toString();
          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          modelAgentSearch.updated_at = jsonArray[i]["updated_at"].toString();
         // modelAgentSearch.p_images = jsonArray[i]["p_images"].toString();
          modelAgentSearch.p_documents = jsonArray[i]["p_documents"].toString();


          try {
          var picArray = jsonArray[i]["p_images"];
          print("picArray: "+picArray.toString()+"^");
          List<PImages> rim = [];
          for (var item in picArray) {
            print("items"+item['images'].toString());
            PImages images = PImages();
            images.images = item['images'].toString();
            rim.add(images);
          }
          modelAgentSearch.p_images = rim;
        
        } catch (e) {
          print(e.toString());
        }
         

          unAttendedPropertyList.add(modelAgentSearch);
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









class AttendentProperty extends StatefulWidget {
  const AttendentProperty({ Key? key }) : super(key: key);

  @override
  _AttendentPropertyState createState() => _AttendentPropertyState();
}

class _AttendentPropertyState extends State<AttendentProperty> {



    bool isloading = false;
List<AllPropertyProperties> attendedPropertyList = [];

@override
void initState() {
  super.initState();
  attendedPropertyApi();
}








  ScrollController _controller = new ScrollController();





  @override
  Widget build(BuildContext context) {
    return 
     isloading 
                  ? Align(
                    alignment: Alignment.center,
                     child: CircularProgressIndicator(),
                    
                  )
                  :
    
     Container(

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
                    "Attended Property: " + attendedPropertyList.length.toString(),
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),

             ListView.builder(
                    controller: _controller,
                    shrinkWrap: true,
              
                    itemCount: attendedPropertyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return 
                  Column(
                    children: [
                      InkWell(
                onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PropertyDetails(
                                allPropertyProperties: attendedPropertyList[index],
                              )));
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
                                        image: attendedPropertyList[index].p_images != "null" ? attendedPropertyList[index].p_images.length>0? DecorationImage(
                                            image:
                                                NetworkImage(attendedPropertyList[index].p_images.first.images.toString()),
                                            fit: BoxFit.fill)
                                            :
                                          DecorationImage(
                                            image:
                                                AssetImage("assets/property.jpeg"),
                                            fit: BoxFit.fill)

                                        
                                            :DecorationImage(
                                            image:
                                                AssetImage("assets/property.jpeg"),
                                            fit: BoxFit.fill)

                                            ),
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
                                    // backgroundImage:
                                    //     AssetImage("assets/image.jpeg"),
                                        child: Text(
                                              attendedPropertyList[index].name.substring(0,1).toString(),
                                              style: TextStyle(
                                                fontSize: 25.sp
                                              ),
                                            )
                                  ),
                                )),
                              ),
                              // Positioned(
                              //     left: 6.w,
                              //     bottom: 3.h,
                              //     child: Text(
                                    
                              //       "Urbn Pacific Real Estattte...",
                              //       overflow: TextOverflow.ellipsis,
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 14.sp),
                              //     )),
                              Positioned(
                                  left: 29.w,
                                  bottom: 6.h,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        //"John Doe",

                                        attendedPropertyList[index].name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                      Text(
                                       // "john@gmail.com",
                                       attendedPropertyList[index].email.toString(),
                                       overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 11.sp),
                                      ),

                                      Text(
                                   // "+91 9876543210",

                                   attendedPropertyList[index].phone.toString(),
                                   overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp),
                                  )
                                    ],
                                  )),

                              Positioned(
                                right: 4.w,
                              bottom: 15.h,
                                child: Text(
                                       // r"$9800",

                                      r"$"+ attendedPropertyList[index].price1.toString(),
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp),
                                      ),),
                              // Positioned(
                              //     right: 2.w,
                              //     bottom: 8.5.h,
                              //     child: Text(
                              //      // "+91 9876543210",

                              //      allPropertyList[index].phone.toString(),
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 11.sp),
                              //     )),
                              Positioned(
                                  left: 6.w,
                                  bottom: 1.h,
                                  child: Text(
                                    //"New York",
                                    attendedPropertyList[index].address.toString(),
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

                                              attendedPropertyList[index].created_at.substring(0,9).toString(),


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

                                             attendedPropertyList[index].status.toString(),
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

  





      Future<dynamic> attendedPropertyApi() async {
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
          id.toString() + "&status=Attended"),
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
         attendedPropertyList.clear();

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
          modelAgentSearch.fearture1 = jsonArray[i]["fearture1"].toString();
          modelAgentSearch.fearture2 = jsonArray[i]["fearture2"].toString();
          modelAgentSearch.fearture3 = jsonArray[i]["fearture3"].toString();
          modelAgentSearch.fearture4 = jsonArray[i]["fearture4"].toString();
          modelAgentSearch.fearture5 = jsonArray[i]["fearture5"].toString();
          modelAgentSearch.fearture6 = jsonArray[i]["fearture6"].toString();
          modelAgentSearch.fearture7 = jsonArray[i]["fearture7"].toString();
          modelAgentSearch.fearture8 = jsonArray[i]["fearture8"].toString();
          modelAgentSearch.fearture9 = jsonArray[i]["fearture9"].toString();
          modelAgentSearch.fearture10 = jsonArray[i]["fearture10"].toString();
          modelAgentSearch.fearture11 = jsonArray[i]["fearture11"].toString();
          modelAgentSearch.fearture12 = jsonArray[i]["fearture12"].toString();
          modelAgentSearch.fearture13 = jsonArray[i]["fearture13"].toString();
          modelAgentSearch.fearture14 = jsonArray[i]["fearture14"].toString();
          modelAgentSearch.fearture15 = jsonArray[i]["fearture15"].toString();
          modelAgentSearch.fearture16 = jsonArray[i]["fearture16"].toString();
          modelAgentSearch.fearture17 = jsonArray[i]["fearture18"].toString();
          modelAgentSearch.fearture19 = jsonArray[i]["fearture19"].toString();
          modelAgentSearch.fearture20 = jsonArray[i]["fearture20"].toString();
          modelAgentSearch.fearture21 = jsonArray[i]["fearture21"].toString();
          modelAgentSearch.fearture22 = jsonArray[i]["fearture22"].toString();
          modelAgentSearch.fearture23 = jsonArray[i]["fearture23"].toString();
          modelAgentSearch.fearture24 = jsonArray[i]["fearture24"].toString();
          modelAgentSearch.fearture25 = jsonArray[i]["fearture25"].toString();
          modelAgentSearch.fearture26 = jsonArray[i]["fearture26"].toString();
          modelAgentSearch.fearture27 = jsonArray[i]["fearture27"].toString();
          modelAgentSearch.fearture28 = jsonArray[i]["fearture28"].toString();
          modelAgentSearch.fearture29 = jsonArray[i]["fearture29"].toString();
          modelAgentSearch.fearture30 = jsonArray[i]["fearture30"].toString();
          modelAgentSearch.fearture18 = jsonArray[i]["fearture18"].toString();
          modelAgentSearch.place_name = jsonArray[i]["place_name"].toString();
          modelAgentSearch.price1 = jsonArray[i]["price1"].toString();
          modelAgentSearch.price2 = jsonArray[i]["price2"].toString();
          modelAgentSearch.description = jsonArray[i]["description"].toString();
          modelAgentSearch.catastral_reference = jsonArray[i]["catastral_reference"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();
          modelAgentSearch.is_approved = jsonArray[i]["is_approved"].toString();
          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          modelAgentSearch.updated_at = jsonArray[i]["updated_at"].toString();
         // modelAgentSearch.p_images = jsonArray[i]["p_images"].toString();
          modelAgentSearch.p_documents = jsonArray[i]["p_documents"].toString();
         


         try {
          var picArray = jsonArray[i]["p_images"];
          print("picArray: "+picArray.toString()+"^");
          List<PImages> rim = [];
          for (var item in picArray) {
            print("items"+item['images'].toString());
            PImages images = PImages();
            images.images = item['images'].toString();
            rim.add(images);
          }
          modelAgentSearch.p_images = rim;
        
        } catch (e) {
          print(e.toString());
        }

          attendedPropertyList.add(modelAgentSearch);
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




     Future<dynamic> searchData(String key ) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
       print("key Print: " +key.toString());




    var request = http.get(
      Uri.parse(
        RestDatasource.SEARCHPROPERTY_URL + "admin_id=" + id.toString() + "&status=Attended"+ "&key=" + key.toString()
        
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
          attendedPropertyList.clear();
    


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
          modelAgentSearch.fearture1 = jsonArray[i]["fearture1"].toString();
          modelAgentSearch.fearture2 = jsonArray[i]["fearture2"].toString();
          modelAgentSearch.fearture3 = jsonArray[i]["fearture3"].toString();
          modelAgentSearch.fearture4 = jsonArray[i]["fearture4"].toString();
          modelAgentSearch.fearture5 = jsonArray[i]["fearture5"].toString();
          modelAgentSearch.fearture6 = jsonArray[i]["fearture6"].toString();
          modelAgentSearch.fearture7 = jsonArray[i]["fearture7"].toString();
          modelAgentSearch.fearture8 = jsonArray[i]["fearture8"].toString();
          modelAgentSearch.fearture9 = jsonArray[i]["fearture9"].toString();
          modelAgentSearch.fearture10 = jsonArray[i]["fearture10"].toString();
          modelAgentSearch.fearture11 = jsonArray[i]["fearture11"].toString();
          modelAgentSearch.fearture12 = jsonArray[i]["fearture12"].toString();
          modelAgentSearch.fearture13 = jsonArray[i]["fearture13"].toString();
          modelAgentSearch.fearture14 = jsonArray[i]["fearture14"].toString();
          modelAgentSearch.fearture15 = jsonArray[i]["fearture15"].toString();
          modelAgentSearch.fearture16 = jsonArray[i]["fearture16"].toString();
          modelAgentSearch.fearture17 = jsonArray[i]["fearture18"].toString();
          modelAgentSearch.fearture19 = jsonArray[i]["fearture19"].toString();
          modelAgentSearch.fearture20 = jsonArray[i]["fearture20"].toString();
          modelAgentSearch.fearture21 = jsonArray[i]["fearture21"].toString();
          modelAgentSearch.fearture22 = jsonArray[i]["fearture22"].toString();
          modelAgentSearch.fearture23 = jsonArray[i]["fearture23"].toString();
          modelAgentSearch.fearture24 = jsonArray[i]["fearture24"].toString();
          modelAgentSearch.fearture25 = jsonArray[i]["fearture25"].toString();
          modelAgentSearch.fearture26 = jsonArray[i]["fearture26"].toString();
          modelAgentSearch.fearture27 = jsonArray[i]["fearture27"].toString();
          modelAgentSearch.fearture28 = jsonArray[i]["fearture28"].toString();
          modelAgentSearch.fearture29 = jsonArray[i]["fearture29"].toString();
          modelAgentSearch.fearture30 = jsonArray[i]["fearture30"].toString();
          modelAgentSearch.fearture18 = jsonArray[i]["fearture18"].toString();
          modelAgentSearch.place_name = jsonArray[i]["place_name"].toString();
          modelAgentSearch.price1 = jsonArray[i]["price1"].toString();
          modelAgentSearch.price2 = jsonArray[i]["price2"].toString();
          modelAgentSearch.description = jsonArray[i]["description"].toString();
          modelAgentSearch.catastral_reference = jsonArray[i]["catastral_reference"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();
          modelAgentSearch.is_approved = jsonArray[i]["is_approved"].toString();
          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          modelAgentSearch.updated_at = jsonArray[i]["updated_at"].toString();
          //modelAgentSearch.p_images = jsonArray[i]["p_images"].toString();
          modelAgentSearch.p_documents = jsonArray[i]["p_documents"].toString();


          try {
          var picArray = jsonArray[i]["p_images"];
          print("picArray: "+picArray.toString()+"^");
          List<PImages> rim = [];
          for (var item in picArray) {
            print("items"+item['images'].toString());
            PImages images = PImages();
            images.images = item['images'].toString();
            rim.add(images);
          }
          modelAgentSearch.p_images = rim;
        
        } catch (e) {
          print(e.toString());
        }
         

          attendedPropertyList.add(modelAgentSearch);
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
    return 
                  isloading 
                  ? Align(
                    alignment: Alignment.center,
                     child: CircularProgressIndicator(),
                    
                  )
                  :
    Container(

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
                    "All Property: " + allPropertyList.length.toString(),
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
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
                              builder: (context) => PropertyDetails(
                                allPropertyProperties: allPropertyList[index],
                              )));
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
                                        image: allPropertyList[index].p_images != "null" ? allPropertyList[index].p_images.length>0? DecorationImage(
                                            image:
                                                NetworkImage(allPropertyList[index].p_images.first.images.toString()),
                                            fit: BoxFit.fill)
                                            :
                                          DecorationImage(
                                            image:
                                                AssetImage("assets/property.jpeg"),
                                            fit: BoxFit.fill)

                                        
                                            :DecorationImage(
                                            image:
                                                AssetImage("assets/property.jpeg"),
                                            fit: BoxFit.fill)

                                            ),

                                           
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
                                    // backgroundImage:
                                    //     AssetImage("assets/image.jpeg"),
                                        child: Text(
                                              allPropertyList[index].name.substring(0,1).toString(),
                                              style: TextStyle(
                                                fontSize: 25.sp
                                              ),
                                            )
                                  ),
                                )),
                              ),
                              // Positioned(
                              //     left: 6.w,
                              //     bottom: 3.h,
                              //     child: Text(
                                    
                              //       "Urbn Pacific Real Estattte...",
                              //       overflow: TextOverflow.ellipsis,
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 14.sp),
                              //     )),
                              Positioned(
                                  left: 29.w,
                                  bottom: 6.h,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        //"John Doe",

                                        allPropertyList[index].name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                      Text(
                                       // "john@gmail.com",
                                       allPropertyList[index].email.toString(),
                                       overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 11.sp),
                                      ),

                                      Text(
                                   // "+91 9876543210",

                                   allPropertyList[index].phone.toString(),
                                   overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp),
                                  )
                                    ],
                                  )),

                              Positioned(
                                right: 4.w,
                              bottom: 15.h,
                                child: Text(
                                       // r"$9800",

                                      r"€"+ allPropertyList[index].price1.toString(),
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp),
                                      ),),
                              // Positioned(
                              //     right: 2.w,
                              //     bottom: 8.5.h,
                              //     child: Text(
                              //      // "+91 9876543210",

                              //      allPropertyList[index].phone.toString(),
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 11.sp),
                              //     )),
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

                                          if (allPropertyList[index].status ==
                                                    "Unattended") {
                                                  customDialog(index);
                                                }

                                         
                                          
                                        },
                                        child: Container(
                                          height: 4.h,
                                          width: 34.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.w),
                                              color:allPropertyList[index].status ==
                                                                "Unattended"
                                                            ? kPrimaryColor
                                                            : kGreenColor,),
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
                          "to attend this property",
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
                      statusData(index);
                     
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
                          'Attend this Property',
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



   Future<dynamic> statusData( int index) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
    setState(() {
       isloading = true;
    });



    var request = http.post(
      Uri.parse(
        RestDatasource.PROPERTYSTATUS_URL,
      ),
      body: {
        "admin_id":id.toString(),
        "property_id":allPropertyList[index].id.toString()
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
            allPropertyApi();
        
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
          id.toString() + "&status=all"),
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

 print("picfgf: "+jsonRes["status"].toString()+"^");
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
          modelAgentSearch.fearture1 = jsonArray[i]["fearture1"].toString();
          modelAgentSearch.fearture2 = jsonArray[i]["fearture2"].toString();
          modelAgentSearch.fearture3 = jsonArray[i]["fearture3"].toString();
          modelAgentSearch.fearture4 = jsonArray[i]["fearture4"].toString();
          modelAgentSearch.fearture5 = jsonArray[i]["fearture5"].toString();
          modelAgentSearch.fearture6 = jsonArray[i]["fearture6"].toString();
          modelAgentSearch.fearture7 = jsonArray[i]["fearture7"].toString();
          modelAgentSearch.fearture8 = jsonArray[i]["fearture8"].toString();
          modelAgentSearch.fearture9 = jsonArray[i]["fearture9"].toString();
          modelAgentSearch.fearture10 = jsonArray[i]["fearture10"].toString();
          modelAgentSearch.fearture11 = jsonArray[i]["fearture11"].toString();
          modelAgentSearch.fearture12 = jsonArray[i]["fearture12"].toString();
          modelAgentSearch.fearture13 = jsonArray[i]["fearture13"].toString();
          modelAgentSearch.fearture14 = jsonArray[i]["fearture14"].toString();
          modelAgentSearch.fearture15 = jsonArray[i]["fearture15"].toString();
          modelAgentSearch.fearture16 = jsonArray[i]["fearture16"].toString();
          modelAgentSearch.fearture17 = jsonArray[i]["fearture18"].toString();
          modelAgentSearch.fearture19 = jsonArray[i]["fearture19"].toString();
          modelAgentSearch.fearture20 = jsonArray[i]["fearture20"].toString();
          modelAgentSearch.fearture21 = jsonArray[i]["fearture21"].toString();
          modelAgentSearch.fearture22 = jsonArray[i]["fearture22"].toString();
          modelAgentSearch.fearture23 = jsonArray[i]["fearture23"].toString();
          modelAgentSearch.fearture24 = jsonArray[i]["fearture24"].toString();
          modelAgentSearch.fearture25 = jsonArray[i]["fearture25"].toString();
          modelAgentSearch.fearture26 = jsonArray[i]["fearture26"].toString();
          modelAgentSearch.fearture27 = jsonArray[i]["fearture27"].toString();
          modelAgentSearch.fearture28 = jsonArray[i]["fearture28"].toString();
          modelAgentSearch.fearture29 = jsonArray[i]["fearture29"].toString();
          modelAgentSearch.fearture30 = jsonArray[i]["fearture30"].toString();
          modelAgentSearch.fearture18 = jsonArray[i]["fearture18"].toString();
          modelAgentSearch.place_name = jsonArray[i]["place_name"].toString();
          modelAgentSearch.price1 = jsonArray[i]["price1"].toString();
          modelAgentSearch.price2 = jsonArray[i]["price2"].toString();
          modelAgentSearch.description = jsonArray[i]["description"].toString();
          modelAgentSearch.catastral_reference = jsonArray[i]["catastral_reference"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();
          modelAgentSearch.is_approved = jsonArray[i]["is_approved"].toString();
          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          modelAgentSearch.updated_at = jsonArray[i]["updated_at"].toString();
         // modelAgentSearch.p_images = jsonArray[i]["p_images"].toString();
          modelAgentSearch.p_documents = jsonArray[i]["p_documents"].toString();



          var jsonnArray;

          try {
          var picArray = jsonArray[i]["p_images"];
          print("picArray: "+picArray.toString()+"^");
          List<PImages> rim = [];
          for (var item in picArray) {
            print("items"+item['images'].toString());
            PImages images = PImages();
            images.images = item['images'].toString();
            rim.add(images);
          }
          modelAgentSearch.p_images = rim;
        
        } catch (e) {
          print(e.toString());
        }
         

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




     Future<dynamic> searchData(String key ) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
       print("key Print: " +key.toString());




    var request = http.get(
      Uri.parse(
        RestDatasource.SEARCHPROPERTY_URL + "admin_id=" + id.toString() + "&status=all"+ "&key=" + key.toString()
        
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
          modelAgentSearch.fearture1 = jsonArray[i]["fearture1"].toString();
          modelAgentSearch.fearture2 = jsonArray[i]["fearture2"].toString();
          modelAgentSearch.fearture3 = jsonArray[i]["fearture3"].toString();
          modelAgentSearch.fearture4 = jsonArray[i]["fearture4"].toString();
          modelAgentSearch.fearture5 = jsonArray[i]["fearture5"].toString();
          modelAgentSearch.fearture6 = jsonArray[i]["fearture6"].toString();
          modelAgentSearch.fearture7 = jsonArray[i]["fearture7"].toString();
          modelAgentSearch.fearture8 = jsonArray[i]["fearture8"].toString();
          modelAgentSearch.fearture9 = jsonArray[i]["fearture9"].toString();
          modelAgentSearch.fearture10 = jsonArray[i]["fearture10"].toString();
          modelAgentSearch.fearture11 = jsonArray[i]["fearture11"].toString();
          modelAgentSearch.fearture12 = jsonArray[i]["fearture12"].toString();
          modelAgentSearch.fearture13 = jsonArray[i]["fearture13"].toString();
          modelAgentSearch.fearture14 = jsonArray[i]["fearture14"].toString();
          modelAgentSearch.fearture15 = jsonArray[i]["fearture15"].toString();
          modelAgentSearch.fearture16 = jsonArray[i]["fearture16"].toString();
          modelAgentSearch.fearture17 = jsonArray[i]["fearture18"].toString();
          modelAgentSearch.fearture19 = jsonArray[i]["fearture19"].toString();
          modelAgentSearch.fearture20 = jsonArray[i]["fearture20"].toString();
          modelAgentSearch.fearture21 = jsonArray[i]["fearture21"].toString();
          modelAgentSearch.fearture22 = jsonArray[i]["fearture22"].toString();
          modelAgentSearch.fearture23 = jsonArray[i]["fearture23"].toString();
          modelAgentSearch.fearture24 = jsonArray[i]["fearture24"].toString();
          modelAgentSearch.fearture25 = jsonArray[i]["fearture25"].toString();
          modelAgentSearch.fearture26 = jsonArray[i]["fearture26"].toString();
          modelAgentSearch.fearture27 = jsonArray[i]["fearture27"].toString();
          modelAgentSearch.fearture28 = jsonArray[i]["fearture28"].toString();
          modelAgentSearch.fearture29 = jsonArray[i]["fearture29"].toString();
          modelAgentSearch.fearture30 = jsonArray[i]["fearture30"].toString();
          modelAgentSearch.fearture18 = jsonArray[i]["fearture18"].toString();
          modelAgentSearch.place_name = jsonArray[i]["place_name"].toString();
          modelAgentSearch.price1 = jsonArray[i]["price1"].toString();
          modelAgentSearch.price2 = jsonArray[i]["price2"].toString();
          modelAgentSearch.description = jsonArray[i]["description"].toString();
          modelAgentSearch.catastral_reference = jsonArray[i]["catastral_reference"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();
          modelAgentSearch.is_approved = jsonArray[i]["is_approved"].toString();
          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          modelAgentSearch.updated_at = jsonArray[i]["updated_at"].toString();
          
          modelAgentSearch.p_documents = jsonArray[i]["p_documents"].toString();
         

         var jsonnArray;

         try {
          var picArray = jsonArray[i]["p_images"];
          print("picArray: "+picArray.toString()+"^");
          List<PImages> rim = [];
          for (var item in picArray) {
            print("items"+item['images'].toString());
            PImages images = PImages();
            images.images = item['images'].toString();
            rim.add(images);
          }
          modelAgentSearch.p_images = rim;
        
        } catch (e) {
          print(e.toString());
        }


          allPropertyList.add(modelAgentSearch);
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















class AllPropertyProperties {

  List<PImages> p_images = [];

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
  var fearture1 = "";
  var fearture2 = "";
  var fearture3 = "";
  var fearture4 = "";
  var fearture5 = "";
  var fearture6 = "";
  var fearture7 = "";
  var fearture8 = "";
  var fearture9 = "";
  var fearture10 = "";
  var fearture11 = "";
  var fearture12 = "";
  var fearture13 = "";
  var fearture14 = "";
  var fearture15 = "";
  var fearture16 = "";
  var fearture17 = "";
  var fearture18 = "";
  var fearture19 = "";
  var fearture20 = "";
  var fearture21 = "";
  var fearture22 = "";
  var fearture23 = "";
  var fearture24 = "";
  var fearture25 = "";
  var fearture26 = "";
  var fearture27 = "";
  var fearture28 = "";
  var fearture29 = "";
  var fearture30 = "";
  
  var place_name = "";
  var price1 = "";
  var price2 = "";
  var description = "";
  var catastral_reference = "";
  var status = "";
  var is_approved = "";
  var created_at = "";
  var updated_at = "";
  
  var p_documents = "";


}



class PImages {
  var id = "";
  var property_id = "";
  var images = "";
  var created_at = "";
  var updated_at = "";
}



