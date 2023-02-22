
import 'package:be_fit_app/constants/const.dart';

import '../../../widgets/app_bar.dart';
import 'package:flutter/material.dart';


class BmiPage extends StatelessWidget {
  const  BmiPage({super.key});

  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor: white,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(top: appPadding * 1.4),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             CustomAppBar(),
               SizedBox(
                height: size.height*0.1,
             ),
             Text("BMI Chart",  style:  TextStyle(color: Color(0xFFE18335), fontSize: 30)),
             SizedBox(
                height: size.height*0.2,
             ),
             const Image(
              image:
              NetworkImage('https://cdn.britannica.com/30/73630-004-0FFB5466/Height-weight-chart-Body-Mass-Index.jpg?w=400&h=320')
              )
                ],
        ) ,
        )

    );
  }
}