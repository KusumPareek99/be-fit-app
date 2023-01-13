import 'package:be_fit_app/service/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final textFieldFocusNode = FocusNode();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  var password = '';
  var confirmPass = '';

  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;

   void hideKeyboard(BuildContext context) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;

      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;
      print(isHiddenPassword);
      print(textFieldFocusNode.context);
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      isHiddenConfirmPassword = !isHiddenConfirmPassword;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;
      print(isHiddenConfirmPassword);
      print(textFieldFocusNode.context);
    });
  }

  bool passwordConfirmMatch() {
    var pass = passwordController.text.trim();
    var confPass = confirmPassController.text.trim();
    return pass != confPass ? false : true; 
  }

  Future signUp() async {
   
    if ( passwordConfirmMatch()) {
      bool isregistered = await  AuthController.instance.register(
          emailController.text.trim(), passwordController.text.trim());
      if (isregistered) {
        var arr = AuthController.instance.auth.currentUser!.providerData;
        bool isProviderGoogle =
            arr[0].providerId == 'google.com' ? true : false;
        String profileImage = isProviderGoogle
            ? AuthController.instance.auth.currentUser!.photoURL!
            : 'assets/images/screen/propic.jpeg';
        print("${emailController.text.trim()}\n${nameController.text.trim()}\n$profileImage");

       addUserDetails(
          emailController.text.trim(),
           nameController.text.trim(),
            profileImage
          );
          }
    } else {
      Get.snackbar('Password Match', 'message',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Confirm Password and Password does not match",
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  Future addUserDetails(String email, String name, String profileImage) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'name': name, 'email': email, 'profileImage': profileImage});
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: h * 0.01,
              ),
              Container(
                width: w * 0.5,
                height: h * 0.28,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/storyset_signup.png"),
                        fit: BoxFit.cover)),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: 5,
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        height: 65,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText: "Your Name",
                              hintStyle: TextStyle(
                                fontSize: 12,
                              ),
                              prefixIcon: Icon(Icons.account_circle_outlined,
                                  color: Color.fromARGB(255, 243, 172, 101)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: 5,
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        height: 65,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email ID",
                              hintStyle: TextStyle(
                                fontSize: 12,
                              ),
                              prefixIcon: Icon(Icons.email_outlined,
                                  color: Color.fromARGB(255, 243, 172, 101)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: 5,
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        height: 65,
                        child: TextField(
                          controller: passwordController,
                          obscureText: isHiddenPassword,
                          onChanged: (value) {
                            password = value;
                          },
                          focusNode: textFieldFocusNode,
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(fontSize: 12),
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Color.fromARGB(255, 243, 172, 101)),
                              suffixIcon: IconButton(
                                icon: isHiddenPassword
                                    ? Icon(Icons.visibility_off_outlined)
                                    : Icon(Icons.visibility_outlined),
                                onPressed: () {
                                  _togglePasswordView();
                                },
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: 5,
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        height: 65,
                        child: TextField(
                          controller: confirmPassController,
                          obscureText: isHiddenConfirmPassword,
                          onChanged: (value) {
                            confirmPass = value;
                          },
                          decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(fontSize: 12),
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Color.fromARGB(255, 243, 172, 101)),
                              suffixIcon: IconButton(
                                icon: isHiddenConfirmPassword
                                    ? Icon(Icons.visibility_off_outlined)
                                    : Icon(Icons.visibility_outlined),
                                onPressed: () {
                                  _toggleConfirmPasswordView();
                                },
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ]),
              ),
              SizedBox(
                height: h * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  signUp();
                  hideKeyboard(context);
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
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Row(children: <Widget>[
                Expanded(child: Divider()),
                Text(
                  "  OR  ",
                  style: TextStyle(color: Colors.grey[400]),
                ),
                Expanded(child: Divider()),
              ]),
              SizedBox(
                height: h * 0.01,
              ),
              // Obx(() {
              //   if (controller.googleAccount.value==null) return LoginPage();
              //   else return WelcomePage(email: controller.googleAccount.value?.email ?? '' );
              // }),
              SignInButtonBuilder(
                  height: 40,
                  backgroundColor: Colors.blue,
                  text: "Sign up with Google",
                  onPressed: () {
                    //AuthController.instance.signInWithGoogle();
                    // controller.googleLogin();
                    AuthController().signInWithGoogle();
                  },
                  image: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Google.png"),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                  )),

              SizedBox(
                height: h * 0.04,
              ),
              RichText(
                text: TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                      )
                    ]),
              ),
            ],
          ),
        ));
  }
}
