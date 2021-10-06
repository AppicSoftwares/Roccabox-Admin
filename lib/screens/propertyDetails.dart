import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:roccabox_admin/theme/constant.dart';
import 'package:sizer/sizer.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({Key? key}) : super(key: key);

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Column(
            children: [
              Container(
                  height: 50.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Column(
                        children: <Widget>[
                          Container(
                            height: 30.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/property.jpeg"),
                                    fit: BoxFit.fill)),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 5.w,
                        bottom: 12.5.h,
                        child: FittedBox(
                            child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          height: 10.h,
                          width: 10.h,
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/image.jpeg"),
                          ),
                        )),
                      ),
                      Positioned(
                          left: 29.w,
                          bottom: 13.5.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "John Doe",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                              Text(
                                "john@gmail.com",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11.sp),
                              ),
                            ],
                          )),
                      Positioned(
                        right: 4.w,
                        bottom: 21.h,
                        child: Text(
                          r"Price: $9800",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ),
                      ),
                      Positioned(
                          top: 2.h,
                          left: 4.5.w,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    height: 3.4.h,
                                    width: 3.4.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                        Icons.arrow_back_ios_new_outlined)),
                              ),
                              SizedBox(
                                width: 23.w,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Property Details",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          )),
                      Positioned(
                        bottom: 0.h,
                        left: 5.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Urbn Pacific Real Estate...",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              "New York",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11.sp),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              "+91 9876543210",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11.sp),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -1.h,
                        right: 7.w,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "For Sale",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 26.w,
                    height: 11.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.w),
                        border: Border.all(color: Colors.grey.shade400)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "4",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rooms",
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 26.w,
                    height: 11.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.w),
                        border: Border.all(color: Colors.grey.shade400)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "4",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Bathroom",
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 26.w,
                    height: 11.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.w),
                        border: Border.all(color: Colors.grey.shade400)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "1200FT",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Size",
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text(
                      """Lorem ipsum is simply dummy text of the  
printing and typecasting industry.
Lorem ipsum is simply dummy text of the  
printing and typecasting industry.
Lorem ipsum is simply dummy text of the  
printing and typecasting industry.
Lorem ipsum is simply dummy text of the  
printing and typecasting industry.""",
                      // modelSearch.description == null
                      //   ? ""
                      //   : modelSearch.description,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Color(0xff706C6C),
                          height: 1.5,
                          wordSpacing: 2),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Features',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text(
                      """Lorem ipsum is simply dummy text of the  
printing and typecasting industry.
Lorem ipsum is simply dummy text of the  
printing and typecasting industry.
Lorem ipsum is simply dummy text of the  
printing and typecasting industry.
Lorem ipsum is simply dummy text of the  
printing and typecasting industry.""",
                      // modelSearch.description == null
                      //   ? ""
                      //   : modelSearch.description,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Color(0xff706C6C),
                          height: 1.5,
                          wordSpacing: 2),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h
              ,)
            ],
          ),
        ],
      )),
    );
  }
}
