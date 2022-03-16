import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roccabox_admin/agora/dialscreen/dialScreeen.dart';
import 'package:roccabox_admin/agora/videoCall/videoCall.dart';
import 'package:roccabox_admin/screens/documentScreen.dart';
import 'package:roccabox_admin/screens/imageScreen.dart';
import 'package:roccabox_admin/screens/videoScreen.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:roccabox_admin/services/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

import '../main.dart';
import 'chat.dart';

class ChatScreen extends StatefulWidget {
  var senderId, receiverId, name, image, fcm, userType;
  ChatScreen({Key? key, this.image, this.name, this.receiverId, this.senderId, this.fcm, this.userType}):super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  final ScrollController listScrollController = ScrollController();
  TextEditingController _textEditingController = new TextEditingController();
  final FocusNode focusNode = FocusNode();
  var message = "";
  int _limit = 20;
  int _limitIncrement = 20;
  var name;
  var image;
  File? imageFile;
  String imageUrl = "";
  var msg = "";
  bool isLoading = false;
  FirebaseMessaging? auth;
  bool sendimage = false;
  var token;
  UserList? userr;

  late VideoPlayerController _controller;
 // final databaseRef = FirebaseDatabase.instance.reference(); //database reference object
  var textEnable = true;
  @override
  void initState() {
    getChatData();

    currentInstance = "CHAT_SCREEN";
    chatUser = widget.receiverId;
    focusNode.unfocus();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    auth = FirebaseMessaging.instance;
    auth?.getToken().then((value){
      print("FirebaseTokenHome "+value.toString());
      token = value.toString();

    });
    getData();
    super.initState();

  }


  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {

      });
    }
  }

  _scrollListener() {
    if (listScrollController.offset >=
        listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

@override
  void dispose() {
    currentInstance = "";
    chatUser = "";
    focusNode.unfocus();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffFFFFFF),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Container(
            width: double.infinity,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  widget.image==null? CircleAvatar(
                    backgroundImage: AssetImage('assets/img1.png'),
                  ):widget.image.toString()=="null"?CircleAvatar(
                    backgroundImage: AssetImage('assets/img1.png'),
                  ):CircleAvatar(backgroundImage: NetworkImage(widget.image.toString() )),

                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        getAccessToken(widget.receiverId.toString(), "VOICE");

                      },
                      icon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      )),
                  IconButton(
                      onPressed: () {
                        getAccessToken(widget.receiverId.toString(), "VIDEO");

                      },
                      icon: Icon(
                        Icons.videocam_rounded,
                        color: Colors.black,
                      ))
                ],
              ),
              title: Text(
                widget.name==null?"":widget.name,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                '',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff818181),
                ),
              ),
            ),
          )),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),

              // Sticker
              // isShowSticker ? buildSticker() : Container(),
              Visibility(
                  visible: sendimage,
                  child: Container(width:100,height:100,child: Align(alignment:Alignment.centerRight,child: CircularProgressIndicator( color: Color(0xffFFBA00),),),)),

              // Input content
              buildInput(),
            ],
          ),
        ],
      ),
    );
  }


  Widget buildListMessage() {
    return Flexible(
      child: widget.senderId!=null && widget.receiverId!=null
          ? StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat_master')
            .doc("message_list")
            .collection(widget.senderId+"-"+widget.receiverId)
            .orderBy('timestamp', descending: true)
        //.limit(_limit)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            listMessage.clear();
            listMessage.addAll(snapshot.data!.docs);
            return chatMessage(listMessage , snapshot.data!.docs);
            //  return ListView.builder(
            //    padding: EdgeInsets.all(10.0),
            //    itemBuilder: (context, index) => buildItem(index, snapshot.data?.docs[index]),
            //    itemCount: snapshot.data?.docs.length,
            //    reverse: true,
            //    controller: listScrollController,
            //  );
          } else {
            return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                ));


          }
        },
      )
          : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
        ),
      ),
    );
  }




  Widget chatMessage(List<QueryDocumentSnapshot<Object?>> listMessage, List<QueryDocumentSnapshot<Object?>> docs) {
    print("SizeofList "+listMessage.length.toString()+"");
    return ListView.builder(
      itemCount:listMessage.length ,
      reverse: true,
      itemBuilder: (BuildContext context, int index) {
        var hour = DateTime.fromMillisecondsSinceEpoch(int.parse(docs[index].get("timestamp")) ).hour.toString() +":";
        var min = DateTime.fromMillisecondsSinceEpoch(int.parse(docs[index].get("timestamp")) ).minute.toString();
        if(min.length<2){
          min = "0"+min;

        }
        var datetime = DateTime.fromMillisecondsSinceEpoch(int.parse(docs[index].get("timestamp")) ).day.toString()+"/"+DateTime.fromMillisecondsSinceEpoch(int.parse(docs[index].get("timestamp")) ).month.toString()+"/"+DateTime.fromMillisecondsSinceEpoch(int.parse(docs[index].get("timestamp")) ).year.toString();
        var date = hour+min;

        return docs[index].get("content")!=""?Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: docs[index].get("idFrom").toString()==widget.senderId?CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [
              docs[index].get("type")=="document"?GestureDetector(
                onTap: (){
                  if(docs[index].get("content")!=null){
                    if(docs[index].get("content")!=""){
                      print("OnTap Document");
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => DocumentScreen(path: docs[index].get("content"),)));

                    }
                  }
                },
                child: Material(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                      topLeft: docs[index].get("idFrom").toString() ==
                          widget.senderId
                          ? Radius.circular(30.0)
                          : Radius.circular(0.0),
                      topRight: docs[index].get("idFrom").toString() ==
                          widget.senderId
                          ? Radius.circular(0)
                          : Radius.circular(30.0)),
                  elevation: 5.0,
                  color: docs[index].get("idFrom").toString() != widget.senderId
                      ? Colors.blueAccent
                      : kPrimaryColor,
                  child:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 50,
                            width: 50,
                            child:Image.asset("assets/doc_icon.png")

                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,0.0),
                            child: Container(
                                child:Text("Document", style: TextStyle(color:Colors.white),)

                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Row(
                                  children: [
                                    Text(date.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white
                                      ),),
                                    Text("  ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white
                                      ),),
                                    Text(datetime.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white
                                      ),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )


                  : docs[index].get("type")=="video"?GestureDetector(
                  onTap: (){
                    if(docs[index].get("content")!=null){
                      if(docs[index].get("content")!=""){
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => VideoScreen(video: docs[index].get("content"),)));

                      }
                    }
                  },
                  child:Material(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        topLeft: docs[index].get("idFrom").toString() ==
                            widget.senderId
                            ? Radius.circular(30.0)
                            : Radius.circular(0.0),
                        topRight: docs[index].get("idFrom").toString() ==
                            widget.senderId
                            ? Radius.circular(0)
                            : Radius.circular(30.0)),
                    elevation: 5.0,
                    color: docs[index].get("idFrom").toString() != widget.senderId
                        ? Colors.blueAccent
                        : kPrimaryColor,
                    child:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 50,
                              width: 50,
                              child:Image.asset("assets/play.png")

                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  child:Text("Video", style: TextStyle(color:Colors.white),)

                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  Row(
                                    children: [
                                      Text(date.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white
                                        ),),
                                      Text("  ",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white
                                        ),),
                                      Text(datetime.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white
                                        ),),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )):  docs[index].get("type")=="image"?GestureDetector(
                onTap: (){
                  if(docs[index].get("content")!=null){
                    if(docs[index].get("content")!=""){
                      print("OnTap Image");

                      Navigator.push(context, new MaterialPageRoute(builder: (context) => ImageScreen(image: docs[index].get("content"),)));

                    }
                  }
                },
                child: Container(
                  child: Material(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CachedNetworkImage(
                          placeholder: (con, url ){
                            return Image.asset(
                              'assets/placeholder.png',
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.fill,
                            );
                          },
                          errorWidget:(con,url,error){
                            return Material(
                              child: Image.asset(
                                'assets/img_not_available.png',
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            );
                          },
                          imageUrl: docs[index].get("content"),
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.fill,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Row(
                                  children: [
                                    Text(date.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black
                                      ),),
                                    Text("  ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black
                                      ),),
                                    Text(datetime.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black
                                      ),),
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  margin: EdgeInsets.only(bottom:docs[index].get("idFrom").toString() != widget.senderId ? 20.0 : 10.0, right: 10.0),
                ),
              ): Material(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0),
                      topLeft: docs[index].get("idFrom").toString()==widget.senderId?Radius.circular(30.0):Radius.circular(0.0),
                      topRight: docs[index].get("idFrom").toString()==widget.senderId?Radius.circular(0):Radius.circular(30.0)),
                  elevation: 5.0,
                  color: docs[index].get("idFrom").toString()!=widget.senderId?Colors.blueAccent: Color(0xffFFBA00),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              flex:1,
                              child: Text(
                                docs[index].get("content"),
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Row(
                                  children: [
                                    Text(date.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white
                                      ),),
                                    Text("  ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white
                                      ),),
                                    Text(datetime.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white
                                      ),),
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  )),


            ],
          ),
        ):SizedBox(height: 0,);
        // return Container(
        //   padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        //   width: 200.0,
        //   margin: EdgeInsets.only(
        //       bottom:  10.0, right: 10.0),
        //   decoration: BoxDecoration(
        //     color: Colors.grey[100],
        //     borderRadius: BorderRadius.circular(5),
        //     boxShadow: [
        //       BoxShadow(
        //           color: Colors.black54,
        //           offset: Offset(2, 3),
        //           blurRadius: 10,
        //           spreadRadius: 1)
        //     ],
        //   ),
        //   child: Text("Hello World"),
        // );
      },
    );
  }

  Future getThumbnail(param0) async {
    _controller = VideoPlayerController.network(
       param0)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        return true;
      });

    }

  Widget buildInput() {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15),
      child: Column(
        children: [
          Container(

            height: 1,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
                ),
          ),
          Row(
            children: <Widget>[
              // Button send image
              // Material(
              //   child: Container(
              //     margin: EdgeInsets.symmetric(horizontal: 1.0),
              //     child: IconButton(
              //       icon: Icon(Icons.image),
              //       onPressed: (){},
              //       color: kPrimaryColor,
              //     ),
              //   ),
              //   color: Colors.white,
              // ),
              // Material(
              //   child: Container(
              //     margin: EdgeInsets.symmetric(horizontal: 1.0),
              //     child: IconButton(
              //       icon: Icon(Icons.face),
              //       onPressed: (){},
              //       color: kPrimaryColor,
              //     ),
              //   ),
              //   color: Colors.white,
              // ),

              // Edit text



              Flexible(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: TextField(
                    enabled: textEnable,
                    onSubmitted: (value) {},
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: bottomSheet,
                          child: SvgPicture.asset(
                                    "assets/attachment.svg",
                                    width: 5,
                                    color: Colors.grey,

                                  ),
                        ),
                      ),
                    ),
                    focusNode: focusNode,

                  ),
                ),
              ),

              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {

                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 46,
                      width: 46,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          String mmmm = "";
                          mmmm = _textEditingController.text.toString().trim();
                          _textEditingController.clear();
                          print("mmmm "+mmmm+"");

                          //focusNode.unfocus();
                          if( mmmm.isNotEmpty && mmmm != "") {

                            print("SenderId "+widget.senderId+"");
                            print("Id "+widget.receiverId+"");
                            var documentReference = FirebaseFirestore.instance
                                .collection('chat_master')
                                .doc("message_list")
                                .collection(widget.senderId+"-"+widget.receiverId)
                                .doc(DateTime.now()
                                .millisecondsSinceEpoch
                                .toString());

                            firestoreInstance.runTransaction((transaction) async {
                              transaction.set(
                                documentReference,
                                {
                                  'idFrom': widget.senderId,
                                  'idTo': widget.receiverId,
                                  'timestamp': DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  'content':mmmm,
                                  'type': "text"
                                },
                              );
                            }).then((value){

                              print("TextEdit "+mmmm);
                              if(mmmm!=null && mmmm!="") {
                                var documentReference = FirebaseFirestore
                                    .instance
                                    .collection('chat_master')
                                    .doc("message_list")
                                    .collection(
                                    widget.receiverId + "-" + widget.senderId)
                                    .doc(DateTime
                                    .now()
                                    .millisecondsSinceEpoch
                                    .toString());

                                firestoreInstance.runTransaction((
                                    transaction) async {
                                  transaction.set(
                                    documentReference,
                                    {
                                      'idFrom': widget.senderId,
                                      'idTo': widget.receiverId,
                                      'timestamp': DateTime
                                          .now()
                                          .millisecondsSinceEpoch
                                          .toString(),
                                      'content': mmmm,
                                      'type': "text"
                                    },
                                  );
                                });
/*

                                Map<String, String> map = new HashMap();
                                map = {
                                  'idFrom': widget.senderId,
                                  'idTo': widget.receiverId,
                                  'timestamp': DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  'content':mmmm,
                                  'type': "text"
                                };
                                databaseRef.child("chat_master")
                                .child("message_list")
                                .child(widget.senderId)
                                .child(widget.receiverId)
                                .child(DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString())
                                .update(map).then((value) {
                                  Map<String, String> map1 = {
                                    'idFrom': widget.senderId,
                                    'idTo': widget.receiverId,
                                    'timestamp': DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    'content':mmmm,
                                    'type': "text"
                                  };
                                  databaseRef.child("chat_master")
                                      .child("message_list")
                                      .child(widget.receiverId)
                                      .child(widget.senderId)
                                      .child(DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString())
                                      .update(map1);
                                });
*/


                                updateChatHead(mmmm);
                              }
                              _textEditingController.clear();

                            });


                            sendNotification(mmmm.toString());
                          /*  listScrollController.animateTo(0.0,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut);*/
                          }
                        },
                        color: Color(0xffFFBA00),
                      ),
                    ),
                  ],
                ),
              ),

              //  Material(
              //     child: IconButton(

              //       icon: Icon(Icons.send),
              //       onPressed: (){},
              //       color: Colors.yellow[600],
              //     ),
              //     color: Colors.white,
              // ),

              // Button send message
            ],
          ),
        ],
      ),
      width: double.infinity,
      height: 70.0,
      //  decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 0.5)), color: Colors.white),
    );
  }

