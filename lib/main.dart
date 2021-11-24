import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roccabox_admin/screens/demoNameRoute.dart';
import 'package:roccabox_admin/screens/notifications.dart';
import 'package:roccabox_admin/screens/splash.dart';
import 'package:roccabox_admin/services/provider.dart';
import 'package:roccabox_admin/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import 'ChatModule/chatscreen.dart';
import 'agora/audioCall/audioCallMain.dart';
import 'agora/callModel.dart';

int langCount = 0;
var currentInstance = "";
var chatUser = "";
int notificationCount = 0;
String screeen = "";
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelKey: 'key_admin',
            channelName: 'admin_channel',
            channelDescription: 'Notification channel for admin',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            enableLights: true,
            playSound: true,
            channelShowBadge: true,
            enableVibration: true
        )
      ]
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
    ],
    child: RoccoBoxAdminApp(),
  ),);
}



class RoccoBoxAdminApp extends StatefulWidget {
  @override
  State<RoccoBoxAdminApp> createState() => _RoccoBoxAdminAppState();
}
class _RoccoBoxAdminAppState extends State<RoccoBoxAdminApp> {

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print('Running On Message');
      print('CurrentInstance '+currentInstance.toString()+"");


      Map<String, dynamic>map;
      if(message.notification==null){
        if(message.data!=null){

          map = message.data;
          screeen = map["screen"];
          navigatorKey.currentContext!.read<Counter>().getScreen();

          //  print("Message "+map["title"]);
          //print("id "+map["id"]);
          if (map["screen"] == "VIDEO_SCREEN" || map['screen']=="VOICE_SCREEN") {
            Future.delayed(Duration(seconds: 15), () async{
              AwesomeNotifications().cancelAll();
            });
            navigatorKey.currentState!.pushReplacementNamed('/call_received',
                arguments: CallModel(
                    map["sender_image"],
                    map["channelName"],
                    map["time"],
                    map["type"],
                    map["sender_fcm"],
                    map["sender_id"],
                    map["sender_name"],
                    map["token"]));
          }else {
            if (chatUser == "" || chatUser != map["id"]) {
              createListMap(map);
              AwesomeNotifications().createNotification(
                  content: NotificationContent(
                      id: 10,
                      channelKey: 'key_admin',
                      title: map["title"],
                      body: map["body"]
                  )
              );
            }
          }
        }


      }else {
        RemoteNotification? notification  = message.notification;

        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          Map<String, dynamic>map = new Map();
          var screen = "";

          if(message.data!=null) {
            map = message.data;
            screen = map["screen"];
            print("mapNotification " + map.toString());
            screeen = map["screen"];
            navigatorKey.currentContext!.read<Counter>().getScreen();

            if (screen == "VIDEO_SCREEN" || screen == "VOICE_SCREEN") {
              Future.delayed(Duration(seconds: 15), () async {
                AwesomeNotifications().cancelAll();
              });
              navigatorKey.currentState!.pushReplacementNamed('/call_received',
                  arguments: CallModel(
                      map["sender_image"],
                      map["channelName"],
                      map["time"],
                      map["type"],
                      map["sender_fcm"],
                      map["sender_id"],
                      map["sender_name"],
                      map["token"]));
            } else {
              print("Else pasrt");
              if (chatUser == null || chatUser == "") {
                createListMap(map);
                AwesomeNotifications().createNotification(
                    content: NotificationContent(
                        id: int.parse(map["id"].toString()),
                        channelKey: 'key_admin',
                        title: map["title"],
                        body: map["body"]
                    )
                );
              } else if (chatUser != map["id"]) {
                print("Else pasrt1");

                createListMap(map);

                AwesomeNotifications().createNotification(
                    content: NotificationContent(
                        id: int.parse(map["id"].toString()),
                        channelKey: 'key_admin',
                        title: map["title"],
                        body: map["body"]
                    )
                );
              }
            }
          }else{
            AwesomeNotifications().createNotification(
                content: NotificationContent(
                    id: 101,
                    channelKey:"key_admin",
                    title: map["title"],
                    body: map["body"]
                )
            );
          }
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      print('Running On MessageOpenApp');
      print('CurrentInstance '+currentInstance.toString()+"");


      Map<String, dynamic>map;
      if(message.notification==null){
        if(message.data!=null){

          map = message.data;
          screeen = map["screen"];
          navigatorKey.currentContext!.read<Counter>().getScreen();
          //  print("Message "+map["title"]);
          //print("id "+map["id"]);
          if (map["screen"] == "VIDEO_SCREEN" || map['screen']=="VOICE_SCREEN") {
            Future.delayed(Duration(seconds: 15), () async{
              AwesomeNotifications().cancelAll();
            });
            navigatorKey.currentState!.pushReplacementNamed('/call_received',
                arguments: CallModel(
                    map["sender_image"],
                    map["channelName"],
                    map["time"],
                    map["type"],
                    map["sender_fcm"],
                    map["sender_id"],
                    map["sender_name"],
                    map["token"]));
          }else {
            if (chatUser == "" || chatUser != map["id"]) {
              createListMap(map);
              AwesomeNotifications().createNotification(
                  content: NotificationContent(
                      id: int.parse(map["id"].toString()),
                      channelKey: 'key_admin',
                      title: map["title"],
                      body: map["body"]
                  )
              );
            }
          }
        }


      }else {
        RemoteNotification? notification  = message.notification;

        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          Map<String, dynamic>map = new Map();
          var screen = "";

          if(message.data!=null) {
            map = message.data;
            screen = map["screen"];
            print("mapNotification " + map.toString());
            screeen = map["screen"];
            navigatorKey.currentContext!.read<Counter>().getScreen();

            if (screen == "VIDEO_SCREEN" || screen == "VOICE_SCREEN") {
              Future.delayed(Duration(seconds: 15), () async {
                AwesomeNotifications().cancelAll();
              });
              navigatorKey.currentState!.pushReplacementNamed('/call_received',
                  arguments: CallModel(
                      map["sender_image"],
                      map["channelName"],
                      map["time"],
                      map["type"],
                      map["sender_fcm"],
                      map["sender_id"],
                      map["sender_name"],
                      map["token"]));
            } else {
              print("Else pasrt");
              if (chatUser == null || chatUser == "") {
                createListMap(map);
                AwesomeNotifications().createNotification(
                    content: NotificationContent(
                        id: int.parse(map["id"].toString()),
                        channelKey: 'key_admin',
                        title: map["title"],
                        body: map["body"]
                    )
                );
              } else if (chatUser != map["id"]) {
                print("Else pasrt1");

                createListMap(map);

                AwesomeNotifications().createNotification(
                    content: NotificationContent(
                        id: int.parse(map["id"].toString()),
                        channelKey: 'key_admin',
                        title: map["title"],
                        body: map["body"]
                    )
                );
              }
            }
          }else{
            AwesomeNotifications().createNotification(
                content: NotificationContent(
                    id: 101,
                    channelKey:"key_admin",
                    title: map["title"],
                    body: map["body"]
                )
            );
          }
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    var count  = '${context.watch<Counter>().count}';
    print(count);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Roccabox Admin',
          theme: theme(),
          home: Splash(),
          routes: {
            '/notification': (context)=> Notifications(),
            '/chatscreen': (context)=> ChatScreen(),
            '/call_received':(context)=> AudioCallWithImage(),
            '/example':(context)=> ExampleRoute(),
            '/splash':(context)=> Splash()
          },
     /*     initialRoute: '/splash',
          onGenerateRoute: (setting){

            if(setting.name=='/example'){
              final args = setting.arguments as CallModel;
              return MaterialPageRoute(
                builder: (context) {
                  return ExampleRoute();
                },
              );
            }
          },*/
          navigatorKey: navigatorKey,
        );
      },
    );
  }



  void getNotify() async{
    notificationCount = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var isRead = preferences.getStringList("isRead");
    print("IsRead " + isRead.toString());
    if (isRead != null) {
      if (isRead.isNotEmpty) {
        for (var k = 0; k < isRead.length; k++) {
          print("element " + isRead[k].toString());
          if (isRead[k] == "false") {
            notificationCount++;
          }
        }
      }
    }
    navigatorKey.currentContext!.read<Counter>().getNotify();
    print("countsplash " + notificationCount.toString());
    preferences.setString("notify",notificationCount.toString());
    preferences.commit();

    //   navigatorKey.currentState!.pushReplacementNamed('/notification');
  }


  Future<void> createListMap(Map<String, dynamic> map) async {
    print("ListSaveMap");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? titleList = preferences.getStringList('titleList');
    List<String>? bodyList = preferences.getStringList('bodyList');
    List<String>? isReadList = preferences.getStringList('isRead');
    List<String>? idList = preferences.getStringList('idList');
    List<String>? screenList = preferences.getStringList('screenList');
    List<String>? imageList = preferences.getStringList('imageList');
    List<String>? chatTypeList = preferences.getStringList('chatTypeList');

    // List<String> timeList = preferences.getStringList('timeList');
    if(titleList!=null && bodyList!=null && isReadList!=null && screenList!=null && idList!=null && imageList!=null && chatTypeList!=null
    ){
      titleList.add(map["title"].toString());
      bodyList.add(map["body"].toString());
      isReadList.add("false");
      preferences.setStringList("titleList", titleList);
      preferences.setStringList("bodyList", bodyList);
      preferences.setStringList("isRead", isReadList);
      preferences.setStringList("idList", idList);
      preferences.setStringList("screenList", screenList);
      preferences.setStringList("imageList", imageList);
      preferences.setStringList("chatTypeList", chatTypeList);
      //  preferences.setStringList("timeList", timeList);
      preferences.commit();
    }else{
      List<String> titleListNew = [];
      List<String> bodyListNew = [];
      List<String> isReadListNew = [];
      List<String> idList = [];
      List<String> screenList = [];
      List<String> imageList = [];
      List<String> chatTypeList = [];

      titleListNew.add(map["title"].toString());
      bodyListNew.add(map["body"].toString());
      if(map.containsKey("id")) {
        idList.add(map["id"].toString());
      }else{
        idList.add("");

      }
      if(map.containsKey("screen")) {
        screenList.add(map["screen"].toString());
      }else{
        screenList.add("");

      }

      if(map.containsKey("image")) {
        imageList.add(map["image"].toString());
      }else{
        imageList.add("");

      }
      if(map.containsKey("chat_type")) {
        chatTypeList.add(map["chat_type"].toString());
      }else{
        chatTypeList.add("");

      }
      isReadListNew.add("false");

      preferences.setStringList("titleList", titleListNew);
      preferences.setStringList("bodyList", bodyListNew);
      preferences.setStringList("isRead", isReadListNew);
      preferences.setStringList("imageList", imageList);
      preferences.setStringList("idList", idList);
      preferences.setStringList("screenList", screenList);
      preferences.setStringList("chatTypeList", chatTypeList);
      preferences.commit();
    }


    getNotify();
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Notification " + message.notification.toString() + "");
    print("data " + message.data.toString() + "");
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print('Handling a background message: ${message.messageId}');

    if (
    !StringUtils.isNullOrEmpty(
        message.notification?.title, considerWhiteSpaceAsEmpty: true) ||
        !StringUtils.isNullOrEmpty(
            message.notification?.body, considerWhiteSpaceAsEmpty: true)
    ) {
      print('message also contained a notification: ${message.notification}');

/*    String? imageUrl;
    imageUrl ??= message.notification!.android?.imageUrl;
    imageUrl ??= message.notification!.apple?.imageUrl;

    Map<String, dynamic> notificationAdapter = {
      NOTIFICATION_CHANNEL_KEY: 'basic_channel',
      NOTIFICATION_ID:
      message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_ID] ??
          message.messageId ??
          Random().nextInt(2147483647),
      NOTIFICATION_TITLE:
      message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_TITLE] ??
          message.notification?.title,
      NOTIFICATION_BODY:
      message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_BODY] ??
          message.notification?.body ,
      NOTIFICATION_LAYOUT:
      StringUtils.isNullOrEmpty(imageUrl) ? 'Default' : 'BigPicture',
      NOTIFICATION_BIG_PICTURE: imageUrl
    };*/
      if (message.data != null) {
        Map<String, dynamic> map = message.data;
        print("MapBackground " + map.toString());
        // navigatorKey.currentContext!.read<Counter>().getScreen();
        // navigatorKey.currentState!.pushReplacementNamed('/example');

        if (map['screen'] == "VIDEO_SCREEN" || map['screen'] == "VOICE_SCREEN") {
          AwesomeNotifications().createNotification(content: NotificationContent(
            id: 10,
            channelKey: map["channelKey"],
            title: map["title"],
            body: map["body"],
            notificationLayout: NotificationLayout.Default,),
              actionButtons: [
                NotificationActionButton(key: "REJECT",
                    label: "Reject",
                    color: Colors.red,
                    autoDismissable: false),
                NotificationActionButton(
                    key: "ACCEPT", label: "Accept", color: Colors.green)

              ]);
          AwesomeNotifications().actionStream.listen((notification) {
            print("ActionNotification" + notification.payload.toString());
            if (notification.buttonKeyPressed == "ACCEPT") {
              print("backgroundreceived");

              navigatorKey.currentState!.pushReplacementNamed('/call_received',
                  arguments: CallModel(
                      map["sender_image"],
                      map["channelName"],
                      map["time"],
                      map["type"],
                      map["sender_fcm"],
                      map["sender_id"],
                      map["sender_name"],
                      map["token"]));
            } else {
              AwesomeNotifications().cancelAll();
            }
          });
          Future.delayed(Duration(seconds: 15), () async {
            AwesomeNotifications().cancel(10);
          });
        }else {

          // navigatorKey.currentState!.pushReplacementNamed('/notification');
          AwesomeNotifications().createNotification(
              content: NotificationContent(
                  id: int.parse(map["id"].toString()),
                  channelKey: 'key_admin',
                  title: map["title"],
                  body: map["body"]
              )
          );
          createListMap(map);
        }

        //  AwesomeNotifications().createNotificationFromJsonData(notificationAdapter);
      }
      else {
        AwesomeNotifications().createNotificationFromJsonData(message.data);
      }
    }


  }

}
