import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:roccabox_admin/screens/mortgagesDetails.dart';
import 'package:sizer/sizer.dart';



class MortgageList extends StatefulWidget {
  const MortgageList({ Key? key }) : super(key: key);

  @override
  _MortgageListState createState() => _MortgageListState();
}

class _MortgageListState extends State<MortgageList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
        title:  Text("Mortgage Loan List",
        
          style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
        )
      ),

      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MortgagesDetails()));
        },
        child: Column(
          children: [
            SizedBox(height: 1.5.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
               
                children: [
                  Text("Date: 20/10/2021",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
      
                  ),
                  ),
      
                  Text("Name: Naman Sharma",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                    
      
                  ),
                  ),
      
                  Text("Email: naman@gmail.com",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold
      
                  ),
                  ),
      
                  Text("Phone No.: +919876543210",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold
      
                  ),
                  ),
                  Text("Address: 23, block 1, Mansarovar, Jaipur",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
      
                  ),
                  ),
                ],
              ),
            ),
      
            SizedBox(height: 2.h,),
      
            Container(
              height: .1.h,
              width: double.infinity,
              color: Colors.grey.shade400,
            )
          ],
        ),
      );
        },
      ),
      
    );
  }
}