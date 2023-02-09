import 'package:be_fit_app/screens/curved_nav_bar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:be_fit_app/screens/login_screen.dart';


class AuthController extends GetxController {
// for google sign in
  signInWithGoogle() async{
    // begin the interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,idToken: gAuth.idToken
    );

    // finally, let's sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static AuthController instance = Get.find();
  late final Rx<User?> _user;
  // email,password,name etc in user
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    // our user/app will be notified if he logs in logout etc
    _user.bindStream(auth.userChanges());

    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) async {
   
 
   if(user == null){
      print('login page');
      Get.offAll(() => LoginPage());
    } 
    else {
      print("welcome screen");
      Get.offAll(() => CurvedNavBar());
    }
  }


// helper function that will be called from sign up
  Future<bool> register(String email, password) async {
   
    try {
      
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      print("Successful sign up");
      return true;
    } catch (e) {
      Get.snackbar("About user", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Account creation failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ));
          print("Failed signup");
          return false;
    }
  }
   void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Logging in", "Successful login",
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Success",
            style: TextStyle(color: Colors.white),
          ),);
          print("Login success");
    } catch (e) {
      Get.snackbar("About login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Log in failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ));
          print("login failed");
    }
  }
  void logOut() async{
    await auth.signOut();
    print("Logged out successfully");
  }
}