void bottomSheet(){
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: new Icon(Icons.photo),
              title: new Text('Photo'),
              onTap: () {
                getImage();
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: new Icon(Icons.videocam),
              title: new Text('Video'),
              onTap: () {
                getVideo();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(Icons.picture_as_pdf),
              title: new Text('Documents'),
              onTap: () {
                getPdf();
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

  void updateChatHead(String s) async {
    print("messageeee "+s+"");
    print("agentName " + widget.name + "");
    print("username " + name + "");
    if(widget.userType=="user"){
      var documentReference = FirebaseFirestore.instance
          .collection('chat_master')
          .doc("chat_head")
          .collection(widget.senderId)
          .doc(widget.receiverId);
      print("s "+s+"");

      firestoreInstance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
          'idFrom': widget.senderId,
          'idTo': widget.receiverId,
          'msg': s.toString(),
          'timestamp': DateTime.now()
              .millisecondsSinceEpoch
              .toString(),
          'type': "text",
          'image':widget.image,
          "user": widget.name,
          'admin': name,
          'user':widget.name,
          'clicked': "true",
          'fcmToken':userr!.fcm.toString(),
          'chatType':widget.userType=="user"?"user-admin":"agent-admin"

          },
        );
      }).then((value) {
        var documentReference = FirebaseFirestore.instance
            .collection('chat_master')
            .doc("chat_head")
            .collection(widget.receiverId)
            .doc(widget.senderId);

        firestoreInstance.runTransaction((transaction) async {
          transaction.set(
            documentReference,
            {
              'idFrom': widget.senderId,
              'idTo': widget.receiverId,
              'timestamp': DateTime
                  .now()
                  .millisecondsSinceEpoch
                  .toString(),
              'msg': s.toString(),
              'type': "text",
              'image': image,
              // 'agent': widget.name,
              "user": widget.name,
              'admin': name,
              'clicked': "false",
              'fcmToken':token,
              'chatType':widget.userType=="user"?"user-admin":"agent-admin"
            },
          );
        });
      });
    }else{
      var documentReference = FirebaseFirestore.instance
          .collection('chat_master')
          .doc("chat_head")
          .collection(widget.senderId)
          .doc(widget.receiverId);
      print("s "+s+"");

      firestoreInstance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
          'idFrom': widget.senderId,
          'idTo': widget.receiverId,
          'msg': s.toString(),
          'timestamp': DateTime.now()
              .millisecondsSinceEpoch
              .toString(),
          'type': "text",
          'image':widget.image,
          "agent":widget.name,
          'admin': name,
          'user':widget.name,
          'clicked': "true",
          'fcmToken':userr!.fcm.toString(),
          'chatType':widget.userType=="user"?"user-admin":"agent-admin"

          },
        );
      }).then((value) {
        var documentReference = FirebaseFirestore.instance
            .collection('chat_master')
            .doc("chat_head")
            .collection(widget.receiverId)
            .doc(widget.senderId);

        firestoreInstance.runTransaction((transaction) async {
          transaction.set(
            documentReference,
            {
              'idFrom': widget.senderId,
              'idTo': widget.receiverId,
              'timestamp': DateTime
                  .now()
                  .millisecondsSinceEpoch
                  .toString(),
              'msg': s.toString(),
              'type': "text",
              'image': image,
              // 'agent': widget.name,
              "agent":widget.name,
              'admin': name,
              'clicked': "false",
              'fcmToken':token,
              'chatType':widget.userType=="user"?"user-admin":"agent-admin"
            },
          );
        });
      });
    }

    message = "";
    
