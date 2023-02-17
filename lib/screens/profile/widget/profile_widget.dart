
import 'dart:io';

import 'package:be_fit_app/service/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfileWidget extends StatefulWidget {
 // final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
   // required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
 
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    
    super.initState();
    authController.getUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.98,
     
      child: Center(
        child: Stack(children: [
         buildCircle(child: buildProfileTile(widget.onClicked), all: 4, color: Colors.orange),
      
          Positioned(bottom: 0, right: 0, child: buildEditIcon(color)),
        ]),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            widget.isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

///////////////////////
///
/// 
///  NEW WIDGET
 Widget buildProfileTile(Function() ontap) {
 
 
    return GestureDetector(
      onTap: ontap,
      child: Obx(() => authController.myUser.value.email == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          :
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: authController.myUser.value.profileImage == null
                        ? DecorationImage(
                            image: AssetImage('assets/images/app_logo.png') ,
                            fit: BoxFit.fill)
                        : DecorationImage(
                            image: NetworkImage(
                                authController.myUser.value.profileImage!),
                            fit: BoxFit.fill)),
              ),
        
          ),
    );
  }

}


