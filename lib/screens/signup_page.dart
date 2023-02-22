import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/model/user_model.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/service/user_repository.dart';

import 'package:be_fit_app/widgets/top_bar.dart';

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

  //final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  var password = '';
  var confirmPass = '';

  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;

  final userRepo = Get.put(UserRepository());

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;

      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;
      print(isHiddenPassword);
      print(textFieldFocusNode.context);
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      isHiddenConfirmPassword = !isHiddenConfirmPassword;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
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

  Future signUp(UserModel user) async {
    if (passwordConfirmMatch()) {
      bool isregistered = await AuthController.instance.register(
          emailController.text.trim(), passwordController.text.trim());
      if (isregistered) {
        // var arr = AuthController.instance.auth.currentUser!.providerData;
        // bool isProviderGoogle =
        //     arr[0].providerId == 'google.com' ? true : false;
        // String profileImage = isProviderGoogle
        //     ? AuthController.instance.auth.currentUser!.photoURL!
        //     : 'assets/images/screen/app_logo.png';
        
          userRepo.createUser(user);
          print("USER CREATED IN FIREStore...");
           Get.snackbar('Sign Up Success','Registered successfully!' ,
                                      backgroundColor: secondary,
                                      titleText: Text('Sign Up Success', style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),),
                                       messageText: Text('Registered successfully!.',style: TextStyle(fontSize: 15)));
                                    
        //  addUserDetails(
        //     emailController.text.trim(),
        //      nameController.text.trim(),
        //       profileImage
        //     );
      }
    } else {
     
           Get.snackbar('Check your password','Confirm Password and Password does not match' ,
                                      backgroundColor: secondary,
                                      titleText: Text('Check your password', style: TextStyle(color: Colors.redAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                                       messageText: Text('Confirm Password and Password does not match.',style: TextStyle(fontSize: 15)));
                                    
    }
  }

  @override
  void dispose() {
    emailController.dispose();
   // nameController.dispose();
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
          physics: const BouncingScrollPhysics(),
          child: Column(

            children: [
              Container(width: w, height: h * 0.15, child: TopBar()),
             
              ClipOval(
                child: Container(
                  width: w * 0.5,
                  height: h * 0.25,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo-whiteBg.png"),
                          fit: BoxFit.fill)),
                ),
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
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: 5,
                                  offset: const Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        height: 65,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email ID",
                              hintStyle: const TextStyle(
                                fontSize: 15,
                              ),
                              prefixIcon:  Icon(Icons.email_outlined,
                                  color: primary),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: 5,
                                  offset: const Offset(1, 1),
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
                              hintStyle: const TextStyle(fontSize: 15),
                              prefixIcon:  Icon(Icons.lock_outline,
                                  color: primary),
                              suffixIcon: IconButton(
                                icon: isHiddenPassword
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined),
                                onPressed: () {
                                  _togglePasswordView();
                                },
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: 5,
                                  offset: const Offset(1, 1),
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
                              hintStyle: const TextStyle(fontSize: 15),
                              prefixIcon:  Icon(Icons.lock_outline,
                                  color: primary),
                              suffixIcon: IconButton(
                                icon: isHiddenConfirmPassword
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined),
                                onPressed: () {
                                  _toggleConfirmPasswordView();
                                },
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
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
                     ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 13,
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: white),
                ),
                onPressed: () {
                  final user = UserModel(
                 
                        email: emailController.text.trim());
                    signUp(user);
                  hideKeyboard(context);
                },
              ),
              // GestureDetector(
              //   onTap: ()  {
              //     final user = UserModel(
                 
              //           email: emailController.text.trim());
              //       signUp(user);
                 
              //   },
              //   child: Container(
              //     width: w * 0.62,
              //     height: h * 0.07,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8),
              //         image: const DecorationImage(
              //             image: AssetImage("assets/images/loginbtn.png"),
              //             fit: BoxFit.cover)),
              //     child: const Center(
              //       child: Text(
              //         "Sign Up",
              //         style: TextStyle(
              //           fontSize: 18,
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
             
              SizedBox(
                height: h * 0.01,
              ),
              Row(children: <Widget>[
                const Expanded(child: Divider()),
                Text(
                  "  OR  ",
                  style: TextStyle(color: Colors.grey[400]),
                ),
                const Expanded(child: Divider()),
              ]),
              SizedBox(
                height: h * 0.01,
              ),
            
              SignInButtonBuilder(
                  height: 40,
                  backgroundColor: Colors.blue,
                  text: "Sign up with Google",
                  onPressed: () {
               
                    AuthController().signInWithGoogle();
                  },
                  image: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: const BoxDecoration(
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
                        style:  TextStyle(
                          fontSize: 15,
                          color: primary,
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
