// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:news_app/Firebase/firebase_auth.dart';
import 'package:news_app/constant/button_style.dart';
import 'package:news_app/constant/common.dart';
import 'package:news_app/screens/signup.dart';
import 'package:news_app/widgets/custom_widgets.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isloading = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Log in your account ",
                    style: Common().titelTheme,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: emailController,
                          hinttext: 'email',
                          obsecuretext: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: passwordController,
                          hinttext: 'Password',
                          obsecuretext: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                    _isloading ?    ElevatedButton(
                          onPressed: () async{
                            setState(()  {
                              _isloading = false;
                            });

                        await    FirebaseAuthFunc().signInMethod(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            );

                            setState(() {
                              _isloading = true;
                            });
                          },
                          style: buttonStyle,
                          child: const Text(
                            "Log In",
                            style: TextStyle(color: Colors.black),
                          ),
                        ) : 

                        const Center(child: CircularProgressIndicator(),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?",
                        style: Common().hinttext,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()),
                            );
                          },
                          child: Text(
                            "Register Now",
                            style: Common().mediumTheme,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
