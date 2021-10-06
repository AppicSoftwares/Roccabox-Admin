import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:roccabox_admin/screens/addAgent.dart';
import 'package:roccabox_admin/screens/addUser.dart';
import 'package:roccabox_admin/screens/chatDemo.dart';
import 'package:roccabox_admin/screens/editAgent.dart';

import 'package:roccabox_admin/theme/constant.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';

class TotalAgentList extends StatefulWidget {
  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<TotalAgentList> {
 
  String selected = "first";

  ScrollController _controller = new ScrollController();
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(
              "Agent List",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddAgent()));
            },
            child: Container(
              margin: EdgeInsets.only(top: .5.h, right: 1.h, bottom: .5.h),
              height: 5.h,
              width: 20.w,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(2.w)),
              child: Center(
                child: Text("Add Agent",
                    style: TextStyle(fontSize: 9.sp, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
      body: SizerUtil.deviceType == DeviceType.mobile
          ? ListView(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selected = "first";
                            });
                          },
                          child: Container(
                            height: 6.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                                color: selected == 'first'
                                    ? kPrimaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                    color: selected == 'first'
                                        ? kPrimaryColor
                                        : Color(0xffD5D5D5))),
                            child: Center(
                              child: Text(
                                "New Request",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: selected == 'first'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selected = "second";
                            });
                          },
                          child: Container(
                            height: 6.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                                color: selected == 'second'
                                    ? kPrimaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                    color: selected == 'second'
                                        ? kPrimaryColor
                                        : Color(0xffD5D5D5))),
                            child: Center(
                              child: Text(
                                "Agent List",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: selected == 'second'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Total Agents: 2244",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    selected == "first" ? NewRequest() : AgentList()
                  ],
                ),
              ],
            )
          : Container(
              // Widget for Tablet
              width: 100.w,
              height: 12.5.h,
            ),
    );
  }

  customSwitch() {
    return Container(
      child: FlutterSwitch(
        width: 125.0,
        height: 50.0,
        valueFontSize: 25.0,
        activeColor: Colors.green,
        inactiveColor: Colors.grey,
        toggleSize: 35.0,
        value: status,
        borderRadius: 20.0,
        showOnOff: true,
        onToggle: (val) {
          setState(() {
            status = val;
          });
        },
      ),
    );
  }
}

class NewRequest extends StatefulWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  _NewRequestState createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _controller,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Column(
            children: [
              

              
              ListTile(
                leading: CircleAvatar(
                    maxRadius: 9.w, child: Image.asset("assets/Avatar.png")),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Testing User",
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "test@gmail.com",
                      style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                    ),
                    Text(
                      "9876543210",
                      style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      
                      height: 2.5.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          color: kGreenColor,
                          borderRadius: BorderRadius.circular(2.w)),
                      child: Center(
                        child: Text("Approve",
                            style: TextStyle(
                                fontSize: 8.sp, color: Colors.white)),
                      ),
                    ),

                    SizedBox(
                      height:0.5.h
                    ),

                    Container(
                      
                      height: 2.5.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          color: kRedColor,
                          borderRadius: BorderRadius.circular(2.w)),
                      child: Center(
                        child: Text("Reject",
                            style: TextStyle(
                                fontSize: 8.sp, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                width: double.infinity,
                height: 0.1.h,
                color: Colors.grey,
              ),
              SizedBox(
                height: 1.5.h,
              ),
            ],
          ),
        );
      },
    );
  }

  
}

class AgentList extends StatefulWidget {
  const AgentList({Key? key}) : super(key: key);

  @override
  _AgentListState createState() => _AgentListState();
}

class _AgentListState extends State<AgentList> {
  bool status = false;
  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _controller,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 12.h,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                    maxRadius: 9.w, child: Image.asset("assets/Avatar.png")),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Testing User",
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "test@gmail.com",
                      style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                    ),
                    Text(
                      "9876543210",
                      style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                    ),
                  ],
                ),
                trailing: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (Context) => ChatDemo()));
                          },
                          child: Image.asset(
                            "assets/comment.png",
                            width: 6.w,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            "assets/callicon.png",
                            width: 6.w,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:  (context) => EditAgent()));
                          },
                          child: Image.asset(
                            "assets/edit.png",
                            width: 6.w,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            "assets/delete.png",
                            width: 6.w,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h,),
                    customSwitch()
                  ],
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                width: double.infinity,
                height: 0.1.h,
                color: Colors.grey,
              ),
              SizedBox(
                height: 1.5.h,
              ),
            ],
          ),
        );
      },
    );
  }

   customSwitch() {
    return Container(
      height: 3.1.h,
      width: 28.w,
      
          child: FlutterSwitch(
             width: 125
             ,
            // height: 50.0,
            valueFontSize: 10.0,
            activeColor: kGreenColor,
            inactiveColor: Colors.grey.shade300,
            toggleSize: 20.0,
            value: status,
            borderRadius: 2.0,
            activeText: "Active",
            inactiveText: "Deactive",
            inactiveTextColor: Colors.black,

            
            
            
            showOnOff: true,
            onToggle: (val) {
              setState(() {
                status = val;
              });
            },
          ),
        );
  }
}



// Container(
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Container(
//                      height: 0.1.h,
//                      width: 40.w,
//                      color: Colors.grey[400],
//                    ),
//                    SizedBox(width: 1.w,),

//                    Text("Today",
//                    style: TextStyle(
//                      color: Colors.grey,
//                      fontSize: 8.sp,

//                    ),
//                    ),

//                     SizedBox(width: 1.w,),

//                    Container(
//                      height: 0.1.h,
//                      width: 40.w,
//                      color: Colors.grey[400],
//                    ),
//                  ],
//                ),
//               ),