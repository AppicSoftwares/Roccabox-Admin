import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:roccabox_admin/services/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'chatscreen.dart';


class Chat extends StatefulWidget {
  var typeList;
  Chat(this.typeList);
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  AsyncSnapshot<QuerySnapshot>? snapshot;
  List<QueryDocumentSnapshot> listUsers = new List.from([]);
  final firestoreInstance = FirebaseFirestore.instance;
//  final databaseRef = FirebaseDatabase.instance.reference(); //database reference object

  List<UserList> listUser = [];
  var id;

  @override
  void initState() {
    getData();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Chat',
          style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
              fontWeight: FontWeight.w600),
        ),
      ),
      body:

/*
      id!=null?StreamBuilder(
          stream: databaseRef.child("chat_master").child("chat_head").child(id).onValue,
          builder:(BuildContext context,
              AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }else{
              if(snapshot.hasData){
                listUser.clear();
                */
/* snapshot.data?.value.forEach((element) {
                  var json;
                  UserList model = new UserList();
                  model.id = element.id.toString();

                  print("StreamId "+element.id);
                  json = element.data();
                  print("StreamName " + json["user"].toString());
                  print("StreamImage " + element.get("image").toString());
                  model.name = json["agent"].toString();
                  model.image = json["image"].toString();
                  model.message = json["msg"].toString();
                  model.clicked = json["clicked"].toString();
                  model.fcm = json["fcmToken"].toString();

                  listUser.add(model);
                });*//*

              }
              var temp = snapshot.data;

              if(temp!=null){

                print("NewValue "+temp.snapshot.value.toString());
                Map<Object?, Object?> map = temp.snapshot.value;


                  map.forEach((key, value) {
                    print("KeyMain "+key.toString());
                    UserList model = new UserList();
                    model.id = key.toString();
                    Object? tempChild =  value;
                    if(tempChild!=null){
                      var childMap = tempChild as Map<Object?, Object?>;
                      print("childMap"+childMap.toString());
                      print("asasas "+childMap["221"].toString());
                      childMap.forEach((key, v) {
                        if(childMap.containsKey("msg")){
                          model.message = childMap["msg"].toString();
                        }
                        if(childMap.containsKey("timestamp")){
                          model.timeStamp = childMap["timestamp"].toString();
                        }

                        if(childMap.containsKey("agent")){
                          model.name = childMap["agent"].toString();
                        }

                        if(childMap.containsKey("image")){
                          model.image = childMap["image"].toString();
                        }
                        if(childMap.containsKey("clicked")){
                          model.clicked = childMap["clicked"].toString();
                        }
                        if(childMap.containsKey("fcmToken")){
                          model.fcm = childMap["fcmToken"].toString();
                        }



                      });


                    }


                    listUser.add(model);
                    print("length "+listUser.length.toString()+"");

                  });
              }
              return ListView.separated(
                itemCount: listUser.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Color(0xff707070),
                  );
                },

                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () =>
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>
                            ChatScreen(name: listUser[index].name,
                                image: listUser[index].image,
                                receiverId: listUser[index].id,
                                senderId: id,fcm: listUser[index].fcm))),
                    leading: listUser[index].image==null? CircleAvatar(
                        backgroundImage: AssetImage('assets/img1.png'))
                        :listUser[index].image.toString()=="null"?CircleAvatar(
                      backgroundImage: AssetImage('assets/img1.png'),

                    ):CircleAvatar(backgroundImage: NetworkImage(listUser[index].image.toString() )),
                    title: Text(
                      listUser == null ? "" : listUser[index].name.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000)),
                    ),
                    subtitle: Text(
                      listUser == null ? "" : listUser[index].message == null
                          ? ""
                          : listUser[index].message.toString(),
                      style: TextStyle(fontSize: listUser[index].clicked != null &&  listUser[index].clicked == "true"?12:16, color:  listUser[index].clicked != null &&  listUser[index].clicked == "true"?Color(0xff818181):Colors.black,
                          fontWeight:listUser[index].clicked != null &&  listUser[index].clicked == "true"?FontWeight.normal:FontWeight.bold ),
                    ),
                  );
                },
              );
            }

      }):Text("Please Login again"));
*/



    id!=null?StreamBuilder<QuerySnapshot>(
          stream: firestoreInstance
              .collection("chat_master")
              .doc("chat_head")
              .collection(id)
              .snapshots(),
          builder:(BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              listUser.clear();
              snapshot.data?.docs.forEach((element) {

                var json;
                json = element.data();
                if(widget.typeList=="user") {
                  if (json["chatType"].toString() == "user-admin") {
                    UserList model = new UserList();
                    model.id = element.id.toString();

                    print("StreamId "+element.id);

                    print("StreamName " + json["user"].toString());
                    print("StreamImage " + element.get("image").toString());
                    model.name = json["user"].toString();
                    model.image = json["image"].toString();
                    model.message = json["msg"].toString();
                    model.clicked = json["clicked"].toString();
                    model.fcm = json["fcmToken"].toString();

                    listUser.add(model);
                  }
                }else {
                  if (json["chatType"].toString() == "agent-admin") {
                    UserList model = new UserList();
                    model.id = element.id.toString();

                    print("StreamId "+element.id);

                    print("StreamName " + json["user"].toString());
                    print("StreamImage " + element.get("image").toString());
                    model.name = json["agent"].toString();
                    model.image = json["image"].toString();
                    model.message = json["msg"].toString();
                    model.clicked = json["clicked"].toString();
                    model.fcm = json["fcmToken"].toString();

                    listUser.add(model);
                  }
                }

              });
            }
            return ListView.separated(
              itemCount: listUser.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Color(0xff707070),
                );
              },

              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () =>
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                          ChatScreen(name: listUser[index].name,
                            image: listUser[index].image,
                            receiverId: listUser[index].id,
                            senderId: id,fcm: listUser[index].fcm, userType: widget.typeList,))),
                  leading: listUser[index].image==null? CircleAvatar(
                    backgroundImage: AssetImage('assets/img1.png'))
                          :listUser[index].image.toString()=="null"?CircleAvatar(
                    backgroundImage: AssetImage('assets/img1.png'),

                  ):CircleAvatar(backgroundImage: NetworkImage(listUser[index].image.toString() )),
                  title: Text(
                    listUser == null ? "" : listUser[index].name.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000)),
                  ),
                  subtitle: Text(
                    listUser == null ? "" : listUser[index].message == null
                        ? ""
                        : listUser[index].message.toString(),
                    style: TextStyle(fontSize: listUser[index].clicked != null &&  listUser[index].clicked == "true"?12:16, color:  listUser[index].clicked != null &&  listUser[index].clicked == "true"?Color(0xff818181):Colors.black,
                    fontWeight:listUser[index].clicked != null &&  listUser[index].clicked == "true"?FontWeight.normal:FontWeight.bold ),
                  ),
                );
              },
            );

          }
      ):Text("No Data Found"),
    );






  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id");
    setState(() {

    });
    /* firestoreInstance.collection("chat_master").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        firestoreInstance
            .collection("chat_master")
            .doc(result.id)
            .collection(id.toString())
            .get()
            .then((querySnapshot) {
              querySnapshot.docs.forEach((element) {
                UserList model = new UserList();
                model.id = element.id.toString();
                model.name = element.data()["user"].toString();
                model.image = element.data()["image"].toString();
                model.message = element.data()["msg"].toString();
                print("Id "+element.id);
                print("DataName "+element.data()["user"].toString());
                print("DataImage "+element.data()["image"].toString());

                //print("Name "+element.id);
                listUser.add(model);
              });
              setState(() {

              });
          *//*  listUsers.clear();
            listUsers.addAll(snapshot!.data!.docs);
            print("LengthofList "+listUsers.length.toString()+"");
           *//*   *//*querySnapshot.docs.forEach((result) {
            print(result.data());
          });*//*
        });
      });
    });*/

  }

}


class UserList{
  String? name;
  String? id;
  String? image;
  String? message;
  String? clicked;
  String? fcm;
  String? timeStamp;
}
