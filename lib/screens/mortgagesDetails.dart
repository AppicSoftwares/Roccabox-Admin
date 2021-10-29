import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:roccabox_admin/screens/mortgageList.dart';
import 'package:roccabox_admin/theme/constant.dart';

import 'package:sizer/sizer.dart';

class MortgagesDetails extends StatefulWidget {
  MortgageProperties properties;

  MortgagesDetails({required this.properties});

  @override
  _MortgagesDetailsState createState() => _MortgagesDetailsState();
}

class _MortgagesDetailsState extends State<MortgagesDetails> {

  bool isloading = false;
  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    print("Cloan:" + widget.properties.c_loan.length.toString());
    return Scaffold(
      body: SafeArea(
          child:

           isloading 
                  ? Align(
                    alignment: Alignment.center,
                     child: CircularProgressIndicator(),
                    
                  )
                  :
          
          
          
          
           ListView(
        shrinkWrap: true,
        controller: _controller,
        children: [
          Column(
            children: [
              Container(
                  color: Colors.white,
                  height: 23.h,
                  width: double.infinity,
                  child: Stack(children: [
                    Column(
                      children: <Widget>[
                        Container(
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        top: 8.h,
                        left: 5.w,
                        child: Container(
                          height: 15.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.w)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 2.h, left: 5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // "John Doe",
                                  widget.properties.client1_name.toString(),

                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  // "john@gmail.com",

                                  widget.properties.client1_email.toString(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11.sp),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  // "+9876543210",

                                  widget.properties.client1_phone.toString(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ),
                        )),
                    Positioned(
                      right: 8.w,
                      top: 18.h,
                      child: Text(
                        //"1-12-2001",
                        widget.properties.client1_dob.toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp),
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
                                    color: kPrimaryColor,
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Mortgages Details",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                  ])),
              Container(
                height: 30.h,
                width: 90.w,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "DO YOU HAVE CHILDREN",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"Yes",
                          widget.properties.client1_childrenAges.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "RESIDENT OR NON-RESIDENT",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          // "Resident",

                          widget.properties.client1_residentStatus.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PASSPORT NUMBER",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"ADC523453",
                          widget.properties.client1_passportNumber.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "IS THERE A SECOND APPLICANT?",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          "Yes",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.1.h,
                width: double.infinity,
                color: Colors.grey,
              ),
              Container(
                height: 43.h,
                width: 90.w,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MORTGAGE PURPOSE",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"Mortgage",
                          widget.properties.mortgage_purpose.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PURCHASE PRICE",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          // r"$25000",

                          r"$" + widget.properties.purchase_price.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "VALUE OF PROPERTY",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //r"$25000",
                          r"$" + widget.properties.property_value.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "DEPOSITE REQUIRED",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //r"$20000",
                          r"$" + widget.properties.deposite_require.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "AMOUNT REQUESTED",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //r"$22000",
                          r"$" + widget.properties.amount_requested.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TEARMS OF YEAR",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          widget.properties.terms_of_year.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.1.h,
                width: double.infinity,
                color: Colors.grey,
              ),
              Container(
                height: 35.h,
                width: 90.w,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PRIMARY RESIDENCE\n"
                          "ADDRESS",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"Aldgate, London",
                          widget.properties.mortgage_address.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "IS THIS RESIDENCE RENTED\n"
                          "OR OWNED",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"Rented",

                          widget.properties.property_type.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LIVING THERE SINCE",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"22-08-2019",
                          widget.properties.living_since.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MONTHLY COST",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //r"$1000",
                          r"$" + widget.properties.monthly_cost.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.1.h,
                width: double.infinity,
                color: Colors.grey,
              ),

              SizedBox(height: 3.h),

              Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: Text(
                    "Details of other loans/ liabilities\n"
                    "mortgages",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp),
                  ),
                ),
              ),

              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _controller,
                  itemCount: widget.properties.c_loan.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      width: 90.w,
                      height: 24.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [

                           Container(
                            height: 0.1.h,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "LOAN TYPE",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp),
                              ),
                              Text(
                                //r"$5000",

                                widget.properties.c_loan[index].loan_type
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.sp),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "LENDER",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp),
                              ),
                              Text(
                                // r"$250",
                                r"$" +
                                    widget.properties.c_loan[index].lender
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.sp),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "AMOUNT",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp),
                              ),
                              Text(
                                //r"$5000",
                                r"$" +
                                    widget.properties.c_loan[index].amount
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.sp),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "MONTHLY PAYMNET",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp),
                              ),
                              Text(
                                //r"$200",

                                r"$" +
                                    widget.properties.c_loan[index]
                                        .monthly_payment
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.sp),
                              )
                            ],
                          ),
                         
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Container(
              //   height: 40.h,
              //   width: 90.w,
              //   decoration: BoxDecoration(color: Colors.white),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.only(right: 15.w),
              //         child: Text(
              //           "Details of other loans/ liabilities\n"
              //           "mortgages",
              //           style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 14.sp),
              //         ),
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             "LOAN TYPE",
              //             style: TextStyle(
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 12.sp),
              //           ),
              //           Text(
              //             //r"$5000",

              //             widget.properties.c_loan[index].loan_type.toString(),
              //             style: TextStyle(
              //                 color: Colors.grey,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 10.sp),
              //           )
              //         ],
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             "LENDER",
              //             style: TextStyle(
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 12.sp),
              //           ),
              //           Text(
              //            // r"$250",
              //            r"$"+widget.properties.c_loan[index].lender.toString(),
              //             style: TextStyle(
              //                 color: Colors.grey,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 10.sp),
              //           )
              //         ],
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             "AMOUNT",
              //             style: TextStyle(
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 12.sp),
              //           ),
              //           Text(
              //             //r"$5000",
              //             r"$"+widget.properties.c_loan[index].amount.toString(),
              //             style: TextStyle(
              //                 color: Colors.grey,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 10.sp),
              //           )
              //         ],
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             "MONTHLY PAYMNET",
              //             style: TextStyle(
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 12.sp),
              //           ),
              //           Text(
              //             //r"$200",

              //             r"$"+widget.properties.c_loan[index].monthly_payment.toString(),
              //             style: TextStyle(
              //                 color: Colors.grey,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 10.sp),
              //           )
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                height: 0.1.h,
                width: double.infinity,
                color: Colors.grey,
              ),
              Container(
                height: 70.h,
                width: 90.w,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 42.w),
                      child: Text(
                        "Employment Details",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "EMPLOYED",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"Yes",
                          widget.properties.client1_employed.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "SELF-EMPLOYED",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          // "No",

                          widget.properties.client1_self_employed.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "EMPLOYER NAME",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          // "ABC",

                          widget.properties.client1_emp_name.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "EMPLOYER ADDRESS",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"London",
                          widget.properties.client1_emp_address.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "CONTACT NAME",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"Acbn",
                          widget.properties.client1_contact_name.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "POSITION HELD",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"Held",
                          widget.properties.client1_position.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "NET INCOME",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          r"$" + widget.properties.client1_income.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LENGTH OF SERVICE",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          "Employee",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TYPE OF CONTRACT",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          "Contract",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.1.h,
                width: double.infinity,
                color: Colors.grey,
              ),
              Container(
                height: 55.h,
                width: 90.w,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MORTGAGE ADDRESS",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"alicant, Spain",
                          widget.properties.mortgage_address.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TYPE OF PROPERTY",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"Apartment",
                          widget.properties.property_type.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "BEDROOMS",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"4",
                          widget.properties.bedroom.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "BATHROOMS",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"4",
                          widget.properties.bathroom.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "GARAGE",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          // "2+",

                          widget.properties.garage.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "STORE",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          // "2+",
                          widget.properties.store.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "M2 PLOT",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"50",
                          widget.properties.m_plot.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "M2 CONSTRUCTED",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"50",

                          widget.properties.m_constructed.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.1.h,
                width: double.infinity,
                color: Colors.grey,
              ),
              Container(
                height: 35.h,
                width: 90.w,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 54.w),
                      child: Text(
                        "Client's Lawyer",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "NAME",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          // "Jammy",
                          widget.properties.client_lawyer_name.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PHONE",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"98765433210",
                          widget.properties.client_lawyer_phone.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "FAX",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"5566776",
                          widget.properties.client_lawyer_fax.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "EMAIL",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"jammy@gmail.com",
                          widget.properties.client_lawyer_email.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.1.h,
                width: double.infinity,
                color: Colors.grey,
              ),
              Container(
                height: 35.h,
                width: 90.w,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 50.w),
                      child: Text(
                        "Vendor's Lawyer",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "NAME",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          // "Sammy",
                          widget.properties.vendor_lawyer_name.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PHONE",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"98765433210",
                          widget.properties.vendor_lawyer_phone.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "FAX",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          // "5566776",
                          widget.properties.vendor_lawyer_fax.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "EMAIL",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"sammy@gmail.com",

                          widget.properties.vendor_lawyer_email.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.1.h,
                width: double.infinity,
                color: Colors.grey,
              ),
              Container(
                height: 35.h,
                width: 90.w,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 52.w),
                      child: Text(
                        "Agent Promoter",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "NAME",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"Rammy",

                          widget.properties.agent_promoter_name.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PHONE",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          // "98765433210",

                          widget.properties.agent_promoter_phone.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "FAX",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          // "5566776",
                          widget.properties.agent_promoter_fax.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "EMAIL",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Text(
                          //"rammy@gmail.com",

                          widget.properties.agent_promoter_email.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                height: 0.1.h,
                width: double.infinity,
                color: Colors.grey,
              ),

              SizedBox(
                height: 2.h,
              ),
              Container(
                
                width: 90.w,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notes",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      widget.properties.notes.toString(),
                      //"In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                      style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                    ),

                    SizedBox(height: 5.h,)
                  ],
                ),
              ),

             
            ],
          )
        ],
      )),
    );
  }
}
