import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/controller/step_controller.dart';
import 'package:be_fit_app/model/counter.dart';
import 'package:be_fit_app/screens/home/activities/bmi.dart';
import 'package:be_fit_app/screens/home/activities/search_food.dart';
import 'package:be_fit_app/screens/home/activities/step_count.dart';
import 'package:be_fit_app/screens/home/activities/water_reminder.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityList extends StatefulWidget {
  const ActivityList({super.key});

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    authController.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final StepCounter c = stepCounterController;
    double bmi;
    if (authController.myUser.value.height == null &&
        authController.myUser.value.weight == null) {
      bmi = 0;
    } else {
      double height = double.parse(authController.myUser.value.height!) / 100;
      double weight = double.parse(authController.myUser.value.weight!);
      print("Weight ${weight} Height ${height}");
      bmi = weight / (height * height);
    }

    print("BMI ${bmi.toStringAsFixed(3)}");

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Step Counter card
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            padding: const EdgeInsets.all(10.0),
            height: h * 0.25,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyStepCounter()));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color.fromARGB(192, 83, 12, 95),
                  ),
                  borderRadius: BorderRadius.circular(20.0), 
                ),
                shadowColor: Colors.black,
                color: const Color.fromARGB(192, 83, 12, 95),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromARGB(192, 83, 12, 95),
                    ),
                    borderRadius: BorderRadius.circular(20.0), 
                  ),
                  shadowColor: Colors.black,
                  child: Container(
                    color: const Color.fromARGB(15, 83, 12, 95),
                    width: w * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                            angle: 80,
                            child: const FaIcon(
                              FontAwesomeIcons.shoePrints,
                              color: Color.fromARGB(255, 83, 12, 95),
                              size: 30,
                            )),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        const Text(
                          "Step Count",
                          style: TextStyle(
                              color: primary,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        Obx(() => Text(
                              "${c.steps.value}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 83, 12, 95),
                                  fontSize: 19),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Nutrients check card
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.all(8.0),
            height: h * 0.25,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchFood()));
              },
              child: Card(
                 shape:  RoundedRectangleBorder(
    side: const BorderSide(
      color:Color.fromARGB(192, 83, 12, 95) ,
    ),
    borderRadius: BorderRadius.circular(20.0), 
  ),
                shadowColor: Colors.black,
                color: const Color.fromARGB(192, 83, 12, 95),
                child: Card(
                   shape:  RoundedRectangleBorder(
    side: const BorderSide(
      color:Color.fromARGB(192, 83, 12, 95) ,
    ),
    borderRadius: BorderRadius.circular(20.0), 
  ),
                  shadowColor: Colors.black,
                  child: Container(
                    color: const Color.fromARGB(15, 83, 12, 95),
                    width: w * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.fire,
                          color: Color.fromARGB(255, 83, 12, 95),
                          size: 30,
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        const Text(
                          "Check Nutrients",
                          style: TextStyle(
                              color: primary,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // BMI CARD
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.all(8.0),
            height: h * 0.25,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BmiPage()));
              },
              child: Card(
                 shape:  RoundedRectangleBorder(
    side: const BorderSide(
      color:Color.fromARGB(192, 83, 12, 95) ,
    ),
    borderRadius: BorderRadius.circular(20.0), 
  ),
                shadowColor: Colors.black,
                color: const Color.fromARGB(192, 83, 12, 95),
                child: Card(
                   shape:  RoundedRectangleBorder(
    side: const BorderSide(
      color:Color.fromARGB(192, 83, 12, 95) ,
    ),
    borderRadius: BorderRadius.circular(20.0), 
  ),
                  shadowColor: Colors.black,
                  child: Container(
                    color: const Color.fromARGB(15, 83, 12, 95),
                    width: w * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.weight,
                          color: Color.fromARGB(255, 83, 12, 95),
                          size: 30,
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        const Text(
                          "Your BMI",
                          style: TextStyle(
                              color: primary,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${bmi.toStringAsFixed(2)} kg/m",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 83, 12, 95),
                                fontSize: 19,
                              ),
                            ),
                            const Text(
                              "2",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 83, 12, 95)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
