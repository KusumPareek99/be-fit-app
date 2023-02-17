import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget {
  late String email;

  CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {

    //Size size = MediaQuery.of(context).size;

    return  Container(
      color: primary,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10,bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
           GestureDetector(
             onTap: () {
               Navigator.pop(context);
             },
             child: const Icon(
               Icons.arrow_back_outlined,
               size: 30,
               color: white,
             ),
           ),
            GestureDetector(
              onTap: () {
                AuthController.instance.logOut();
              },
              child: const Icon(
                Icons.logout,
                size: 30.0,
                color: white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
