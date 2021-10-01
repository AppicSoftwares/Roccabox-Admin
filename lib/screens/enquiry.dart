import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:roccabox_admin/screens/enquiryDetail.dart';
import 'package:roccabox_admin/theme/constant.dart';
import 'package:sizer/sizer.dart';

class Enquiry extends StatefulWidget {
  const Enquiry({Key? key}) : super(key: key);

  @override
  _EnquiryState createState() => _EnquiryState();
}

class _EnquiryState extends State<Enquiry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Center(
            child: Text(
              "Enquiry",
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
                height: 3.h,
              ),
              
              InkWell(
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => EnquiryDetails()));
                },
                child: Card(
                  
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(6.w),
                  ),
                  child: Container(
                      height: 30.h,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Column(
                            children: <Widget>[
                              Container(
                                height: 15.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6.w),
                                        topRight: Radius.circular(6.w)),
                                    image: DecorationImage(
                                        image: AssetImage("assets/property.jpeg"),
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
                              width: 10.h ,
                              child: CircleAvatar(
                                backgroundImage: AssetImage("assets/image.jpeg"),
                              ),
                            )),
                          ),
              
                           Positioned(
                            left: 30.w,
                            bottom: 15.5.h,
                            child: Text("Urbn Pacific Real Estate...",
                            style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 9.sp
                            ),
                            )
                          ),
              
                           Positioned(
                            left: 29.w,
                            bottom: 8.5.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Client Name",
                                style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp
                                ),
                                ),
                                Text("user@gmail.com",
                                style: TextStyle(
                                color: Colors.black,
                                
                                fontSize: 11.sp
                                ),
                                ),
                              ],
                            )
                          ),
              
                           Positioned(
                            right: 2.w,
                            bottom: 8.5.h,
                            child: Text("+91 9876543210",
                            style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp
                            ),
                            )
                          ),
              
                           Positioned(
                            left: 6.w,
                            bottom: 1.h,
                            child: Text("""Lorem ipsum is simply dummy text of the  
printing and typecasting industry.""",
                            style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp
                            ),
                            )
                          ),
              
                          
              
                          Positioned(
                            top: 1.h,
                            left: 3.5.w,
                            
                            child: Row(
                            
                              children: [
                                InkWell(
                                  onTap: () {},
                                
                                  
                                  child: Container(
                                  height: 4.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.w),
                                    color: Colors.black.withOpacity(0.4),
                                    border: Border.all(
                                      color: kPrimaryColor
                                    )
                                  ),
                                  child: Center(
                                    child: Text("Ref. 776622",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white
                                    ),
                                    
                                    ),
                                  ),
                                                        ),
                                ),
                                SizedBox(width: 10.w,),
              
                                InkWell(
                                  onTap: () {
                                    customDialog();
                                  },
                                
                                  
                                  child: Container(
                                  height: 4.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.w),
                                    color: kPrimaryColor
                                  ),
                                  child: Center(
                                    child: Text("Assign this Lead",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white
                                    ),
                                    
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




              
            ],
          ),
        ));
  }

  customDialog() {
    showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.w)),
                      title: SingleChildScrollView(
                        child: Container(
                          //width: MediaQuery.of(context).size.width*.60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                
                                
                                children: [
                                  Text(
                                    'Assign Lead',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold),
                                  ),

                                  SizedBox(width: 20.w,),
                                  IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 7.w,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ],
                              ),

                              Container(
                                color: Colors.grey,
                                height: 0.1.h,
                                width: double.infinity,
                              ),

                              SizedBox(height:1.h),
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff000000)),
                                      ),
                              Container(height: 5.h,
                                child: TextField(
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              size: 8.w,
                            ),
                                      hintText:
                                        "Agent's Name",
                                        hintStyle: TextStyle(
                                          fontSize: 9.sp
                                        ),
                                      border: OutlineInputBorder(
                                        
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                              
                                ),
                              ),

                              SizedBox(height: 1.h,),
                              Text(
                                'Email Address',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff000000)

                                ),
                              ),
                              Container(
                                height: 5.h,
                                child: TextField(
                                  enabled: false,
                                  
                                  decoration: InputDecoration(
                                     hintText:
                                        'agent@gmail.com',
                                        hintStyle: TextStyle(
                                          fontSize: 9.sp
                                        ),

                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),

                              SizedBox(height: 1.h,),
                              Text(
                                'Mobile Number',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff000000)),
                              ),
                              Container(
                                height: 5.h,
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      hintText:
                                        '+91 9876543210',
                                        hintStyle: TextStyle(
                                          fontSize: 9.sp
                                        ),

                                      border: OutlineInputBorder(
                                        
                                          borderRadius:
                                              BorderRadius.circular(3.w))),
                                ),
                              ),
                    

                             SizedBox(height: 2.h,),
                              
                              GestureDetector(
                                onTap: () {
                                  

                                },
                                child: Container(
                                  height: 5.h,
                                  
                                  
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFBA00),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Assign Agent',
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
}
