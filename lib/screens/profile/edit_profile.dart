import 'dart:io';

import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/controller/profile_controller.dart';
import 'package:be_fit_app/model/user_model.dart';
import 'package:be_fit_app/screens/profile/widget/profile_widget.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum Gender { MALE, FEMALE }

class EditProfilePage extends StatefulWidget {
 // final UserModel usermodel;
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Gender? _gender;

  static var arr = AuthController.instance.auth.currentUser!.providerData;
  static bool isProviderGoogle =
      arr[0].providerId == 'google.com' ? true : false;

  // controllers

              TextEditingController namecontroller =TextEditingController();
              TextEditingController heightcontroller = TextEditingController();
              TextEditingController weightcontroller = TextEditingController();
              TextEditingController dateController = TextEditingController();
              String newimgpath = '';

  @override
  void initState() {
    super.initState();
    _gender = Gender.MALE;
  }

Stream<QuerySnapshot> userDetails() => FirebaseFirestore.instance
                .collection('users')
                .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
                .snapshots();
             

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
 
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: StreamBuilder(
        stream: userDetails(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Something went wrong ${snapshot.error}'),
            );
          } else if(snapshot.hasData){
           var user = snapshot.data!.docs[0].data() as Map;

            print(user['Email']);
                  return Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: appPadding * 1.4),
                      child: Column(
                        children: [
                          CustomAppBar(),
                        ],
                      )),
                  ProfileWidget(
                    imagePath: isProviderGoogle
                        ? AuthController.instance.auth.currentUser!.photoURL!
                        : 'assets/images/app_logo.png',
                    isEdit: true,
                    onClicked: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image == null) return;

                      final directory =
                          await getApplicationDocumentsDirectory();
                      final name = basename(image.path);
                      final imageFile = File('${directory.path}/$name');
                      final newImage =
                          await File(image.path).copy(imageFile.path);
                          newimgpath = newImage.path;
                      //  setState(() => user = user.copy(imagePath: newImage.path));
                    },
                  ),
                  SizedBox(height: h * 0.02),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: 
                      namecontroller..text = user['UserName'],
                      onChanged: (value) {
                      
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: black,
                        ),
                        labelText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 5.0),
                    child: TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_month_outlined,
                              color: black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: "Enter your DOB"),
                      onChanged: (date) {},
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1940),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat("yyyy-MM-dd").format(pickedDate);

                          setState(() {
                            dateController.text = formattedDate;
                            print(dateController.text);
                          });
                        } else {
                          print("No date selected");
                          return;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      children: [
                        const Flexible(child: Text("Gender : ")),
                        Expanded(
                          child: RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              value: Gender.MALE,
                              groupValue: _gender,
                              title: Text(Gender.MALE.name,
                                  style: const TextStyle(fontSize: 14)),
                              onChanged: (val) {
                                setState(() {
                                  _gender = val;
                                });

                                print(Gender.MALE.name);
                              }),
                        ),
                        Expanded(
                          child: RadioListTile(
                              contentPadding: const EdgeInsets.all(0.0),
                              value: Gender.FEMALE,
                              groupValue: _gender,
                              title: Text(
                                Gender.FEMALE.name,
                                style: const TextStyle(fontSize: 14),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _gender = val;
                                });
                                print(Gender.FEMALE.name);
                              }),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: heightcontroller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.calculate_outlined,
                          color: black,
                        ),
                        labelText: "Height",
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: weightcontroller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.calculate_outlined,
                          color: black,
                        ),
                        labelText: "Weight",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                       keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  GestureDetector(
                    onTap: () async {
                      // update user details in firestore
                      String oldprofile = isProviderGoogle ? AuthController.instance.auth.currentUser!.photoURL! : 'assets/images/app_logo.png';
                      String profile = newimgpath == '' ? oldprofile : newimgpath;
                      final editUserDetails = UserModel(
                        name: namecontroller.text.trim(),
                         email: FirebaseAuth.instance.currentUser!.email!,
                         profileImage: profile ,
                         dob: dateController.text.trim() ,
                        // gender:  ,
                         height: heightcontroller.text.trim(),
                         weight: weightcontroller.text.trim() );

                       await controller.updateRecord(editUserDetails);
                        
                      print("Details Saved");
                    },
                    child: Container(
                      width: w * 0.62,
                      height: h * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/loginbtn.png"),
                              fit: BoxFit.cover)),
                      child: const Center(
                        child: Text(
                          "Save Details",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
    
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
        ),
    ));
  }
}

/*
import 'dart:io';

import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/screens/profile/widget/profile_widget.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/widgets/app_bar.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatelessWidget{
  
  const EditProfilePage({Key? key}) : super(key:key);
    static var arr = AuthController.instance.auth.currentUser!.providerData;
  static bool isProviderGoogle =
      arr[0].providerId == 'google.com' ? true : false;

  @override
  Widget build(BuildContext context) {
return  Scaffold(
  body: SingleChildScrollView(
    child: Center(
      child: Column(
        children: [
            Padding(
                padding: EdgeInsets.only(top: appPadding * 2),
                child: Column(
                  children: [
                    CustomAppBar(),                    
                  ],                 
                ),
              ),
           Stack(
            children: [
              ProfileWidget(
              imagePath: isProviderGoogle
                  ? AuthController.instance.auth.currentUser!.photoURL!
                  : 'assets/images/app_logo.png',
              isEdit: true,
              onClicked: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image == null) return;
      
                final directory = await getApplicationDocumentsDirectory();
                final name = basename(image.path);
                final imageFile = File('${directory.path}/$name');
                final newImage = await File(image.path).copy(imageFile.path);
              },
            ),
            ],
           )   
          ,Form(child: Padding(
            padding: const EdgeInsets.only(left:12.0,right: 12.0,top: 10.0),
            child: Column(
              
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text("Full Name"),
                    prefixIcon: Icon(Icons.person_outline_rounded)
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    ),
  ),
);
  }


}
*/