/*
    Map<String,String> inputMap = new HashMap();
    inputMap = {
      'idFrom': widget.senderId,
      'idTo': widget.receiverId,
      'msg': s.toString(),
      'timestamp': DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      'type': "text",
      'image':widget.image,
      'agent': widget.name,
      'user':name,
      'clicked': "true",
      'fcmToken':widget.fcm
    };
    Map<String,String> inputMap2 = new HashMap();
    inputMap2 = {
      'idFrom': widget.senderId,
      'idTo': widget.receiverId,
      'msg': s.toString(),
      'timestamp': DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      'type': "text",
      'image':image,
      'agent': widget.name,
      'user':name,
      'clicked': "true",
      'fcmToken':widget.fcm
    };

    databaseRef.child("chat_master").child("chat_head").child(widget.senderId).child(widget.receiverId).update(inputMap).onError((error, stackTrace) {
      print(error.toString());
    }).then((value) {
      print("Update heads realtime successfully");
    });
    databaseRef.child("chat_master").child("chat_head").child(widget.receiverId).child(widget.senderId).update(inputMap2);
*/

  }



  void updateChatHead2(String s, int type) async {

    if(widget.userType=="user") {
      var documentReference = FirebaseFirestore.instance
          .collection('chat_master')
          .doc("chat_head")
          .collection(widget.senderId)
          .doc(widget.receiverId);
      print("s " + s + "");

      firestoreInstance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': widget.senderId,
            'idTo': widget.receiverId,
            'msg': type == 1 ? "image" : type == 2 ? "video" : "Document",
            'timestamp': DateTime
                .now()
                .millisecondsSinceEpoch
                .toString(),
            'type': type == 1 ? "image" : type == 2 ? "video" : "document",
            'image': widget.image,
            'admin': name,
            'user': widget.name,
            'clicked': "true",
            'fcmToken': userr!.fcm.toString(),
            'chatType': widget.userType == "user" ? "user-admin" : "agent-admin"
          },
        );
      }).then((value) {
        var documentReference = FirebaseFirestore.instance
            .collection('chat_master')
            .doc("chat_head")
            .collection(widget.receiverId)
            .doc(widget.senderId);

        firestoreInstance.runTransaction((transaction) async {
          transaction.set(
            documentReference,
            {
              'idFrom': widget.senderId,
              'idTo': widget.receiverId,
              'timestamp': DateTime
                  .now()
                  .millisecondsSinceEpoch
                  .toString(),
              'msg': type == 1 ? "image" : type == 2 ? "video" : "Document",
              'type': type == 1 ? "image" : type == 2 ? "video" : "document",
              'image': image,
              'admin': name,
              'user': widget.name,
              'clicked': "false",
              'fcmToken': token,
              'chatType': widget.userType == "user"
                  ? "user-admin"
                  : "agent-admin"
            },
          );
        });
      });
    }else{
      var documentReference = FirebaseFirestore.instance
          .collection('chat_master')
          .doc("chat_head")
          .collection(widget.senderId)
          .doc(widget.receiverId);
      print("s " + s + "");

      firestoreInstance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': widget.senderId,
            'idTo': widget.receiverId,
            'msg': type == 1 ? "image" : type == 2 ? "video" : "Document",
            'timestamp': DateTime
                .now()
                .millisecondsSinceEpoch
                .toString(),
            'type': type == 1 ? "image" : type == 2 ? "video" : "document",
            'image': widget.image,
            'admin': name,
            'agent': widget.name,
            'clicked': "true",
            'fcmToken': userr!.fcm.toString(),
            'chatType': widget.userType == "user" ? "user-admin" : "agent-admin"
          },
        );
      }).then((value) {
        var documentReference = FirebaseFirestore.instance
            .collection('chat_master')
            .doc("chat_head")
            .collection(widget.receiverId)
            .doc(widget.senderId);

        firestoreInstance.runTransaction((transaction) async {
          transaction.set(
            documentReference,
            {
              'idFrom': widget.senderId,
              'idTo': widget.receiverId,
              'timestamp': DateTime
                  .now()
                  .millisecondsSinceEpoch
                  .toString(),
              'msg': type == 1 ? "image" : type == 2 ? "video" : "Document",
              'type': type == 1 ? "image" : type == 2 ? "video" : "document",
              'image': image,
              'admin': name,
              'agent': widget.name,
              'clicked': "false",
              'fcmToken': token,
              'chatType': widget.userType == "user"
                  ? "user-admin"
                  : "agent-admin"
            },
          );
        });
      });
    }
    message = "";
  }
  Future getChatData() async {
    var jsonRes;
    var response =
    await http.post(Uri.parse(RestDatasource.BASE_URL + 'userProfile'),
        body: {
          "user_id":widget.receiverId.toString()
        }, headers: mapheaders);
    print("ReceiverId "+widget.receiverId.toString()+"^^");

    if (response.statusCode == 200) {
      var apiObj = JsonDecoder().convert(response.body.toString());
      if(apiObj["status"]==true){
        var data = apiObj["data"];
        userr = new UserList();
        userr!.fcm = data["firebase_token"];
      }

    } else {
      throw Exception('Failed to load album');
    }
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString("name");
    image = pref.getString("image");


    var documentReference = FirebaseFirestore.instance
        .collection('chat_master')
        .doc("chat_head")
        .collection(widget.senderId)
        .doc(widget.receiverId);

    firestoreInstance.runTransaction((transaction) async {
      transaction.update(
        documentReference,
        {
          'clicked': "true"
        },
      );
    });
  }
  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path.toString());
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadFile();
      }
    }
  }


  Future getVideo() async {
    await [Permission.storage].request();
    final pickedFile;

    pickedFile =  await ImagePicker.platform.getVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path.toString());
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadVideo();
      }
    }
  }
   Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //  Reference reference = FirebaseStorage.instance.ref().child("images/");
  //  UploadTask uploadTask = reference.putFile(imageFile!);

 Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTaskk = firebaseStorageRef.putFile(imageFile!);
    try {
      setState(() {
        sendimage = true;
      });
      TaskSnapshot snapshot = await uploadTaskk;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        sendimage = false;
        onSendMessage(imageUrl, 1);
      });
    } on FirebaseException catch (e) {
      print(e.toString());
      setState(() {
        sendimage = false;
      });

    }
  }
  Future uploadVideo() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    //  Reference reference = FirebaseStorage.instance.ref().child("images/");
    //  UploadTask uploadTask = reference.putFile(imageFile!);

    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('Videos/$fileName');
    UploadTask uploadTaskk = firebaseStorageRef.putFile(imageFile!);
    try {
      setState(() {
        sendimage = true;
      });
      TaskSnapshot snapshot = await uploadTaskk;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        sendimage = false;
        onSendMessage(imageUrl, 2);
      });
    } on FirebaseException catch (e) {
      print(e.toString());
      setState(() {
        sendimage = false;
      });

    }
  }

    onSendMessage(String content, int type) {


                        var documentReference = FirebaseFirestore.instance
                            .collection('chat_master')
                            .doc("message_list")
                            .collection(widget.senderId+"-"+widget.receiverId)
                            .doc(DateTime.now()
                            .millisecondsSinceEpoch
                            .toString());

                        firestoreInstance.runTransaction((transaction) async {
                          transaction.set(
                            documentReference,
                            {
                              'idFrom': widget.senderId,
                              'idTo': widget.receiverId,
                              'timestamp': DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              'content':content,
                              'type': type==1?"image":type==2?"video":"document"
                            },
                          );
                        }).then((value){
                          var documentReference = FirebaseFirestore.instance
                              .collection('chat_master')
                              .doc("message_list")
                              .collection(widget.receiverId+"-"+widget.senderId)
                              .doc(DateTime.now()
                              .millisecondsSinceEpoch
                              .toString());

                          firestoreInstance.runTransaction((transaction) async {
                            transaction.set(
                              documentReference,
                              {
                                'idFrom': widget.senderId,
                                'idTo': widget.receiverId,
                                'timestamp': DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                'content':content,
                                'type':  type==1?"image":type==2?"video":"document"
                              },
                            );
                          });

                          updateChatHead2(content, type);

                          _textEditingController.clear();
                          focusNode.unfocus();
                        });
                    /*    listScrollController.animateTo(0.0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut);*/

            msg =  type==1?"image":type==2?"video":"document";
                        sendNotification(msg);


  }





  Future getPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);

    PickedFile? pickedFile;
    if (result != null) {
      imageFile = File(result.files.single.path.toString());
    } else {
      // User canceled the picke
    }

    if (imageFile != null) {
      uploadpdf();

    }
  }


  Future uploadpdf() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    //  Reference reference = FirebaseStorage.instance.ref().child("images/");
    //  UploadTask uploadTask = reference.putFile(imageFile!);

    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('Documents/$fileName');
    UploadTask uploadTaskk = firebaseStorageRef.putFile(imageFile!);
    try {
      setState(() {
        sendimage = true;
      });
      TaskSnapshot snapshot = await uploadTaskk;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        sendimage = false;
        onSendMessage(imageUrl, 3);
      });
    } on FirebaseException catch (e) {
      print(e.toString());
      setState(() {
        sendimage = false;
      });
    }
  }
  Future<dynamic> getAccessToken(String id, String type) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userid = pref.getString("id");

    print("user_id "+userid.toString());
    // print(email)
    var authToken = pref.getString("auth_token").toString();
    print("AUTH_TOKEN "+authToken.toString());
    Map<String, String> mapheaders = new HashMap();
    mapheaders["Authorization"] = authToken.toString();

    var jsonRes;
    http.Response? res;
    var request = http.post(Uri.parse(RestDatasource.AGORATOKEN),
        body: {

          "type": type,
          "user_id": userid.toString(),
          "receiver_id": id,
          "time":DateTime.now().millisecondsSinceEpoch.toString(),
          "channelKey": widget.userType=="agent"?"key_agent":"key_user",
          "chName":widget.userType=="agent"?"agent_channel":"user_channel",
          "id": "10",
          "click_action": 'FLUTTER_NOTIFICATION_CLICK',


        },
    headers: mapheaders);
    print("Headers "+mapheaders.toString()+"^^");
    await request.then((http.Response response) {
      res = response;

      // msg = jsonRes["message"].toString();
      // getotp = jsonRes["otp"];
      // print(getotp.toString() + '123');t
    });
    if (res!.statusCode == 200) {
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(res!.body.toString());
      print("Response: " + res!.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");


      if(jsonRes["status"]==true){
        var agoraToken = jsonRes["agora_token"].toString();
        var channel = jsonRes["channelName"].toString();
        var name = jsonRes["receiver"]["name"].toString();
        var image = jsonRes["receiver"]["image"].toString();
        var time = jsonRes["time"].toString();
        var fcm = jsonRes["receiver"]["firebase_token"].toString();
        registerCall(userid.toString(),name, image, type, fcm, id, "Calling", agoraToken, channel, time);

      }else{
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(jsonRes['message'].toString())));
      }

    } else {

    }
  }
  void registerCall(String userid, String nm, String img, String type, String fcmToken,String idd, String status, String agoraToken, String channel, String time) async {

    var documentReference = FirebaseFirestore.instance
        .collection('call_master')
        .doc("call_head")
        .collection(userid)
        .doc(time);


    firestoreInstance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        {
          'fcmToken': fcmToken,
          'id': idd,
          'image': img,
          'name': nm,
          'timestamp': time,
          'type': type,
          'callType':"incoming",
          'status': status

        },
      );
    }).then((value) {
      var documentReference = FirebaseFirestore.instance
          .collection('call_master')
          .doc("call_head")
          .collection(idd)
          .doc(time);

      firestoreInstance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'fcmToken': token,
            'id': userid,
            'image': image,
            'name': name,
            'timestamp': time,
            'type': type,
            'callType':"outgoing",
            'status':status
          },
        );
      });
    });
    if(type=="VIDEO"){
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> VideoCall(name:nm ,image:img, channel: channel, token: agoraToken, myId: userid.toString(),time: time,senderId: idd)));

    }else{
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> DialScreen(name:nm ,image:img, channel: channel, agoraToken: agoraToken,myId: userid.toString(),time: time, receiverId: idd, )));

    }
  }

  Future sendNotification(String type) async {
    print("SenderToken "+userr!.fcm.toString());
    Map<String, String> map  = new HashMap();
    map["Authorization"] = "key=AAAAtgmz2LM:APA91bHyV1VbnfG-dRXDo1cgzQDkYll-0ZRdKbeTL4Hv0hbFilEiTPLHHXkA_teNx-z9xNBqkM2a54TwJ75-mPQjCsBVlzKyuSYPc3oJHMCpFBqlSPWrClV96h5xuVQsGBEu8yVzlZdn";
    map["content-type"] = "application/json";
    var jsonRes;
    var dataJson ;
    Obj obj = new Obj();
    obj.title = "Hello";
    obj.body = "This is body";
    obj.time = "11:58 PM";
    print("sdasda "+obj.toJson().toString());
   /* var response =
    await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),body: {
      "to":"c5uZ5jc0TBOp6CfaMfmjTq:APA91bElx-DFQyUiKMARntPEcx1eZ8vf1ZJrclkcijbDpzmy-DfAnYvK6N8zNU4sJ8qDCxIlmOMUtOO5gHnL8nbA1943aKCE5K2gno1ZhvldMaJpmXmWDkck5A9KzjwYqwJwcsZlvzB7",
      "priority":"",
      "data":obj.toJson(),
    },
    headers: map);*/


    final response = await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': type.toString(),
              'title': name
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action':
              'FLUTTER_NOTIFICATION_CLICK',
              'id': widget.senderId,
              'status': 'done',
              "screen": "CHAT_SCREEN",
              "name":widget.name,
              "image":widget.image,
              "receiverId":widget.receiverId,
              "senderid":widget.senderId,
              "fcm":userr!.fcm.toString(),
              'body': type.toString(),
              'title': name
            },
            'to': userr!.fcm.toString()
          },
        ),
        encoding: Encoding.getByName('utf-8'),
        headers: map);


    if (response.statusCode == 200) {

      var apiObj = JsonDecoder().convert(response.body.toString());
      print(apiObj.toString()+"^^");
    } else {
      throw Exception('Failed to load album');
    }

    msg= "";
  }




}

