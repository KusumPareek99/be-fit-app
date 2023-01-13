import 'package:be_fit_app/constants/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  var emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

          Get.snackbar("Forgot Password", "User message",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Account creation failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: const Text(
           "Password resend link has been sent. Check your email.",
            style: TextStyle(color: Colors.white),
          ));


       
    } on FirebaseAuthException catch (e) {
      print(e);
      Get.snackbar("Forgot Password", "User message",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Wrong email entered.",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
     
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Enter your email and we will send you a password rest link.",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: h * 0.05,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 8,
                      spreadRadius: 5,
                      offset: const Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2))
                ]),
            height: 60,
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Email ID",
                  prefixIcon:
                      const Icon(Icons.email_outlined, color: Color(0xFFF58434)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.white, width: 1.0)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.white, width: 1.0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          GestureDetector(
            onTap: () {
              passwordReset();
            },
            child: Container(
              width: w * 0.62,
              height: h * 0.07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/loginbtn.png"),
                      fit: BoxFit.cover)),
              child: const Center(
                child: Text(
                  "RESET",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}