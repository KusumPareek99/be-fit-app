import 'package:be_fit_app/constants/const.dart';

import 'package:be_fit_app/screens/home/widget/activity_list.dart';

import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/widgets/custom_appbar.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String email;
  const HomePage({Key? key, required this.email}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            GestureDetector(
              onTap: () {
                AuthController.instance.logOut();
              },
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
