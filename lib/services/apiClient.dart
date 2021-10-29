import 'dart:async';
import 'dart:io';



class RestDatasource {
  
  static final BASE_URL = "https://facebook.roccabox.com/blog/api/";
  static final LOGIN_URL = BASE_URL + "Login";
  static final HOMEPAGE_URL = BASE_URL + "totalUsers?";
  static final TOTALUSERLIST_URL = BASE_URL + "user/all?";
  static final ADDUSER_URL = BASE_URL + "user/add";
  static final EDITUSER_URL = BASE_URL + "user/edit";
  static final DELETEUSER_URL = BASE_URL + "user/delete";
  static final TOTALAGENTLIST_URL = BASE_URL + "agent/all?";
  static final ADDAGENT_URL = BASE_URL + "agent/add";
  static final EDITAGENT_URL = BASE_URL + "agent/edit";
  static final SEARCHAGENT_URL = BASE_URL + "agent/search?";
  static final SEARCHUSER_URL = BASE_URL + "user/search?";
  static final NEWREQUESTAGENTLIST_URL = BASE_URL + "agent/newRequest?";
  static final GETENQUIRYLIST_URL =BASE_URL + "enquiry/all?";
  static final APPROVEAGENTLIST_URL = BASE_URL + "agent/approve";
  static final REJECTAGENTLIST_URL = BASE_URL + "agent/reject";
  static final SEARCHNEWAGENTLIST_URL = BASE_URL + "agent/searchNewRequest?";
  static final ENQUIRYASSIGN_URL = BASE_URL + "enquiry/assign";
  static final SLIDERBANNER_URL = BASE_URL + "agent/get-slider?";
  static final SEARCHSLIDER_URL = BASE_URL + "agent/searchSlider?";
  static final ADDBANNER_URL = BASE_URL + "agent/add-slider";
  static final DELETESLIDER_URL = BASE_URL + "agent/deleteSlider";
  static final CHANGEPASSWORD_URL = BASE_URL + "changePassword";
  static final EDITBANNER_URL = BASE_URL + "agent/edit-slider";
  static final MORTGAGELIST_URL = BASE_URL + "mortgage/all?";
  static final PROPERTYLIST_URL = BASE_URL + "property/all?";


  

  
}