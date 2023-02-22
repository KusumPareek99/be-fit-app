import 'package:be_fit_app/screens/profile/edit_profile.dart';
import 'package:be_fit_app/screens/profile/widget/profile_widget.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/const.dart';



class ProfilePage extends StatefulWidget {
  final String email;
  const ProfilePage({Key? key, required this.email}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

    // AuthController authController = Get.find<AuthController>();

    static var arr = AuthController.instance.auth.currentUser!.providerData;
    static bool isProviderGoogle = arr[0].providerId == 'google.com' ? true : false;
  int selectedIconIndex = 2;

  

  @override
  Widget build(BuildContext context) {

    var arr = AuthController.instance.auth.currentUser!.providerData ;
   
    String provider = arr[0].providerId;
  
    bool isProviderGoogle = provider=='google.com' ? true : false ;

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
   
    return Scaffold(
      body: Center(
      
         child:  Column(
          children: [
            
           
           Padding(
             padding: const EdgeInsets.only(top:20.0),
             child: ProfileWidget(
               // imagePath:isProviderGoogle ? AuthController.instance.auth.currentUser!.photoURL! :  'assets/images/app_logo.png',
                onClicked: () async {
                 // Get.off(EditProfilePage());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfilePage()),
                  );
                  print("Edit Profile Page");
                },
              ),
           ),
            SizedBox(
                height: h*0.02,
              ),
              Text( isProviderGoogle ? "Welcome, ${AuthController.instance.auth.currentUser!.displayName!}" : "Welcome, ${AuthController.instance.auth.currentUser!.email!.substring(0, AuthController.instance.auth.currentUser!.email!.indexOf('@')).capitalizeFirst!}" ,
              style:  TextStyle(color: Color(0xFFE18335), fontWeight: FontWeight.w500,fontSize: 22),
              ),
         
              SizedBox(
                height: h*0.2,
              ),
             const Text("Hope you are enjoying our app !" , style: TextStyle(fontSize: 25), textAlign: TextAlign.center,),
              SizedBox(
                height: h*0.2,
              ),
               ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 82,
                    vertical: 13,
                  ),
                ),
                child: const Text(
                  'Log Out',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: white),
                ),
                onPressed: () {
                   AuthController.instance.logOut();
               
                },
              ),
            // GestureDetector(
            //   onTap:(){
            //      AuthController.instance.logOut();
                
            //   } ,
            //   child: Center(
            //     child: Container(
            //       width: w * 0.62,
            //       height: h * 0.08,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           image: const DecorationImage(
            //               image: AssetImage("assets/images/loginbtn.png"),
            //               fit: BoxFit.cover)),
            //       child: const Center(
            //         child: Text(
            //           "LOG OUT",
            //           style: TextStyle(
            //             fontSize: 20,
            //             color: Colors.white,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
         
          ],
          )
    
         // )) 
           ),
          );
  }
}
