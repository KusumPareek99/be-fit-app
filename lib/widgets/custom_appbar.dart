
import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget {
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(appPadding / 8),
                child: Container(
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
                ),
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              Text(
                isProviderGoogle ?  AuthController.instance.auth.currentUser!.displayName! : AuthController.instance.auth.currentUser!.email!.substring(0, AuthController.instance.auth.currentUser!.email!.indexOf('@')),
                style: const TextStyle(color: black, fontWeight: FontWeight.w600,fontSize: 15),
              ),
            ],
          ),

          GestureDetector(
            onTap: () {
              // call function to view menu bar with options like [help,settings,about]
            },
            child: const Icon(
              Icons.menu_rounded,
              size: 30.0,
            ),
          )
        ],
      ),
    );
  }
}
