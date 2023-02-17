import 'dart:io';

import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/service/user_repository.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';


enum Gender { Male, Female }

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
 

  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  Gender? _gender;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String selectedGender = "";
  final userRepoController = Get.put(UserRepository());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();

  final ImagePicker _picker = ImagePicker();
  var selectedImage;

  static var arr = AuthController.instance.auth.currentUser!.providerData;
  static bool isProviderGoogle =
      arr[0].providerId == 'google.com' ? true : false;

  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  String defaultImage() {
    if (isProviderGoogle) {
      return AuthController.instance.auth.currentUser!.photoURL!;
    } else {
      return 'assets/images/app_logo.png';
    }
  }



  @override
  void initState() {
    super.initState();
  
    selectedGender = authController.myUser.value.gender ?? "";
    nameController.text = authController.myUser.value.name??"";
    dateController.text = authController.myUser.value.dob ??"";
    heightController.text = authController.myUser.value.height??"";
    weightController.text = authController.myUser.value.weight??"";
    selectedImage = authController.myUser.value.profileImage??"";

      _gender = Gender.Male;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: 
             
               Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Get.height * 0.3,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                getImage(ImageSource.gallery);
                              },
                              
                              child: selectedImage.toString().isEmpty
                                  ? Container(
                                      width: 120,
                                      height: 120,
                                      margin: const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: authController.myUser.value.profileImage != null ? NetworkImage(authController.myUser.value.profileImage!) :
                                                isProviderGoogle
                                                    ? NetworkImage(
                                                        AuthController
                                                            .instance
                                                            .auth
                                                            .currentUser!
                                                            .photoURL!)
                                                    : const AssetImage(
                                                            'assets/images/app_logo.png')
                                                        as ImageProvider,
                                            fit: BoxFit.fill),
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                  : Container(
                                      width: 120,
                                      height: 120,
                                      margin: const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: selectedImage.toString().contains('http') ? NetworkImage(selectedImage) as ImageProvider : FileImage(selectedImage),
                                              fit: BoxFit.fill),
                                          shape: BoxShape.circle,
                                          color: const Color(0xffD6D6D6)),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFieldWidget(
                                'Name',
                                Icons.person_outlined,
                                TextInputType.name,
                                nameController,
                                (String? input) {
                              if (input!.isEmpty) {
                                return 'Name is required!';
                              }

                              if (input.length < 3) {
                                return 'Please enter a valid name!';
                              }

                              return null;
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ], borderRadius: BorderRadius.circular(8)),
                              child: TextField(
                                controller: dateController,
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.orange),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8)),
                                    hintText: "Select your DOB"),
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
                                        DateFormat("yyyy-MM-dd")
                                            .format(pickedDate);

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
                            Row(
                              children: [
                                const Flexible(child: Text("Gender :")),
                                Expanded(
                                  child: RadioListTile(
                                      contentPadding: EdgeInsets.zero,
                                      value: Gender.Male,
                                      groupValue: _gender,
                                      title: Text(Gender.Male.name,
                                          style: const TextStyle(fontSize: 13)),
                                      onChanged: (val) {
                                        setState(() {
                                          _gender = val;
                                        });

                                        print(Gender.Male.name);
                                      }),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                      contentPadding: EdgeInsets.zero,
                                      value: Gender.Female,
                                      groupValue: _gender,
                                      title: Text(
                                        Gender.Female.name,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          _gender = val;
                                        });
                                        print(_gender!.name);
                                      }),
                                )
                              ],
                            ),
                            
                            TextFieldWidget(
                                'Height',
                                Icons.height,
                                TextInputType.number,
                                heightController,
                                (String? input) {
                              if (input!.isEmpty) {
                                return 'Height is required for your BMI!';
                              }

                              return null;
                            }, onTap: () {}),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                                'Weight',
                                Icons.calculate_outlined,
                                TextInputType.number,
                                weightController,
                                (String? input) {
                              if (input!.isEmpty) {
                                return 'Weight is requiredfor your BMI!';
                              }

                              return null;
                            }, onTap: () {}),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() => authController.isProfileUploading.value
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : submitButton('Submit', () async {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }
                                    print(selectedImage.toString());

                                    if (selectedImage.toString().contains('http') || selectedImage.toString().isEmpty) {
                                   
                                      Get.snackbar('Warning', 'Please choose your profile again.');
                                     return;
                                    }
                                    
                                    authController.isProfileUploading(true);
                                   
                                    authController.storeUserInfo(
                                        selectedImage,
                                        nameController.text.trim(),
                                        dateController.text.trim(),
                                        _gender!.name,
                                        heightController.text.trim(),
                                        weightController.text.trim());

                                   Get.snackbar('Message','Details saved successfully');
                                  })),
                          ],
                        ),
                      ),
                    )
                  ],
               )
        
          
      ),
    );
  }

  TextFieldWidget(String title, IconData iconData, TextInputType keyboardType,
      TextEditingController controller, Function validator,
      {Function? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: Get.width,
          // height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            //onTap: ()=> onTap!(),
            keyboardType: keyboardType,
            validator: (input) => validator(input),
            controller: controller,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  iconData,
                  color: Colors.orange,
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget submitButton(String title, Function onPressed) {
    return MaterialButton(
      minWidth: Get.width,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Colors.orange,
      onPressed: () => onPressed(),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
