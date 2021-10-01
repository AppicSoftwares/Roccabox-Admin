import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class EditBannerImage extends StatefulWidget {
  const EditBannerImage({Key? key}) : super(key: key);

  @override
  _EditBannerImageState createState() => _EditBannerImageState();
}

class _EditBannerImageState extends State<EditBannerImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Edit Banner Image",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp),
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
            child: TextFormField(
              // controller: uptemail,
              decoration: InputDecoration(
                  hintText: "Property Type",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.w),
                  )),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Stack(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                  child: Container(
                    height: 20.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.w),
                      border: Border.all(
                        color: Colors.grey,
                        //Color(0xffD5D5D5)
                      ),
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/hut.jpeg",
                          ),
                          fit: BoxFit.fill),
                    ),
                  )),

                   Padding(
                     padding: EdgeInsets.only(top: 1.h, right: 2.h),
                     child: Align(
                       alignment: Alignment.topRight,
                       child: IconButton(
                        onPressed: () {},
                        icon: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SvgPicture.asset(
                              'assets/errorsvg.svg',
                              width: 10.w,
                              color: Colors.white,
                            ),
                        ), 
                     )
                     ),
                   )
            
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 5.h),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 7.h,
                // width: 122,
                // height: 30,

                decoration: BoxDecoration(
                  color: Color(0xffFFBA00),
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: Center(
                  child: Text(
                    'Edit Image',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
