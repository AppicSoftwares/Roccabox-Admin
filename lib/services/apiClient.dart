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
  static final SEARCHUSER_URL = BASE_URL + "user/search?";
  static final NEWREQUESTAGENTLIST_URL = BASE_URL + "agent/newRequest?";
  static final GETENQUIRYLIST_URL =BASE_URL + "enquiry/all?";
  static final APPROVEAGENTLIST_URL = BASE_URL + "agent/approve";
  static final REJECTAGENTLIST_URL = BASE_URL + "agent/reject";


  

  
}