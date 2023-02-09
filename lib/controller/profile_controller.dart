import 'package:be_fit_app/model/user_model.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/service/user_repository.dart';

import 'package:get/get.dart';

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
}
