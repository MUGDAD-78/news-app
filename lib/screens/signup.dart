// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:news_app/Firebase/firebase_auth.dart';
import 'package:news_app/constant/alert_dilog.dart';
import 'package:news_app/constant/button_style.dart';
import 'package:news_app/constant/common.dart';
import 'package:news_app/constant/text_filed_decoration.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  String _password = '';
  // ignore: unused_field
  String _confirmPassword = '';
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello! Register to get  ",
                        style: Common().titelTheme,
                      ),
                      Text(
                        "started",
                        style: Common().titelTheme,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "This filed is required";
                            }
                            return null;
                          },
                          decoration: textFiledDecoration.copyWith(
                            hintText: "Username",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          obscureText: false,
                          validator: (value) {
                            return value!.contains(RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                                ? null
                                : "Enter a valid email";
                          },
                          decoration:
                              textFiledDecoration.copyWith(hintText: 'Email'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            _password = value;
                          },
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Password is required please enter';
                            }
                            // you can check password length and specifications
                            if (value!.length < 8) {
                              return "Password must be atleast 8 characters long";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: textFiledDecoration.copyWith(
                              hintText: 'Password'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            _confirmPassword = value;
                          },
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Conform password is required please enter';
                            }
                            if (value != _password) {
                              return 'Confirm password not matching';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: confirmpasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: textFiledDecoration.copyWith(
                              hintText: 'Confirm Password'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        isLoading
                            ? ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    await FirebaseAuthFunc().registerMethod(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        userName: usernameController.text,
                                        context: context);
                                    setState(() {
                                      isLoading = true;
                                    });
                                    showAlertDilog(context,
                                        "Welcome! , Go back to home page now");
                                  } else {
                                    showAlertDilog(context, "ERROR");
                                  }
                                },
                                style: buttonStyle,
                                child: const Text(
                                  "Register",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            : const CircularProgressIndicator(
                                color: Colors.redAccent,
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Image.asset(
                    'assets/img/newsIcon.png',
                    height: 70,
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
