

import 'package:be_fit_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Store data in firebase
  createUser(UserModel user) async{
     await _db.collection("users").add(user.toJson()).catchError((error,stackTrace){
        print(error.toString());
      });
  }
// fetch User Details based on email entered by user

getUserDetails(String email) {
  final snapshot = _db.collection("users").where("Email", isEqualTo: email).snapshots();
 // final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
 //print("Snapshot"+ snapshot.single.toString());
  return snapshot;
}

Future<List<UserModel>> allUser() async{
  final snapshot = await _db.collection("users").get();
  final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
  return userData;
}

Future<void> updateUserRecord(UserModel user) async{
var snap = getUserDetails(user.email);
var myuser = snap.data!.docs[0].data() as Map;
  await _db.collection("users").doc(myuser['id']).update(user.toJson());
}

}