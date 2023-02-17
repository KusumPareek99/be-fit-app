import 'package:be_fit_app/constants/const.dart';

import 'package:be_fit_app/screens/home/widget/activity_list.dart';

import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/service/local_notification_service.dart';
import 'package:be_fit_app/widgets/custom_appbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String email;
  const HomePage({Key? key, required this.email}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState(){
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");

          // To redirect to particular screen on clicking the notiifcation
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

     // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
           LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

  }

  int selectedIconIndex = 0;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: appPadding * 2),
        child: Column(
          children: [
            CustomAppBar(),
            ActivityList(),
          //   GestureDetector(
          //     onTap: () {
          //       AuthController.instance.logOut();
          //     },
          //     child: Center(
          //       child: Container(
          //         width: w * 0.62,
          //         height: h * 0.08,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(30),
          //             image: const DecorationImage(
          //                 image: AssetImage("assets/images/loginbtn.png"),
          //                 fit: BoxFit.cover)),
          //         child: const Center(
          //           child: Text(
          //             "LOG OUT",
          //             style: TextStyle(
          //               fontSize: 20,
          //               color: Colors.white,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
           ],
        ),
      ),
    );
  }
}
