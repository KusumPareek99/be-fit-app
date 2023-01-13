import 'package:be_fit_app/constants/const.dart';

import 'package:be_fit_app/screens/profile/edit_profile.dart';
import 'package:be_fit_app/screens/profile/widget/profile_widget.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/widgets/app_bar.dart';

import 'package:flutter/material.dart';



class ProfilePage extends StatefulWidget {
  String email;
  ProfilePage({Key? key, required this.email}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    static var arr = AuthController.instance.auth.currentUser!.providerData;
    static bool isProviderGoogle =
      arr[0].providerId == 'google.com' ? true : false;
  int selectedIconIndex = 2;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
   
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: appPadding * 2),
              child: Column(
                children: [
                  CustomAppBar(),
                  
                ],
                
              ),
            ),
           ProfileWidget(
              imagePath:isProviderGoogle ? AuthController.instance.auth.currentUser!.photoURL! :  'assets/images/app_logo.png',
              onClicked: () async {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfilePage()),
                );
                print("Edit Profile Page");
              },
            ),
            GestureDetector(
              onTap:(){
                 AuthController.instance.logOut();
              } ,
              child: Center(
                child: Container(
                  width: w * 0.62,
                  height: h * 0.08,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/loginbtn.png"),
                          fit: BoxFit.cover)),
                  child: const Center(
                    child: Text(
                      "LOG OUT",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
         
          ],
        ),
      ),
          );
  }
}
