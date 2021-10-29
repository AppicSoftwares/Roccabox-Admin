import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:roccabox_admin/screens/mortgagesDetails.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class MortgageList extends StatefulWidget {
  const MortgageList({Key? key}) : super(key: key);

  @override
  _MortgageListState createState() => _MortgageListState();
}

class _MortgageListState extends State<MortgageList> {
  bool isloading = false;

  @override
  void initState() {
    super.initState();

    mortgageListApi();
  }

  List<MortgageProperties> mortgageList = [];

  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Mortgage Loan List",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp),
        )),
        body: ListView(
          shrinkWrap: true,
          controller: _controller,
          children: [
            Column(
              children: [
                SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    "Total User: " + mortgageList.length.toString(),
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),



                  isloading 
                  ? Align(
                    alignment: Alignment.center,
                     child: CircularProgressIndicator(),
                    
                  )
                  :




                ListView.builder(
                  shrinkWrap: true,
                  controller: _controller,
                  itemCount: mortgageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MortgagesDetails(
                                      properties: mortgageList[index],
                                    )));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  //"Date: 20/10/2021",

                                  mortgageList[index]
                                      .created_at
                                      .substring(0, 9)
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  //"Name: Naman Sharma",
                                  mortgageList[index].client1_name.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  //"Email: naman@gmail.com",

                                  mortgageList[index].client1_email.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  //"Phone No.: +919876543210",
                                  mortgageList[index].client1_phone.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  //"Address: 23, block 1, Mansarovar, Jaipur",
                                  mortgageList[index]
                                      .primary_address
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
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
              ],
            )
          ],
        ));
  }

  Future<dynamic> mortgageListApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    print(id.toString());
    setState(() {
      isloading = true;
    });
    // print(email);
    // print(password);
    String msg = "";
    var jsonRes;
    http.Response? res;
    var jsonArray;
    var request = http.get(
      Uri.parse(RestDatasource.MORTGAGELIST_URL + "admin_id=" + id.toString()),
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
      jsonArray = jsonRes['data'];
    });
    if (res!.statusCode == 200) {
      if (jsonRes["status"] == true) {
        mortgageList.clear();

        for (var i = 0; i < jsonArray.length; i++) {
          print("length: " + jsonArray.length.toString());
          MortgageProperties modelSearch = new MortgageProperties();
          modelSearch.id = jsonArray[i]["id"].toString();
          modelSearch.uuid = jsonArray[i]["uuid"].toString();
          modelSearch.user_id = jsonArray[i]["user_id"].toString();
          modelSearch.client1_name = jsonArray[i]["client1_name"].toString();
          modelSearch.client1_email = jsonArray[i]["client1_email"].toString();
          modelSearch.client1_phone = jsonArray[i]["client1_phone"].toString();
          modelSearch.client1_dob = jsonArray[i]["client1_dob"].toString();
          modelSearch.client1_childrenAges =
              jsonArray[i]["client1_childrenAges"].toString();
          modelSearch.client1_residentStatus =
              jsonArray[i]["client1_residentStatus"].toString();
          modelSearch.client1_passportNumber =
              jsonArray[i]["client1_passportNumber"].toString();
          modelSearch.client2_name = jsonArray[i]["client2_name"].toString();
          modelSearch.client2_email = jsonArray[i]["client2_email"].toString();
          modelSearch.client2_phone = jsonArray[i]["client2_phone"].toString();
          modelSearch.client2_dob = jsonArray[i]["client2_dob"].toString();
          modelSearch.client2_childrenAges =
              jsonArray[i]["client2_childrenAges"].toString();
          modelSearch.status = jsonArray[i]["status"].toString();
          modelSearch.created_at = jsonArray[i]["created_at"].toString();
          modelSearch.updated_at = jsonArray[i]["updated_at"].toString();
          modelSearch.mortgage_id = jsonArray[i]["mortgage_id"].toString();
          modelSearch.mortgage_purpose =
              jsonArray[i]["mortgage_purpose"].toString();
          modelSearch.purchase_price =
              jsonArray[i]["purchase_price"].toString();
          modelSearch.property_value =
              jsonArray[i]["property_value"].toString();
          modelSearch.deposite_require =
              jsonArray[i]["deposite_require"].toString();
          modelSearch.amount_requested =
              jsonArray[i]["amount_requested"].toString();
          modelSearch.terms_of_year = jsonArray[i]["terms_of_year"].toString();
          modelSearch.primary_address =
              jsonArray[i]["primary_address"].toString();
          modelSearch.resident_type = jsonArray[i]["resident_type"].toString();
          modelSearch.living_since = jsonArray[i]["living_since"].toString();
          modelSearch.outstanding_loan =
              jsonArray[i]["outstanding_loan"].toString();
          modelSearch.monthly_cost = jsonArray[i]["monthly_cost"].toString();
          modelSearch.approx_property_value =
              jsonArray[i]["approx_property_value"].toString();
          modelSearch.mortgage_address =
              jsonArray[i]["mortgage_address"].toString();
          modelSearch.property_type = jsonArray[i]["property_type"].toString();
          modelSearch.bedroom = jsonArray[i]["bedroom"].toString();
          modelSearch.bathroom = jsonArray[i]["bathroom"].toString();
          modelSearch.garage = jsonArray[i]["garage"].toString();
          modelSearch.store = jsonArray[i]["store"].toString();
          modelSearch.m_plot = jsonArray[i]["m_plot"].toString();
          modelSearch.m_constructed = jsonArray[i]["m_constructed"].toString();
          modelSearch.client_lawyer_name =
              jsonArray[i]["client_lawyer_name"].toString();
          modelSearch.client_lawyer_email =
              jsonArray[i]["client_lawyer_email"].toString();
          modelSearch.client_lawyer_phone =
              jsonArray[i]["client_lawyer_phone"].toString();
          modelSearch.client_lawyer_fax =
              jsonArray[i]["client_lawyer_fax"].toString();
          modelSearch.vendor_lawyer_name =
              jsonArray[i]["vendor_lawyer_name"].toString();
          modelSearch.vendor_lawyer_email =
              jsonArray[i]["vendor_lawyer_email"].toString();
          modelSearch.vendor_lawyer_phone =
              jsonArray[i]["vendor_lawyer_phone"].toString();
          modelSearch.vendor_lawyer_fax =
              jsonArray[i]["vendor_lawyer_fax"].toString();
          modelSearch.agent_promoter_name =
              jsonArray[i]["agent_promoter_name"].toString();
          modelSearch.agent_promoter_email =
              jsonArray[i]["agent_promoter_email"].toString();
          modelSearch.agent_promoter_phone =
              jsonArray[i]["agent_promoter_phone"].toString();
          modelSearch.agent_promoter_fax =
              jsonArray[i]["agent_promoter_fax"].toString();
          modelSearch.notes = jsonArray[i]["notes"].toString();
          modelSearch.client1_employed =
              jsonArray[i]["client1_employed"].toString();
          modelSearch.client1_self_employed =
              jsonArray[i]["client1_self_employed"].toString();
          modelSearch.client1_emp_name =
              jsonArray[i]["client1_emp_name"].toString();
          modelSearch.client1_emp_address =
              jsonArray[i]["client1_emp_address"].toString();
          modelSearch.client1_contact_name =
              jsonArray[i]["client1_contact_name"].toString();
          modelSearch.client1_position =
              jsonArray[i]["client1_position"].toString();
          modelSearch.client1_income =
              jsonArray[i]["client1_income"].toString();
          modelSearch.client1_service_length =
              jsonArray[i]["client1_service_length"].toString();
          modelSearch.client1_contract_type =
              jsonArray[i]["client1_contract_type"].toString();
          modelSearch.client2_employed =
              jsonArray[i]["client2_employed"].toString();
          modelSearch.client2_self_employed =
              jsonArray[i]["client2_self_employed"].toString();
          modelSearch.client2_emp_name =
              jsonArray[i]["client2_emp_name"].toString();
          modelSearch.client2_emp_address =
              jsonArray[i]["client2_emp_address"].toString();
          modelSearch.client2_contact_name =
              jsonArray[i]["client2_contact_name"].toString();
          modelSearch.client2_position =
              jsonArray[i]["client2_position"].toString();
          modelSearch.client2_income =
              jsonArray[i]["client2_income"].toString();
          modelSearch.client2_service_length =
              jsonArray[i]["client2_service_length"].toString();
          modelSearch.client2_contract_type =
              jsonArray[i]["client2_contract_type"].toString();
          modelSearch.notes = jsonArray[i]["notes"].toString();
          var jsonArrayy = jsonArray[i]["c_loan"];

          print("jSonArray: " + jsonArrayy.length.toString());

          List<Cloan> cloanList = [];

          for (var i = 0; i < jsonArrayy.length; i++) {
            Cloan cModelSearch = new Cloan();
            cModelSearch.id = jsonArrayy[i]["id"].toString();
            cModelSearch.mortgage_id = jsonArrayy[i]["mortgage_id"].toString();
            cModelSearch.loan_type = jsonArrayy[i]["loan_type"].toString();
            cModelSearch.lender = jsonArrayy[i]["lender"].toString();
            cModelSearch.amount = jsonArrayy[i]["amount"].toString();
            cModelSearch.monthly_payment =
                jsonArrayy[i]["monthly_payment"].toString();
            cModelSearch.created_at = jsonArrayy[i]["created_at"].toString();
            cModelSearch.updated_at = jsonArrayy[i]["updated_at"].toString();

            cloanList.add(cModelSearch);
          }
          modelSearch.c_loan = cloanList;

          print("id: " + modelSearch.id.toString());

          mortgageList.add(modelSearch);
        }

        setState(() {
          isloading = false;
        });
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

class MortgageProperties {
  var id = "";
  var uuid = "";
  var user_id = "";
  var client1_name = "";
  var client1_email = "";
  var client1_phone = "";
  var client1_dob = "";
  var client1_childrenAges = "";
  var client1_residentStatus = "";
  var client1_passportNumber = "";
  var client2_name = "";
  var client2_email = "";
  var client2_phone = "";
  var client2_dob = "";
  var client2_childrenAges = "";
  var status = "";
  var created_at = "";
  var updated_at = "";
  var mortgage_id = "";
  var mortgage_purpose = "";
  var purchase_price = "";
  var property_value = "";
  var deposite_require = "";
  var amount_requested = "";
  var terms_of_year = "";
  var primary_address = "";
  var resident_type = "";
  var living_since = "";
  var outstanding_loan = "";
  var monthly_cost = "";
  var approx_property_value = "";
  var mortgage_address = "";
  var property_type = "";
  var bedroom = "";
  var bathroom = "";
  var garage = "";
  var store = "";
  var m_plot = "";
  var m_constructed = "";
  var client_lawyer_name = "";
  var client_lawyer_email = "";
  var client_lawyer_phone = "";
  var client_lawyer_fax = "";
  var vendor_lawyer_name = "";
  var vendor_lawyer_email = "";
  var vendor_lawyer_phone = "";
  var vendor_lawyer_fax = "";

  var agent_promoter_name = "";
  var agent_promoter_email = "";
  var agent_promoter_phone = "";
  var agent_promoter_fax = "";
  var notes = "";
  var client1_employed = "";
  var client1_self_employed = "";
  var client1_emp_name = "";
  var client1_emp_address = "";
  var client1_contact_name = "";
  var client1_position = "";
  var client1_income = "";
  var client1_service_length = "";
  var client1_contract_type = "";
  var client2_employed = "";
  var client2_self_employed = "";
  var client2_emp_name = "";
  var client2_emp_address = "";
  var client2_contact_name = "";
  var client2_position = "";
  var client2_income = "";
  var client2_service_length = "";
  var client2_contract_type = "";

  List<Cloan> c_loan = [];
}

class Cloan {
  var id = "";
  var mortgage_id = "";
  var loan_type = "";
  var lender = "";
  var amount = "";
  var monthly_payment = "";
  var created_at = "";
  var updated_at = "";
}
