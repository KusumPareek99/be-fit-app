// import 'package:be_fit_app/constants/const.dart';
// import 'package:be_fit_app/controller/profile_controller.dart';
// import 'package:be_fit_app/model/user_model.dart';
// import 'package:be_fit_app/widgets/app_bar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class TestUserProfile extends StatefulWidget {
//   //final UserModel usermodel;
//   const TestUserProfile({super.key});

//   @override
//   State<TestUserProfile> createState() => _TestUserProfileState();
// }

// class _TestUserProfileState extends State<TestUserProfile> {
//   TextEditingController? nameController;
//   User? user = FirebaseAuth.instance.currentUser;
//   UserModel? userData;
//   getuseer() async {
//    final snapshot =await  FirebaseFirestore.instance.collection("users").where("Email", isEqualTo: user?.email).get();
//   userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
//   nameController = TextEditingController.fromValue(TextEditingValue(text:userData!.name));
//   }

//   @override
//   Widget build(BuildContext context) {
//       final controller = Get.put(ProfileController());
//    // getuseer();
//     return SafeArea(
//         child: Scaffold(
//       body: Center(
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance.collection('users').snapshots(),
//           builder: ((context,AsyncSnapshot<QuerySnapshot> snapshot) {
//             if(snapshot.connectionState == ConnectionState.waiting){
//               return Column(
//               children: [
//                 Padding(
//                     padding: const EdgeInsets.only(top: appPadding * 2),
//                     child: Column(
//                       children: [
//                         CustomAppBar(),
//                       ],
//                     )),
//                 const CircularProgressIndicator()
//               ],
//             );
//             }
//             if(snapshot.data == null){
//               Column(
//               children: [
//                 Padding(
//                     padding: const EdgeInsets.only(top: appPadding * 2),
//                     child: Column(
//                       children: [
//                         CustomAppBar(),
//                       ],
//                     )),
               
//               ],
//             );
//             }

//             if(snapshot.data!.docs.isEmpty){
//               Column(
//               children: [
//                 Padding(
//                     padding: const EdgeInsets.only(top: appPadding * 2),
//                     child: Column(
//                       children: [
//                         CustomAppBar(),
//                       ],
//                     )),
//                const SizedBox(
//                 child: Center(
//                     child:
//                         Text("Please Login again")),
//               )
//               ],
//             );
//             }

//             if(snapshot.hasData){
//              // final userData = snapshot.data!.docs;
//              final List<DocumentSnapshot> documents = snapshot.data!.docs;
//               return ListView(
//                 children: documents
//                     .map((doc) => Card(
//                           child: ListTile(
//                             title: Text(doc['UserName']),
//                             subtitle: Text(doc['Email']),
//                           ),
//                         ))
//                     .toList());
//              // var name = UserModel.fromJson(userData.data() as Map<String,dynamic>);
//               //  return Column(
//               // children: [
//               //   TextField(controller: nameController, onChanged: (value) {
                  
//               //   },),
//               //   const SizedBox(height: 20),
//               //   const TextField(),
//               // ],
//               // );
            
//             }

//             return  const Center(child: Text("Something went wrong"));
//           }),
//         ),
//       ),
//     ));
//   }
// }


import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/screens/fitness/components/custom_app_bar.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestUserProfile extends StatefulWidget {
  const TestUserProfile({super.key});

  @override
    _TestUserProfileState createState() => _TestUserProfileState();
}

class _TestUserProfileState extends State<TestUserProfile> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream = FirebaseFirestore.instance.collection('users').where("Email",isEqualTo:AuthController.instance.auth.currentUser!.email).snapshots();
  late TextEditingController namecontroller;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
         if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              Map<String,dynamic> data = snapshot.data!.docs as  Map<String,dynamic>;
          print(data); 
          namecontroller.text = data['UserName'];
          return  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                     controller: namecontroller,
                      onChanged: (value) {
                        print(value);
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
                  );
                 
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              // ignore: prefer_const_constructors
              return Scaffold(
               body: const Center(
                  child: Text("Something went wrong !",style: TextStyle(color: Colors.red),),
                ),
              );
            }
          } else if(snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: appPadding * 2),
                    child: Column(
                      children: [
                        CustomAppBar(),
                      ],
                    )),
                const CircularProgressIndicator()
              ],
            );
          } else{
           return  const Scaffold(body: Center(child: Text("Something went wrong",style: TextStyle(color: Colors.orange))));
          }
      
      }
    );
  }
}