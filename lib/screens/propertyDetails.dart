import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:roccabox_admin/screens/property.dart';
import 'package:roccabox_admin/theme/constant.dart';
import 'package:sizer/sizer.dart';

class PropertyDetails extends StatefulWidget {
  
  AllPropertyProperties allPropertyProperties;

  PropertyDetails({required this.allPropertyProperties});

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {



String feature1 = "";
String feature2 = "Alarm";
String feature3 = "Automatic irrigating system";
String feature4 = "Barbeque";
String feature5 = "Bar";
String feature6 = "Basement";
String feature7 = "Central heating";
String feature8 = "Covered terrace";
String feature9 = "Electric radiators";
String feature10 = "Fireplane";
String feature11 = "Garden";
String feature12 = "Guest apartment";
String feature13 = "Gym";
String feature14 = "Handicap accessible";
String feature15 = "Heated pool";
String feature16 = "Indoor pool";
String feature17 = "Jacuzzi";
String feature18 = "Lift";
String feature19 = "Marble floors";
String feature20 = "Private terrace";
String feature21 = "Spa";
String feature22 = "Saltwater swimming pool";
String feature23 = "Sauna";
String feature24 = "Separate apratment";
String feature25 = "Solar panels";
String feature26 = "Solarium";
String feature27 = "Tennis / paddle court";
String feature28 = "Uncovered terrace";
String feature29 = "Wooden floors";
String feature30 = "Underfloor heating";




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
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
                                     image: widget.allPropertyProperties.p_images != "null" ? widget.allPropertyProperties.p_images.length>0? DecorationImage(
                                            image:
                                                NetworkImage(widget.allPropertyProperties.p_images.first.images.toString()),
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
                        bottom: 12.5.h,
                        child: FittedBox(
                            child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          height: 10.h,
                          width: 10.h,
                          child: CircleAvatar(
                             child: Text(
                                              widget.allPropertyProperties.name.substring(0,1).toString(),
                                              style: TextStyle(
                                                fontSize: 25.sp
                                              ),
                                            )
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
                                //"John Doe",
                                widget.allPropertyProperties.name.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                              Text(
                                //"john@gmail.com",
                                widget.allPropertyProperties.email.toString(),
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
                          r"Price: €"+widget.allPropertyProperties.price1.toString(),
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
                                    height: 4.4.h,
                                    width: 4.4.h,
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
                        child: Container(
                          width: 95.w,
                          margin: EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /*Text(
                                //"Urbn Pacific Real Estate...",
                                widget.allPropertyProperties.category.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp),
                              ),*/
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 8.0),
                                width: MediaQuery.of(context).size.width*70,
                                child: Text(
                                  "New York, jkkjnnvnks, dsjnjknfdsjm,sm v skd v kjn,f,ds jfkndkfns, d vksdn",
                                  //widget.allPropertyProperties.address.toString(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11.sp),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                //"+91 9876543210",

                                widget.allPropertyProperties.phone.toString(),


                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 1.h,
                        right: 7.w,
                        child: Text(
                          widget.allPropertyProperties.category,
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp),
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
                          widget.allPropertyProperties.bedroom.toString() == "null" ? "0" : widget.allPropertyProperties.bedroom.toString(),
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
                          widget.allPropertyProperties.bathroom.toString() == "null" ? "0" : widget.allPropertyProperties.bathroom.toString(),
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
                          widget.allPropertyProperties.plot.toString() == "null" ? "0FT" : widget.allPropertyProperties.plot.toString()+"FT",
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 62.w),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text(
                     widget.allPropertyProperties.description.toString(),
                      
                      textAlign: TextAlign.start,
                      
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
              Container(
                margin : EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                 
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
                    Visibility(
                      visible: widget.allPropertyProperties.fearture1.toString() !="null" ? true : false,
                      child: Text(
                        "Air conditioning",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),

                     Visibility(
                      visible: widget.allPropertyProperties.fearture2.toString()  !="null" ? true : false,
                      child: Text(
                        "Alarm",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),

                     Visibility(
                      visible: widget.allPropertyProperties.fearture3.toString() !="null" ? true : false,
                      child: Text(
                        "Automatic irrigation system",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                     visible:  widget.allPropertyProperties.fearture4.toString() !="null" ? true : false,
                      child: Text(
                        "Barbeque",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture5.toString() !="null" ? true : false,
                      child: Text(
                        "Bar",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture6.toString() !="null" ? true : false,
                      child: Text(
                        "Basement",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture7.toString() !="null" ? true : false,
                      child: Text(
                        "Central heating",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture8.toString() !="null" ? true : false,
                      child: Text(
                        "Covered terrace",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture9.toString() !="null" ? true : false,
                      child: Text(
                        "Electric radiators",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture10.toString() !="null" ? true : false,
                      child: Text(
                        "Fireplace",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),



                     Visibility(
                      visible: widget.allPropertyProperties.fearture11.toString() !="null" ? true : false,
                      child: Text(
                        "Garden",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture12.toString() !="null" ? true : false,
                      child: Text(
                        "Guest apartment",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture13.toString() !="null" ? true : false,
                      child: Text(
                        "Gym",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),

                     Visibility(
                      visible: widget.allPropertyProperties.fearture14.toString() !="null" ? true : false,
                      child: Text(
                        "Handicap accessible",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture15.toString() !="null" ? true : false,
                      child: Text(
                        "Heated pool",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture16.toString() !="null" ? true : false,
                      child: Text(
                        "Indoor pool",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture17.toString() !="null" ? true : false,
                      child: Text(
                        "Jacuzzi",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture18.toString() !="null" ? true : false,
                      child: Text(
                        "Lift",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture19.toString() !="null" ? true : false,
                      child: Text(
                        "Marble floors",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture20.toString() !="null" ? true : false,
                      child: Text(
                        "Private terrace",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),



                     Visibility(
                      visible: widget.allPropertyProperties.fearture21.toString() !="null" ? true : false,
                      child: Text(
                        "Spa",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),

                     Visibility(
                      visible: widget.allPropertyProperties.fearture22.toString() !="null" ? true : false,
                      child: Text(
                        "Saltwater swimming pool",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture23.toString() !="null" ? true : false,
                      child: Text(
                        "Sauna",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture24.toString() !="null" ? true : false,
                      child: Text(
                        "Separate apartment",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture25.toString() !="null" ? true : false,
                      child: Text(
                        "Solar panels",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture26.toString() !="null" ? true : false,
                      child: Text(
                        "Solarium",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture27.toString() !="null" ? true : false,
                      child: Text(
                        "Tennis / paddle court",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture28.toString() !="null" ? true : false,
                      child: Text(
                        "Uncovered terrace",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture29.toString() !="null" ? true : false,
                      child: Text(
                        "Underfloor heating",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                    ),


                     Visibility(
                      visible: widget.allPropertyProperties.fearture30.toString() !="null" ? true : false,
                      child: Text(
                        "Wooden floors",
                        
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff706C6C),
                            height: 1.5,
                            wordSpacing: 2),
                      ),
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
