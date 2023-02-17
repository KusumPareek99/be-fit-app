
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
   String? id;
   String? name;
   String? email;
   String? profileImage;
   String? dob;
   String? gender;
   String? height;
   String? weight;
   int? steps_today;
   int? steps_total;

  

   UserModel( {

    this.id,
    this.name,
   this.email,
    this.profileImage,
    this.dob,
    this.gender,
    this.height,
    this.weight,
    this.steps_today,
    this.steps_total,
  });


     

toJson(){
  return {
    "uid" : FirebaseAuth.instance.currentUser!.uid,
    "UserName" : name,
    "Email" : email,
    "ProfileImage" : profileImage,
    "DOB" : dob,
    "Gender" : gender,
    "Height" : height,
    "Weight" : weight, 
    "Steps_today": steps_today,
    "Steps_total" : steps_total
  };
}


 UserModel.fromJson(Map<String,dynamic> json){

    id = json['uid'];
    name =json["UserName"];
   email = json["Email"];
    profileImage = json["ProfileImage"];
    dob = json["DOB"];
    gender = json["Gender"];
    height = json["Height"];
    weight =json["Weight"];
     steps_today= json["Steps_today"];
    steps_total= json["Steps_total"];

}

}