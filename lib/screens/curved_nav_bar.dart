import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/screens/fitness/fitness_page.dart';
import 'package:be_fit_app/screens/home/home_page.dart';
import 'package:be_fit_app/screens/profile/profile_page.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CurvedNavBar extends StatefulWidget {
  const CurvedNavBar({super.key});

  @override
  State<CurvedNavBar> createState() => _CurvedNavBarState();
}

class _CurvedNavBarState extends State<CurvedNavBar> {

   int selectedIconIndex = 0;

  final screens =  [
  HomePage(email: AuthController.instance.auth.currentUser!.email!),
  FitnessPage(email:AuthController.instance.auth.currentUser!.email!),
  ProfilePage(email: AuthController.instance.auth.currentUser!.email!)
 ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIconIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0x00000000),
        index: selectedIconIndex,
        buttonBackgroundColor: primary,
        height: 60.0,
        color: white,
        onTap: (index) {
          setState(() {
            selectedIconIndex = index;
    });
          
              
        },
       
        animationDuration: const Duration(
          milliseconds: 300,
        ),
        items: <Widget>[
          Icon(
            Icons.home_outlined,
            size: 30,
            color: selectedIconIndex == 0 ? white : black,
          ),
          Icon(
            Icons.play_arrow_outlined,
            size: 30,
            color: selectedIconIndex == 1 ? white : black,
          ),
          Icon(
            Icons.person_outline,
            size: 30,
            color: selectedIconIndex == 2 ? white : black,
          ),
        ],
      ),
    );
  }
}

