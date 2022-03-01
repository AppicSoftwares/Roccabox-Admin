import 'dart:collection';
import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:roccabox_admin/agora/audioCall/IncomingCalllocalnotification.dart';
import 'package:roccabox_admin/screens/homenave.dart';
import 'package:roccabox_admin/screens/notifications.dart';
import 'package:roccabox_admin/screens/splash.dart';
import 'package:roccabox_admin/services/provider.dart';
import 'package:roccabox_admin/services/receivedNotification.dart';
import 'package:roccabox_admin/theme/theme.dart';
import 'package:select_dialog/rxdart/behavior_subject.dart';
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
var notificationType;
late CallModel model;
int? _remoteUid;
late RtcEngine _engine;
bool _joined = false;
FirebaseMessaging? messaging;
var totalAgent = 0;
var totalUser = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin
= FlutterLocalNotificationsPlugin();
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
BehaviorSubject<ReceivedNotification>();
final BehaviorSubject<String?> selectNotificationSubject =
BehaviorSubject<String?>();

final BehaviorSubject<CallModel> callSubject =
BehaviorSubject<CallModel>();

MethodChannel platform = MethodChannel('user_channel');

String? selectedNotificationPayload;

var authToken;
Map<String, String> mapheaders = new HashMap();
bool isPressed = false;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


  final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = RoccoBoxAdminApp.routeName;
  String? asas  = notificationAppLaunchDetails?.didNotificationLaunchApp.toString();
  print("assa "+asas.toString());
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload = notificationAppLaunchDetails!.payload;
    if(selectedNotificationPayload!=null) {
      if (selectedNotificationPayload!.contains("VOICE_SCREEN") ||
          selectedNotificationPayload!.contains("VIDEO_SCREEN")) {
        initialRoute = "/incoming_call";
      } else {
        initialRoute = "/notification";
      }
    }else{
      initialRoute = RoccoBoxAdminApp.routeName;
    }

  }

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');


  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: false,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
          ) async {
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      });

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectedNotificationPayload = payload;
        selectNotificationSubject.add(payload);

      });
  if(Platform.isIOS) {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: false,
        badge: false,
        sound: false
    );
  }else{
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: false,
        sound: true
    );
  }

  FirebaseMessaging.onBackgroundMessage(backgroundMessagehandler);


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
    ],
    child: Sizer(
        builder: (context, orientation, deviceType) {
  return MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: initialRoute,
  routes: {
  '/notification': (context) => Notifications(),
  RoccoBoxAdminApp.routeName: (context) => RoccoBoxAdminApp(notificationAppLaunchDetails),
  '/incoming_call': (context) => IncomingCall(payload:notificationAppLaunchDetails!.payload)
  },
  );
  },
  ),));
}

Future<void> backgroundMessagehandler(RemoteMessage message) async {
  await Firebase.initializeApp();


  Map<String, dynamic>map = message.data;

  print("MapBackground "+map.toString());
  screeen = map["screen"];


//recentcode......
  if(screeen=="VIDEO_SCREEN"|| screeen == "VOICE_SCREEN"){
    FlutterRingtonePlayer.playRingtone(looping: true);
    Future.delayed(Duration(seconds: 10), () async{
      FlutterRingtonePlayer.stop();


    });

    Future.delayed(Duration(seconds: 15), () async{
      await flutterLocalNotificationsPlugin.cancelAll();
      FlutterRingtonePlayer.stop();

    });


    _showNotification(message);

  }else{
    print("background msg show");


    _showNotification(message);

    print("background map save");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? titleList = preferences.getStringList('titleList');
    List<String>? bodyList = preferences.getStringList('bodyList');
    List<String>? isReadList = preferences.getStringList('isRead');
    List<String>? idList = preferences.getStringList('idList');
    List<String>? screenList = preferences.getStringList('screenList');
    List<String>? imageList = preferences.getStringList('imageList');

    // List<String> timeList = preferences.getStringList('timeList');
    if(titleList!=null && bodyList!=null && isReadList!=null && screenList!=null && idList!=null && imageList!=null
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
      //  preferences.setStringList("timeList", timeList);
      preferences.commit();
    }else{
      List<String> titleListNew = [];
      List<String> bodyListNew = [];
      List<String> isReadListNew = [];
      List<String> idList = [];
      List<String> screenList = [];
      List<String> imageList = [];

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
      isReadListNew.add("false");

      preferences.setStringList("titleList", titleListNew);
      preferences.setStringList("bodyList", bodyListNew);
      preferences.setStringList("isRead", isReadListNew);
      preferences.setStringList("imageList", imageList);
      preferences.setStringList("idList", idList);
      preferences.setStringList("screenList", screenList);
      preferences.commit();

    }
  }

  //yha tak.........
/*
  const AndroidNotificationDetails androidSpecifics = AndroidNotificationDetails(
      "channel_id", "channel_name", "Test bed for all dem notifications",
      importance: Importance.max, priority: Priority.max, fullScreenIntent: true, showWhen: true);
  const NotificationDetails platformSpecifics = NotificationDetails(android: androidSpecifics);

  await Firebase.initializeApp();
  if(message.notification!=null) {
    print("dataaFirst "+message.data.toString());
    Map<String, dynamic>map = message.data;
    if(map.containsKey("screen")){
      print("Map "+map.toString());

      if (map["screen"] == "VIDEO_SCREEN" || map['screen'] == "VOICE_SCREEN") {
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

      }
    }

  }
*/

}


