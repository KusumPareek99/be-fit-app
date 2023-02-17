
import 'dart:io';

import 'package:be_fit_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';



class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance.collection("users");

  // Store data in firebase
  createUser(UserModel user) async{
     try{
      print(user.id! + " " + user.email!);
        await _db.doc(user.id).set(user.toJson());
     }catch (e){
      return e.toString() ;
     }
  }

  createGoogleUser(String aid) async{
    await _db.add({'AccessId': aid}).catchError((error,stackTrace){
        print(error.toString());
      });
  }
// fetch User Details based on email entered by user

getUserDetails(String email) {
  final snapshot = _db.where("Email", isEqualTo: email).snapshots() ;
//final res = snapshot.map((event) => UserModel.fromSnapshot(event.docs[0]['id']));
 // final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
 //print("Snapshot"+ snapshot.single.toString());
  return snapshot;
}

// Future<List<UserModel>> allUser() async{
//   final snapshot = await _db.collection("users").get();
//   final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
//   return userData;
// }


Future<void> updateUserRecord(UserModel user) async{
// var snap = getUserDetails(user.email);

// print(snap);
// var myuser = snap.data!.docs[0].data() as Map;
 User? currUser = FirebaseAuth.instance.currentUser;
// final docid = FirebaseFirestore.instance.collection('users');

// print(myuser);
  await FirebaseFirestore.instance.collection("users").doc(currUser!.uid).update(user.toJson());
}


}