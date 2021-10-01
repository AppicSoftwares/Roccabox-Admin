import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roccabox_admin/screens/totalAgentList.dart';
import 'package:roccabox_admin/screens/totalUserList.dart';

import 'package:roccabox_admin/theme/constant.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 26.h,
              child: Padding(
                padding:  EdgeInsets.only(top: 10.h, right: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dashboard",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold),
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
              height: 63.1.h,
              
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TotalUserList()));
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
                          child: Text("3914",
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

                     Navigator.push(context, MaterialPageRoute(builder: (context) => TotalAgentList()));
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
                          child: Text("2958",
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
              width: double.infinity,
              height: 64.8.h,
              
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
                    onPressed: () {},
                    child: Container(
                    
                    height: 25.h,
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
                          child: Text("3914",
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
                   onPressed: () {},
                   child: Container(
                    
                    height: 25.h,
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
                          child: Text("2958",
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
           
          ],
        ),
      )),
    );
  }
}