Future<void> _showNotification(RemoteMessage message) async {

  if(message.data!=null) {
    print("DataPayload "+message.data.toString());
    if (message.data.containsKey("screen")) {
      if (message.data["screen"] == "VOICE_SCREEN" ||
          message.data["screen"] == "VIDEO_SCREEN") {
        FirebaseFirestore.instance.collection('call_master')
            .doc('call_head').collection(message.data['sender_id']).doc(
            message.data['time'])
            .snapshots()
            .listen((DocumentSnapshot querySnapshot) {
          print("Snapshot " + querySnapshot.get('status'));
          if (querySnapshot.get('status') == "end") {
            FlutterRingtonePlayer.stop();
            //flutterLocalNotificationsPlugin.cancelAll();
          }
        });
      }
    }

    Map<String, dynamic> map = message.data;
    if (map.containsKey("screen")) {
      if (map["screen"] == "VOICE_SCREEN" || map["screen"] == "VIDEO_SCREEN") {
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            '10',
            'admin_channel',
            channelDescription: 'Agent channel',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            enableLights: true,
            enableVibration: true,
            playSound: true,
            fullScreenIntent: true,
            autoCancel: false,
            timeoutAfter: 15000
        );
        const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          10,
          message.notification!.title,
          message.notification!.body,
          platformChannelSpecifics,
          payload: message.data.toString(),
        );
      } else {
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          '10',
          'admin_channel',
          channelDescription: 'Agent channel',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          enableLights: true,
          enableVibration: true,
          playSound: true,
        );
        const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          10,
          message.notification!.title,
          message.notification!.body,
          platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    }
  }else{
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      '10',
      'admin_channel',
      channelDescription: 'Agent channel',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      enableLights: true,
      enableVibration: true,
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        10,
        message.notification!.title,
        message.notification!.body,
        platformChannelSpecifics);
  }



}



class RoccoBoxAdminApp extends StatefulWidget {
  static const String routeName = '/';
  RoccoBoxAdminApp(
      this.notificationAppLaunchDetails, {
        Key? key,
      }) : super(key: key);
  final NotificationAppLaunchDetails? notificationAppLaunchDetails;

  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  @override
  State<RoccoBoxAdminApp> createState() => _RoccoBoxAdminAppState();
}

class _RoccoBoxAdminAppState extends State<RoccoBoxAdminApp> {

  var initialRoute = "/splash";
  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    getNotify();


    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Running On Message');
      print('CurrentInstance '+currentInstance.toString()+"");
      //_showNotification(message);