class Obj{
  String title = "";
  String body = "";
  String time = "";

  Map toJson() => {
    'title': title,
    'body': body,
    'time': time
  };
}


/*

Container(
margin: EdgeInsets.only(bottom: 60, top: 10),
child: ListView.builder(
itemCount: 5,
itemBuilder: (BuildContext context, int index) {
return SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.end,
children: [
Align(
alignment: Alignment.topLeft,
child: Container(
margin: EdgeInsets.only(left: 10),
decoration: BoxDecoration(
color: Color(0xffF8F7F7),
borderRadius: BorderRadius.only(
topRight: Radius.circular(10),
bottomLeft: Radius.circular(10),
bottomRight: Radius.circular(10))),
padding: const EdgeInsets.all(10.0),
child: Text('Hi, how are you?'),
),
),
Container(
margin:
EdgeInsets.only(right: 10, top: 20, bottom: 20),
decoration: BoxDecoration(
color: Color(0xffF1F0EE),
borderRadius: BorderRadius.only(
topLeft: Radius.circular(10),
bottomLeft: Radius.circular(10),
bottomRight: Radius.circular(10))),
padding: const EdgeInsets.all(10.0),
child: Text('Good, how are you?'),
)
],
),
);
}),
),*/

/*

Positioned(
left: 0,
right: 0,
bottom: 0,
child: Container(
color: Colors.white,
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Container(
width: double.infinity,
child: Row(
mainAxisSize: MainAxisSize.min,
mainAxisAlignment: MainAxisAlignment.center,
children: [
Container(
// height: 50,
width: MediaQuery.of(context).size.width * .70,
child: TextField(
cursorColor: Color(0xff818181),
decoration: InputDecoration(
isDense: true,
hintText: 'Type a message',
suffixIcon: Transform.rotate(
angle: 180,
child: Icon(
Icons.attachment,
size: 30,
color: Color(0xff818181),
)),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(50),
borderSide:
BorderSide(color: Color(0xffFFBA00))),
enabledBorder: OutlineInputBorder(
borderSide:
BorderSide(color: Color(0xffE5E5E5)),
borderRadius: BorderRadius.circular(50)),
border: OutlineInputBorder(
borderSide:
BorderSide(color: Color(0xffFFBA00)),
borderRadius: BorderRadius.circular(50))),
),
),
SizedBox(
width: 10,
),
Container(
height: 50,
width: 50,
decoration: BoxDecoration(
shape: BoxShape.circle, color: Color(0xffFFBA00)),
child: Padding(
padding: const EdgeInsets.only(left: 3.0),
child: Icon(
Icons.send,
color: Colors.white,
),
),
)
],
),
),
),
),
)
*/



