import 'dart:io';

import 'package:be_fit_app/model/user_model.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/service/user_repository.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  static ProfileController pController = Get.find();

 
  // get user email and pass to userRepository to fetch user record
  final _authRepo = Get.put(AuthController());
  final _userRepo = Get.put(UserRepository());
  getUserData() {
    final email = _authRepo.auth.currentUser?.email;
    if (email != null) {
     // print("Profile Controller" + _userRepo.getUserDetails(email).toString());
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  // update user details
  updateRecord(UserModel user) async{
    await _userRepo.updateUserRecord(user);
  }

// pick user image from gallery
  final picker = ImagePicker();

  XFile? _image;
  XFile? get image=> _image;

Future<XFile?> pickGalleryImage(BuildContext context) async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

  if(pickedFile != null){
    _image = XFile(pickedFile.path);
  }
  return _image;
}

}
