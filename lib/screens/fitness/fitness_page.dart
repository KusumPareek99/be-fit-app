// ignore_for_file: must_be_immutable

import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/screens/fitness/components/courses.dart';
import 'package:be_fit_app/screens/fitness/components/diff_styles.dart';

import 'package:be_fit_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';


class FitnessPage extends StatefulWidget {
  String email;
  FitnessPage({Key? key, required this.email}) : super(key: key);

  @override
  State<FitnessPage> createState() => _FitnessPageState();
}

class _FitnessPageState extends State<FitnessPage> {
  int selectedIconIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(top: appPadding * 1.4),
        child: Column(
          children: [
            
            DiffStyles(),
            Courses(),
        
          ],
        ),
      ),
      
    );
  }
}
