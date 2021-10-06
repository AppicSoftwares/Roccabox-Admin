import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roccabox_admin/screens/propertyDetails.dart';
import 'package:roccabox_admin/theme/constant.dart';
import 'package:sizer/sizer.dart';



class Property extends StatefulWidget {
  const Property({ Key? key }) : super(key: key);

  @override
  _PropertyState createState() => _PropertyState();
}

class _PropertyState extends State<Property> {
  ScrollController _controller = new ScrollController();

  bool remember = false;
   
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

                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 7.h,
                      child: TextFormField(
                        validator: (val) {},
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
                    "Total User: 2244",
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),

                  ListView.builder(
                    controller: _controller,
                    shrinkWrap: true,
              
                    itemCount: 3,
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
                                        "John Doe",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                      Text(
                                        "john@gmail.com",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 11.sp),
                                      ),
                                    ],
                                  )),

                              Positioned(
                                right: 4.w,
                              bottom: 15.h,
                                child: Text(
                                        r"$9800",
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp),
                                      ),),
                              Positioned(
                                  right: 2.w,
                                  bottom: 8.5.h,
                                  child: Text(
                                    "+91 9876543210",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp),
                                  )),
                              Positioned(
                                  left: 6.w,
                                  bottom: 1.h,
                                  child: Text(
                                    "New York",
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
                                              "12-09-2021",
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
                                              "Attendent",
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