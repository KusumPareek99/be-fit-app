import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/screens/forgot_password.dart';
import 'package:be_fit_app/screens/signup_page.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/widgets/top_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final textFieldFocusNode = FocusNode();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isHiddenPassword = true;

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
              SizedBox(
                height: h * 0.01,
              ),
              Container(
                  width: w,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: w, height: h * 0.17, child: TopBar()),
                      ClipOval(
                        child: Container(
                            width: w * 0.5,
                            height: h * 0.20,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/logo-whiteBg.png"),
                                    fit: BoxFit.cover))),
                      ),
                      Center(
                        child: Text(
                          "Be.Fit.",
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w600,
                              color: primary),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.05,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
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
                        height: 60,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email ID",
                              prefixIcon:
                                  Icon(Icons.email_outlined, color: primary),
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
                        margin: const EdgeInsets.only(left: 10, right: 10),
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
                        height: 60,
                        child: TextField(
                          controller: passwordController,
                          obscureText: isHiddenPassword,
                          focusNode: textFieldFocusNode,
                          decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon:
                                  Icon(Icons.password_outlined, color: primary),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const ForgotPasswordPage();
                              }));
                            },
                            child: Text(
                              "Forgot your Password?",
                              style: TextStyle(fontSize: 15, color: primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: h * 0.02,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 82,
                    vertical: 13,
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: white),
                ),
                onPressed: () {
                  AuthController.instance.login(emailController.text.trim(),
                      passwordController.text.trim());
                  hideKeyboard(context);
                },
              ),
              // GestureDetector(
              //   onTap: () {
              //     AuthController.instance.login(emailController.text.trim(),
              //         passwordController.text.trim());
              //     hideKeyboard(context);
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
              //         "Login",
              //         style: TextStyle(
              //           fontSize: 20,
              //           color: Colors.white,
              //           fontWeight: FontWeight.w600,
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
                  text: "Sign in with Google",
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
                height: h * 0.03,
              ),
              RichText(
                text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                    children: [
                      TextSpan(
                          text: "Create",
                          style: TextStyle(
                            fontSize: 15,
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => const SignUpPage()))
                    ]),
              ),
            ],
          ),
        ));
  }
}
