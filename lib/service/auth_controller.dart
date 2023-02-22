import 'dart:io';

import 'package:be_fit_app/main.dart';
import 'package:be_fit_app/model/user_model.dart';
import 'package:be_fit_app/screens/curved_nav_bar.dart';
import 'package:be_fit_app/screens/home/home_page.dart';
import 'package:be_fit_app/screens/login_screen.dart';
import 'package:be_fit_app/screens/onboarding_screen.dart';
import 'package:be_fit_app/screens/profile/edit_profile.dart';
import 'package:be_fit_app/screens/profile/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';


class AuthController extends GetxController {
  // for updating image in edit profile
  var isProfileUploading = false.obs;

  // final userRepo = Get.put(UserRepository());
// for google sign in
  signInWithGoogle() async {
    // begin the interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

// create user in firestore
//userRepo.createGoogleUser(credential.accessToken!);
    // finally, let's sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static AuthController instance = Get.find();
  late final Rx<User?> _user;
  // email,password,name etc in user
  final FirebaseAuth auth = FirebaseAuth.instance;

  var isDecided = false;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    // our user/app will be notified if he logs in logout etc
    _user.bindStream(auth.userChanges());

    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) async {
    if(initScreen == null || initScreen==0){
      print("initial screen...redirecting to onboarding page");
      Get.offAll(() => OnboardingPage());
      return;
    }
    
    if(user==null){
      print("initial screen...redirecting to login page");
        Get.offAll(() => LoginPage());
    }else{
      print("initial screen...deciding route ....");
         decideRoute();
    }
   
  }

  
// helper function that will be called from sign up
  Future<bool> register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Successful sign up");
      isDecided = false;
      decideRoute();
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  print('initScreen ${initScreen}');

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        "Logging in",
        "Successful login",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Success",
          style: TextStyle(color: Colors.white),
        ),
      );
  
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

  void logOut() async {
    await auth.signOut();

    print("Logged out successfully");
  }


  decideRoute() {
    print("isDecided $isDecided");
    if (isDecided) {
      return;
    }
    isDecided = true;
    print("called");

    ///step 1- Check user login?
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      /// step 2- Check whether user profile exists?
    
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        if (value.exists) {
          print("decided route...redirecting to profile page");
       
          Get.offAll(() => CurvedNavBar());
        } else {
          print("decided route...redirecting to edit profile page");
          Get.offAll(() => EditProfilePage());
        }
      }).catchError((e) {
        print("Error while decideRoute is $e");
      });
    }
   isDecided=false;
  }

// Firestore queries

  uploadImage(File image) async {
    String imageUrl = '';
    String fileName = Path.basename(image.path);
    var reference = FirebaseStorage.instance
        .ref()
        .child('users/$fileName'); // Modify this path/string as your need
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then(
      (value) {
        imageUrl = value;
        print("Download URL: $value");
      },
    );

    return imageUrl;
  }

  storeUserInfo(File? selectedImage, String name, String dob, String gender,
      String height, String weight,
      {String url = ''}) async {
    String url_new = url;
    if (selectedImage != null) {
      url_new = await uploadImage(selectedImage);
    }
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String email = FirebaseAuth.instance.currentUser!.email!;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'Email': email,
      'ProfileImage': url_new,
      'UserName': name,
      'DOB': dob,
      'Gender': gender,
      'Height': height,
      'Weight': weight,
    }, SetOptions(merge: true)).then((value) {
      isProfileUploading(false);

      Get.to(() => CurvedNavBar());
    });
  }

  var myUser = UserModel().obs;
  getUserInfo() {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    print("uid $uid");

    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots()
          .listen((event) {
        myUser.value = UserModel.fromJson(event.data()!);
      });
      print("User values ${myUser.value.name!} ${myUser.value.email!} ${myUser.value.profileImage!}");
    } catch (e) {
      return "Document not found $e";
    }
  }

    setDailyTarget(double value) {
      if (value.isNaN) return;
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set({'Daily_target': value}, SetOptions(merge: true));
  }
}
