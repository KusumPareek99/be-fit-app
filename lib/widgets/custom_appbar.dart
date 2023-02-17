
import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/screens/profile/profile_page.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomAppBar extends StatefulWidget {

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
   AuthController authController = Get.find<AuthController>();
  @override
  void initState() {
    
    super.initState();
    authController.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    var arr = AuthController.instance.auth.currentUser!.providerData ;
    print(arr[0].providerId);
    String provider = arr[0].providerId;
    print(provider);
    bool isProviderGoogle = provider=='google.com' ? true : false ;
    Size size = MediaQuery.of(context).size;

    return  Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(email: FirebaseAuth.instance.currentUser!.email!) ));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(appPadding / 8),
                  child: Obx( (() => authController.myUser.value.profileImage == null 
                  ?  Container(
                    decoration: const BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(appPadding / 20),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(appPadding / 8),
                          child: Center(
                            child: CircleAvatar(
                              backgroundImage:isProviderGoogle ? NetworkImage(AuthController.instance.auth.currentUser!.photoURL!) :   const AssetImage('assets/images/app_logo.png') as ImageProvider, 
                             
                              
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                :  Container(
                    decoration: const BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(appPadding / 20),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(appPadding / 8),
                          child: Center(
                            child: CircleAvatar(
                              backgroundImage:NetworkImage(authController.myUser.value.profileImage!), 
                             
                              
                            ),
                          ),
                        ),
                      ),
                    ),
                )
             
                  ))
                     ),
                SizedBox(
                  width: size.width * 0.01,
                ),
                Text(
                  isProviderGoogle ? "Welcome, ${AuthController.instance.auth.currentUser!.displayName!.capitalizeFirst}" : "Welcome, ${AuthController.instance.auth.currentUser!.email!.substring(0, AuthController.instance.auth.currentUser!.email!.indexOf('@'))}",
                  style: const TextStyle(color: black, fontWeight: FontWeight.w600,fontSize: 15),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              // call function to view menu bar with options like [help,settings,about]
              AuthController.instance.logOut();
            },
            child: const Icon(
              Icons.logout,
              size: 30.0,
            ),
          )
        ],
      ),
    );
  }
}