      Map<String, dynamic>map;
      if(message.notification==null){
        if(message.data!=null){

          map = message.data;

          //  print("Message "+map["title"]);
          //print("id "+map["id"]);
          if (map["screen"] == "VIDEO_SCREEN" || map['screen']=="VOICE_SCREEN") {
            Future.delayed(Duration(seconds: 15), () async{
              await flutterLocalNotificationsPlugin.cancelAll();

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
            if (chatUser == "") {
              createListMap(map);
              const AndroidNotificationDetails androidPlatformChannelSpecifics =
              AndroidNotificationDetails(
                '10',
                'admin_channel',
                channelDescription: 'Admin channel',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
                enableLights: true,
                enableVibration: true,
                playSound: true,
              );
              const NotificationDetails platformChannelSpecifics =
              NotificationDetails(android: androidPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.show(
                  10,
                  message.notification!.title,
                  message.notification!.body,
                  platformChannelSpecifics,
                  payload: message.data.toString()
              );
            } else if (chatUser != map["senderid"]) {
              createListMap(map);
              const AndroidNotificationDetails androidPlatformChannelSpecifics =
              AndroidNotificationDetails(
                '10',
                'admin_channel',
                channelDescription: 'Agent channel',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
                enableLights: true,
                enableVibration: true,
                playSound: true,
              );
              const NotificationDetails platformChannelSpecifics =
              NotificationDetails(android: androidPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.show(
                  10,
                  message.notification!.title,
                  message.notification!.body,
                  platformChannelSpecifics,
                  payload: message.data.toString()
              );
            }else{
              print("cond3");
              await flutterLocalNotificationsPlugin.cancelAll();

            }
          }
        }


      }else {
        RemoteNotification? notification  = message.notification;

        AndroidNotification? android = message.notification?.android;

        if (notification != null) {
          Map<String, dynamic>map = new Map();
          var screen = "";
          if(message.data!=null){

            map = message.data;
            screen = map["screen"];
            print("Screennnnn "+map.toString());
          }
          if (map["screen"] == "VIDEO_SCREEN" || map['screen']=="VOICE_SCREEN") {
            Future.delayed(Duration(seconds: 15), () async{
              await flutterLocalNotificationsPlugin.cancelAll();

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
            print("Else pasrt");
            if (chatUser=="") {
              createListMap(map);
              const AndroidNotificationDetails androidPlatformChannelSpecifics =
              AndroidNotificationDetails(
                '10',
                'admin_channel',
                channelDescription: 'Agent channel',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
                enableLights: true,
                enableVibration: true,
                playSound: true,
              );
              const NotificationDetails platformChannelSpecifics =
              NotificationDetails(android: androidPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.show(
                  10,
                  message.notification!.title,
                  message.notification!.body,
                  platformChannelSpecifics,
                  payload: message.data.toString()
              );
            } else if (chatUser != map["senderid"]) {
              print("Else pasrt1");

              createListMap(map);
              const AndroidNotificationDetails androidPlatformChannelSpecifics =
              AndroidNotificationDetails(
                '10',
                'admin_channel',
                channelDescription: 'Agent channel',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
                enableLights: true,
                enableVibration: true,
                playSound: true,
              );
              const NotificationDetails platformChannelSpecifics =
              NotificationDetails(android: androidPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.show(
                  10,
                  message.notification!.title,
                  message.notification!.body,
                  platformChannelSpecifics,
                  payload: message.data.toString()
              );
            }else{
              print("cond4");
              await flutterLocalNotificationsPlugin.cancelAll();

            }
          }
        }
      }
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new on message openedApp event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification!.android;


      if(notification!=null) {
        Map<String, dynamic> map = message.data;
        if (message.data != null) {
          map = message.data;
          if (map['screen'] == "VIDEO_SCREEN" ||
              map['screen'] == "VOICE_SCREEN") {
            Future.delayed(Duration(seconds: 15), () async {
              await flutterLocalNotificationsPlugin.cancelAll();
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
            createListMap(map);
            const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
              '10',
              'admin_channel',
              channelDescription: 'Agent channel',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker',
              enableLights: true,
              enableVibration: true,
              playSound: true,
            );
            const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
            await flutterLocalNotificationsPlugin.show(
                10,
                message.notification!.title,
                message.notification!.body,
                platformChannelSpecifics,
                payload: message.data.toString()
            );

          }
        }

        //    showAlertDialog(context);


      }

    });

    FirebaseMessaging.onBackgroundMessage(backgroundMessagehandler);

  }


  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );


  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      print("listion ios state");
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                print("Clicked true ios");
                Navigator.of(context, rootNavigator: true).pop();
                /* Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        Notifications(),
                  ),
                );*/
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() async{
    await _startForegroundService();
    selectNotificationSubject.stream.listen((String? payload) async {
      print("Payload "+payload.toString()+"");


      if(payload!=null){
        if(payload != ""){

          if(payload.contains("VIDEO")|| payload.contains("VOICE")){
            await Navigator.pushNamed(context, '/call_received');

          }else{
            await Navigator.pushNamed(context, '/notification');

          }

        }
      }else{
        await Navigator.pushNamed(context, '/notification');
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    var count = '${context
        .watch<Counter>()
        .count}';
    print(count);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Roccabox Admin',
          theme: theme(),
          initialRoute: initialRoute,
          routes: {
            '/notification': (context) => Notifications(),
            '/chatscreen': (context) => ChatScreen(),
            '/call_received': (context) => AudioCallWithImage(),
            '/home': (context) => HomeNav(),
            '/splash': (context) => Splash(),
          },
          navigatorKey: navigatorKey,

        );
      },
    );
  }

  Future<void> _startForegroundService() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('10', 'user_channel',
        channelDescription: 'Channel Description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        playSound: true);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.startForegroundService(10, 'Service Started', 'Foregound Service Started',
        notificationDetails: androidPlatformChannelSpecifics,
        payload: 'item x');
  }


  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    FlutterRingtonePlayer.stop();

    super.dispose();
  }
  void getNotify() async {
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
    context.read<Counter>().getNotify();
    print("countsplash " + notificationCount.toString());
    preferences.setString("notify", notificationCount.toString());
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
    if (titleList != null && bodyList != null && isReadList != null &&
        screenList != null && idList != null && imageList != null &&
        chatTypeList != null
    ) {
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
    } else {
      List<String> titleListNew = [];
      List<String> bodyListNew = [];
      List<String> isReadListNew = [];
      List<String> idList = [];
      List<String> screenList = [];
      List<String> imageList = [];
      List<String> chatTypeList = [];

      titleListNew.add(map["title"].toString());
      bodyListNew.add(map["body"].toString());
      if (map.containsKey("id")) {
        idList.add(map["id"].toString());
      } else {
        idList.add("");
      }
      if (map.containsKey("screen")) {
        screenList.add(map["screen"].toString());
      } else {
        screenList.add("");
      }

      if (map.containsKey("image")) {
        imageList.add(map["image"].toString());
      } else {
        imageList.add("");
      }
      if (map.containsKey("chat_type")) {
        chatTypeList.add(map["chat_type"].toString());
      } else {
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

}