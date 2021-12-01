import 'dart:convert';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roccabox_admin/screens/agentSearchBar.dart';
import 'package:roccabox_admin/screens/notification.dart';
import 'package:roccabox_admin/screens/notifications.dart';

import 'package:roccabox_admin/screens/totalUserList.dart';
import 'package:http/http.dart' as http;
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:roccabox_admin/services/provider.dart';
import 'package:roccabox_admin/theme/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  bool isloading = false;
  var customers = "";
  var agents = "";

  @override
  void initState() {
   
    super.initState();
    dashBoardApi();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
             Padding(
                padding: EdgeInsets.only(left: 35.h, top: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications()));
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)
                        ),
                        child: SvgPicture.asset(
                          "assets/Bell.svg",
                          color: Colors.white,
                        ),
                      ),
                     Count()
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 26.h,
              child: Padding(
                padding:  EdgeInsets.only(top: 10.h, right: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    


                    InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => NewRequestScreen() ));
                      },
                      child: Text(
                        "Dashboard",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    Text(
                      "Welcome to Roccabox Admin Panel!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.5.sp,
                          ),
                    ),
                  ],
                ),
              ),
            ),

            SizerUtil.deviceType == DeviceType.mobile
  ?  Container(
              width: double.infinity,
              height: 56.3.h,
              
              decoration: BoxDecoration(
                color: Colors.white,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(10.w),
                 topRight: Radius.circular(10.w)
               ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TotalUserList(
                        customers: customers,
                      )));
                    },
                    child: Container(
                    
                    height: 20.h,
                    width:55.w,
                    decoration: BoxDecoration(
                        color: Color(0xffF0EBE7),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffD5D5D5))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/totalUser.svg',
                          width: 14.w,
                        ), //for sale
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text("Total User",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.sp,
                                  
                                  color: Colors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(customers.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                                  ),
                  ),

                 SizedBox(height: 2.h,),

                 TextButton(
                   onPressed: () {

                     Navigator.push(context, MaterialPageRoute(builder: (context) => AgentSearchbar()));
                   },
                   child: Container(
                    
                    height: 20.h,
                    width:55.w,
                    decoration: BoxDecoration(
                        color: Color(0xffF0EBE7),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffD5D5D5))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/userwithtie.svg',
                          width: 12.w,
                        ), //for sale
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text("Total Agent",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.sp,
                                  
                                  color: Colors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(agents.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                                 ),
                 ),
                ],
              ),
            )
  :  Container(
           
            )
           
          ],
        ),
      )),
    );
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

      customers = jsonRes["data"]["customers"].toString();

      agents = jsonRes["data"]["agents"].toString();

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




}




// class Count extends StatelessWidget {
//   const Count({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var count  = '${context.watch!<Counter>().count}';

//     return Visibility(
//       visible: count.toString()=="0"?false:true,
//       child: Positioned(
//         top: -3,
//         right: 0,
//         child: Container(
//           height: 16,
//           width: 16,
//           decoration: BoxDecoration(
//             color: Color(0xFFFF4848),
//             shape: BoxShape.circle,
//             border: Border.all(width: 1.5, color: Colors.white),
//           ),
//           child: Center(
//             child: Text(
//               count.toString(),
//               style: TextStyle(
//                 fontSize: 10,
//                 height: 1,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ); }
// }
class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var count  = '${context.watch<Counter>().count}';

    return Visibility(
      visible: count.toString()=="0"?false:true,
      child: Positioned(
        top: -3,
        right: 0,
        child: Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            color: Color(0xFFFF4848),
            shape: BoxShape.circle,
            border: Border.all(width: 1.5, color: Colors.white),
          ),
          child: Center(
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 10,
                height: 1,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ); }
}
