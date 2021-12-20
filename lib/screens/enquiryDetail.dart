import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roccabox_admin/screens/enquiry.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

class EnquiryDetails extends StatefulWidget {
  AllEnquiry allEnquiryList;

  EnquiryDetails({required this.allEnquiryList});

  @override
  _NotificationDetailsState createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<EnquiryDetails> {
  String text = "";

  bool isloading = false;
  late ModelSearchProperty modelSearch = ModelSearchProperty();

  @override
  void initState() {
    super.initState();
    isloading = true;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print("filterId: " + widget.allEnquiryList.filter_id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        elevation: 1,
        leading: BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          "Enquiry Details",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp),
        ),
      ),
      body: isloading
          ? Align(
              alignment: Alignment.center,
              child: Platform.isAndroid
                  ? CircularProgressIndicator()
                  : CupertinoActivityIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                      isThreeLine: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.h),
                      leading: widget.allEnquiryList.u_image.toString()!="null"?CircleAvatar(
                        radius: 10.w,
                        backgroundImage: NetworkImage(
                          widget.allEnquiryList.u_image.toString(),
                        ),
                      ):CircleAvatar(
                        radius: 10.w,
                        backgroundImage: AssetImage(
                          'assets/Avatar.png',
                        ),
                      ),
                      title: Text(
                        widget.allEnquiryList.name.toString(),
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12.5.sp,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //"user@gmail.com"
                          Text(
                            widget.allEnquiryList.email.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          //"+91 9876543321"
                          Text(
                            widget.allEnquiryList.country_code.toString() +
                                widget.allEnquiryList.phone.toString(),
                            overflow: TextOverflow.ellipsis,
                          )
                          // Text(widget.totalUserList.email.toString()),
                          // Text(widget.totalUserList.phone.toString()),
                        ],
                      )),
                  Container(
                    height: 22.h,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child:
                        // modelSearch.pictureList!=null?modelSearch.pictureList.length==0?Image.asset(
                        //   "assets/blank.png",
                        //   filterQuality: FilterQuality.high,
                        //   fit: BoxFit.fill,
                        // ): Image.network(
                        //   modelSearch.pictureList[0].PictureURL.toString(),
                        //   filterQuality: FilterQuality.high,
                        //   fit: BoxFit.fill,
                        // ):
                        Image.network(
                      // "assets/property.jpeg",
                      widget.allEnquiryList.image.toString(),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      //'Urban Picific Real Estate',
                      modelSearch.Type +
                          " in " +
                          modelSearch.location +
                          " , " +
                          modelSearch.Area,
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child:
                        //isloading
                        //   ? Align(
                        //       alignment: Alignment.center,
                        //       child: Container(
                        //           margin: EdgeInsets.only(top: 20),
                        //           child: Platform.isAndroid
                        //               ? CircularProgressIndicator()
                        //               : CupertinoActivityIndicator())) : Text(
                        // widget.P_Agency_FilterId=="1"
                        //       ? modelSearch.price == null
                        //           ? ""
                        //           : '\€' + modelSearch.price
                        //       : widget.P_Agency_FilterId=="5"
                        //           ? modelSearch.price == null
                        //               ? ""
                        //               : 'From \€' + modelSearch.price
                        //           : modelSearch.RentalPrice1 != null
                        //               ? 'From \€' +
                        //                   modelSearch.RentalPrice1 +
                        //                   " per " +
                        //                   modelSearch.RentalPeriod
                        //               : "",

                        Text(
                      r"€" + modelSearch.price.toString(),
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SvgPicture.asset('assets/bed.svg'),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 1.0, left: 5, right: 20),
                            child: Text(
                              modelSearch.bedrooms != null
                                  ? modelSearch.bedrooms
                                  : "0",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff090909)),
                            ),
                          ),
                          SvgPicture.asset('assets/bath.svg'),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, left: 5, right: 20),
                            child: Text(
                              modelSearch.bathrooms != null
                                  ? modelSearch.bathrooms
                                  : "0",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff090909)),
                            ),
                          ),
                          SvgPicture.asset('assets/pool.svg'),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, left: 5, right: 5),
                            child: Text(
                              modelSearch.pool != null ? modelSearch.pool : "0",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff090909)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: SvgPicture.asset(
                              'assets/home_icon.svg',
                              height: 20,
                              width: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, left: 5, right: 5),
                            child: Text(
                              modelSearch.built != null
                                  ? modelSearch.built +
                                      " " +
                                      modelSearch.dimensions
                                  : "0",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff090909)),
                            ),
                          )
                        ],
                      )),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  //   child: Text(
                  //     //'Rajveer Place',
                  //    modelSearch.Area.toString(),
                  //     style: TextStyle(
                  //         fontSize: 16.sp,
                  //         color: Color(0xff000000),
                  //         fontWeight: FontWeight.w500),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 8, 10, 10),
                    child: Text(
                      // "New York",

                      modelSearch.country.toString(),

                      // modelSearch.Type +
                      //   " in " +
                      //   modelSearch.location +
                      //   " , " +
                      //   modelSearch.Area,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w300),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Text(
                      'Enquiry Message',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      // """Lorem ipsum is simply dummy text of the

                      widget.allEnquiryList.message.toString() != "null"
                          ? widget.allEnquiryList.message.toString()
                          : "",

                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Color(0xff706C6C),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Text(
                      'Property Description',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
//                 """Lorem ipsum is simply dummy text of the
// printing and typecasting industry.
// Lorem ipsum is simply dummy text of the
// printing and typecasting industry.
// Lorem ipsum is simply dummy text of the
// printing and typecasting industry.
// Lorem ipsum is simply dummy text of the
// printing and typecasting industry.""",
                      modelSearch.description == null
                          ? ""
                          : modelSearch.description,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Color(0xff706C6C),
                          height: 1.5,
                          wordSpacing: 2),
                    ),
                  ),

                  // SizedBox(height: 2.h,),

                  //  GestureDetector(
                  //             onTap: () {

                  //               // customDialog();

                  //             },
                  //             child: Container(
                  //               height: 7.h,
                  //               // width: 122,
                  //               // height: 30,
                  //              margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  //               padding:
                  //                   EdgeInsets.symmetric(horizontal: 2.w, ),
                  //               decoration: BoxDecoration(
                  //                 color: Color(0xffFFBA00),
                  //                 borderRadius: BorderRadius.circular(3.w),
                  //               ),
                  //               child: Center(
                  //                 child: Text(
                  //                   'Assign Agent',
                  //                   style: TextStyle(
                  //                       fontFamily: 'Poppins',
                  //                       fontSize: 14.sp,
                  //                       fontWeight: FontWeight.w500,
                  //                       color: Colors.white),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),

                  SizedBox(
                    height: 2.h,
                  )
                ],
              ),
            ),
    );
  }

  Future<dynamic> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("id").toString();
    print("Idd " + id.toString() + "");
    String uri = "https://webapi.resales-online.com/V6/PropertyDetails?" +
        "P_Agency_FilterId=" +
        widget.allEnquiryList.filter_id +
        "&" +
        "p1=" +
        "1021981" +
        "&p2=" +
        "8f065e421ed5b1cb8001f881e6fc675578cb9220" +
        "&P_RefId=" +
        widget.allEnquiryList.property_Rid;

    print("print: " + uri.toString());

    var request =
        http.post(Uri.parse(RestDatasource.NEWURL1), body: {"url": uri});

    var jsonRes;
    var res;
    await request.then((http.Response response) {
      res = response;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Ress " + jsonRes.toString() + "");
    });
    // print("ResponseJSON: " + respone.toString() + "_");
    // print("status: " + jsonRes["success"].toString() + "_");
    // print("message: " + jsonRes["message"].toString() + "_");

    if (res.statusCode == 200) {
      print("Response: " + jsonRes.toString() + "_");
      print(jsonRes["transaction"]["status"]);
      if (jsonRes["transaction"]["status"].toString() == "success") {
        modelSearch = new ModelSearchProperty();

        if (jsonRes["Property"] != null) {
          print("PropertyId" + jsonRes["Property"]["Reference"] + "^^");
          modelSearch.referanceId = jsonRes["Property"]["Reference"];
          modelSearch.Area = jsonRes["Property"]["Area"];
          modelSearch.country = jsonRes["Property"]["Country"];
          modelSearch.description = jsonRes["Property"]["Description"];
          modelSearch.location = jsonRes["Property"]["Location"];
          modelSearch.province = jsonRes["Property"]["Province"];
          modelSearch.originalPrice =
              jsonRes["Property"]["OriginalPrice"].toString();
          modelSearch.price = jsonRes["Property"]["Price"].toString();
          modelSearch.RentalPrice1 =
              jsonRes["Property"]["RentalPrice1"].toString();
          modelSearch.RentalPrice2 =
              jsonRes["Property"]["RentalPrice2"].toString();
          modelSearch.RentalPeriod =
              jsonRes["Property"]["RentalPeriod"].toString();
          modelSearch.Type =
              jsonRes["Property"]["PropertyType"]["Type"].toString();
          modelSearch.bathrooms = jsonRes["Property"]["Bathrooms"].toString();
          modelSearch.built = jsonRes["Property"]["Built"].toString();
          modelSearch.dimensions = jsonRes["Property"]["Dimensions"].toString();
          modelSearch.bedrooms = jsonRes["Property"]["Bedrooms"].toString();
          modelSearch.pool = jsonRes["Property"]["Pool"].toString();
          modelSearch.mainImage = jsonRes["Property"]["MainImage"].toString();
          try {
            var picArray = [];
            var pictureObj;
            pictureObj = jsonRes["Property"]["Pictures"] != null
                ? jsonRes["Property"]["Pictures"]
                : null;
            picArray = pictureObj != null ? pictureObj["Picture"] : null;

            if (picArray != null) {
              for (var j = 0; j < picArray.length; j++) {
                Pictures pictures = new Pictures();
                pictures.PictureURL = picArray[j]["PictureURL"] != null
                    ? picArray[j]["PictureURL"]
                    : null;
                modelSearch.pictureList.add(pictures);
              }
            }
          } catch (e) {
            print(e.toString());
          }

          var propFeatures = [];
          var propFeaturesObj;
          propFeaturesObj = jsonRes["Property"]["PropertyFeatures"] != null
              ? jsonRes["Property"]["PropertyFeatures"]
              : null;
          propFeatures =
              propFeaturesObj != null ? propFeaturesObj["Category"] : null;

          if (propFeatures != null) {
            for (var j = 0; j < propFeatures.length; j++) {
              Features pictures = new Features();
              pictures.Type = propFeatures[j]["Type"] != null
                  ? propFeatures[j]["Type"]
                  : null;
              pictures.Value = propFeatures[j]["Value"] != null
                  ? propFeatures[j]["Value"]
                  : null;
              modelSearch.features.add(pictures);
            }
          }
          setState(() {
            isloading = false;
          });
        } else {
          setState(() {
            isloading = false;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(jsonRes["message"].toString())));
          });
        }
      }
    } else {
      setState(() {
        isloading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Please try leter")));
      });
    }
  }
}

class ModelSearchProperty {
  String referanceId = "";
  String priceStart = "";
  String priceTill = "";
  String propertyType = "";
  String location = "";
  String Area = "";
  String province = "";
  String Type = "";
  String nameType = "";
  String bedrooms = "";
  String pool = "";
  String mainImage = "";
  String bathrooms = "";
  String built = "";
  String dimensions = "";

  String currency = "";
  String price = "";
  String originalPrice = "";
  String RentalPrice1 = "";
  String RentalPrice2 = "";
  String RentalPeriod = "";
  String description = "";
  String country = "";
  String Subtype1 = "";
  String SubtypeId1 = "";
  List<Pictures> pictureList = [];
  List<Features> features = [];
}

class Pictures {
  String PictureURL = "";
}

class Features {
  String Type = "";
  var Value = [];
}
