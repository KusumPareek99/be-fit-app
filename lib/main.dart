import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/screens/login_screen.dart';
import 'package:be_fit_app/screens/onboarding_screen.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/service/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  	print(message.data.toString());
 	print(message.notification!.title);
	}

int? initScreen;

Future<void> main() async {
// to hide the upper bar of system ui
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: primary,
  ));

 // to bind auth with app
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp().then((value)=> Get.put(AuthController()));

   FirebaseMessaging.onBackgroundMessage(backgroundHandler);
LocalNotificationService.initialize();

SharedPreferences preferences = await SharedPreferences.getInstance();
initScreen = preferences.getInt('initScreen');
await preferences.setInt('initScreen',1);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Be Fit App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       fontFamily: 'Poppins',
       primarySwatch: Colors.orange
        
      ),
     initialRoute: initScreen == 0 || initScreen == null ? 'onboarding' : 'login' ,
      //home: OnboardingPage(),
      routes: {
        'login':(p0) => LoginPage(),
        'onboarding' : (p0) => OnboardingPage(),
      },
    );
  }
}
