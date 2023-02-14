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
          margin: const EdgeInsets.only(top:16.0),
          padding: const EdgeInsets.all(10.0),
          height:h * 0.15,
          child: GestureDetector(
      onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyStepCounter()));
          },
      child: Card(
        shadowColor: Colors.black,
            child: Center(
              child: ListTile(
          
          leading:  Transform.rotate( angle: 80,
            child: const FaIcon(FontAwesomeIcons.shoePrints, color: black,)),
          title: const Text("Step Counter Page"), 
          subtitle: Obx(() => Text("${c.steps.value}")),
          trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
          ),
        ),
            ),
      ),
    ),
        ),
        
        Container(
          margin: const EdgeInsets.only(top:10.0),
          padding: const EdgeInsets.all(8.0),
          height:h * 0.15,
          child: activityList("Water Reminder",(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const WaterReminder()));
          },const FaIcon(FontAwesomeIcons.glassWhiskey,color: black,),const Icon(
              Icons.add,
              color: Colors.black,
          )),
        ),

        Container(
          margin: const EdgeInsets.only(top:10.0),
          padding: const EdgeInsets.all(8.0),
          height:h * 0.15,
          child: activityList("Sleep Tracker",(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyStepCounter()));
          },const FaIcon(FontAwesomeIcons.calendarDay,color:black),const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
          )),
        ),

        Container(
          margin: const EdgeInsets.only(top:10.0),
          padding: const EdgeInsets.all(8.0),
          height:h * 0.15,
          child: activityList("Nutrition Tracker",(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchFood()));
          },const FaIcon(FontAwesomeIcons.fire,color: black,),const Icon(
              Icons.add,
              color: Colors.black,
          )),
        ),
      ],
    );
  }

  GestureDetector activityList(String activityName,Function()? onTap,FaIcon? icon,Icon trailIcon) {
    
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shadowColor: Colors.black,
            child: Center(
              child: ListTile(
          
          leading: icon,
          title: Text(activityName),
          subtitle: const Text('0'),
          trailing: trailIcon,
        ),
            ),
      ),
    );
  }
}

