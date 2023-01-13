import 'dart:io';

import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/screens/profile/widget/profile_widget.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum Gender { MALE, FEMALE }

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {


  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController heightcontroller = TextEditingController();
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController radiocontroller = TextEditingController();
  TextEditingController dateController = TextEditingController();
   Gender? _gender;

   static var arr = AuthController.instance.auth.currentUser!.providerData;
    static bool isProviderGoogle =
      arr[0].providerId == 'google.com' ? true : false;

  @override
  void initState() {
    super.initState();
    dateController.text = "";
    _gender = Gender.MALE;
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

   

    return Scaffold(
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Center(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: appPadding * 2),
                child: Column(
                  children: [
                    CustomAppBar(),
                  ],
                )),
            ProfileWidget(
              imagePath:isProviderGoogle ? AuthController.instance.auth.currentUser!.photoURL! :  'assets/images/app_logo.png',
              isEdit: true,
              onClicked: () async {
                final image = await ImagePicker().pickImage(source:ImageSource.gallery);
                if (image == null) return;

                    final directory = await getApplicationDocumentsDirectory();
                    final name = basename(image.path);
                    final imageFile = File('${directory.path}/$name');
                    final newImage = await File(image.path).copy(imageFile.path);

              },
            ),
            SizedBox(height: h * 0.02),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(
          labelText: "Full Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
              ),
            ),
            SizedBox(height: h * 0.02),           
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 5.0),
              child: TextField(
                
                controller: dateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
                icon: Icon(Icons.calendar_today,color: black,),
                labelText: "Enter your DOB"),
                onChanged: (date) {
                  
                },
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
                print("Not selected");
                return;
              }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:5.0),
              child: Row(
                
                children: [
                  Flexible(child: Text("Gender : ")),
                  Expanded(
                child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                value: Gender.MALE,
                groupValue: _gender,
                title: Text(Gender.MALE.name,style: TextStyle(fontSize: 14)),
                  onChanged: (val) {
                  setState(() {
                    _gender = val;
                
                  });
          
                  print(Gender.MALE.name);
                }),
              ),
              Expanded(
                child: RadioListTile(
                contentPadding: EdgeInsets.all(0.0),
                value: Gender.FEMALE,
                groupValue: _gender,
                title: Text(Gender.FEMALE.name,style: TextStyle(fontSize: 14),),
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
          labelText: "Height",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: weightcontroller,
                decoration: InputDecoration(
          labelText: "Weight",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
              ),
            ),
            SizedBox(height: h * 0.02),
            GestureDetector(
              onTap: () {
                print("Name $namecontroller.text");
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
        ),
      ),
    ));
  }
}
