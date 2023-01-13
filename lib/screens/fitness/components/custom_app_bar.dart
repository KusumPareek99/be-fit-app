
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  late String email;
  @override
  Widget build(BuildContext context) {

   // Size size = MediaQuery.of(context).size;

    return  Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                  size: 30,
                ),
              )
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