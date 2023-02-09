
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id;
  final String name;
  final String email;
  final String? profileImage;
  final String? dob;
  final String? gender;
  final String? height;
  final String? weight;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.dob,
    this.gender,
    this.height,
    this.weight
  });


     

toJson(){
  return {
    "UserName" : name,
    "Email" : email,
    "ProfileImage" : profileImage,
    "DOB" : dob,
    "Gender" : gender,
    "Height" : height,
    "Weight" : weight, 
  };
}

// match user fetched from firestore to usermodel
factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
  final data = document.data()!;
  return UserModel(
    id : document.id,
    name :data["UserName"],
   email : data["Email"],
    profileImage : data["ProfileImage"],
    dob : data["DOB"],
    gender : data["Gender"],
    height : data["Height"],
    weight :data["Weight"]
  );
}

factory UserModel.fromJson(Map<String,dynamic> json){
  return UserModel(
    
    name :json["UserName"],
   email : json["Email"],
    profileImage : json["ProfileImage"],
    dob : json["DOB"],
    gender : json["Gender"],
    height : json["Height"],
    weight :json["Weight"]
  );
}

}