import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/controller/step_controller.dart';
import 'package:be_fit_app/model/counter.dart';
import 'package:be_fit_app/screens/home/activities/search_food.dart';
import 'package:be_fit_app/screens/home/activities/step_count.dart';
import 'package:be_fit_app/screens/home/activities/water_reminder.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    final StepCounter c = stepCounterController;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16.0),
          padding: const EdgeInsets.all(10.0),
          height: h * 0.3,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyStepCounter()));
            },
            child: Card(
              shadowColor: Colors.black,
              child: Card(
                shadowColor: Colors.black,
                child: Container(
                  color: thirdColor,
                  width: w * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.rotate(
                          angle: 80,
                          child: const FaIcon(
                            FontAwesomeIcons.shoePrints,
                            color: black,
                            size: 30,
                          )),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      const Text(
                        "Step Count",
                        style: TextStyle(color: primary, fontSize: 22),
                      ),
                      Obx(() => Text(
                            "${c.steps.value}",
                            style: const TextStyle(color: black, fontSize: 19),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          padding: const EdgeInsets.all(8.0),
          height: h * 0.3,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchFood()));
            },
            child: Card(
              shadowColor: Colors.black,
              child: Card(
                shadowColor: Colors.black,
                child: Container(
                  color: thirdColor,
                  width: w * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.fire,
                        color: black,
                        size: 30,
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      const Text(
                        "check Nutrients",
                        style: TextStyle(color: primary, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
