import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iec_project/controllers/sign_up_controller.dart';
import 'package:iec_project/pages/sign_in.dart';
import 'package:iec_project/utils/gradients.dart';

import 'dart:math' as math;

import 'package:iec_project/utils/info_box.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confrimPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignUpController signUpController = SignUpController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradeGrey),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        // backgroundColor: const Color(0xFFBBC6D2),
        // backgroundColor: const Color(0xFF2C5364),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: const [
                    Text(
                      "Hello There!",
                      style: TextStyle(
                        color: Colors.white,
                        // color: Color(0xFF203A43),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 10.0),
                      child: Text(
                        "Register now and become a part of Us!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          // color: Color(0xFF203A43),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: _nameController,
                          cursorColor: const Color(0xFF2C3E50),
                          cursorWidth: 1.0,
                          decoration: const InputDecoration(
                            labelText: "Name",
                            labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                            hintText: "e.g Mark ZingerBurger",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          cursorColor: const Color(0xFF2C3E50),
                          cursorWidth: 1.0,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                            hintText: "yourEmail@email.com",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          cursorColor: const Color(0xFF2C3E50),
                          cursorWidth: 1.0,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle:
                                const TextStyle(color: Color(0xFF8E9EAB)),
                            hintText: "••••••••",
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              splashRadius: 10,
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xFF8E9EAB),
                                size: 20.0,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      child: CupertinoButton(
                        color: const Color(0xFF2C3E50),
                        onPressed: () => _signUp(context),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text("Sign Up"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30.0,
                        horizontal: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Transform.rotate(
                              angle: math.pi,
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  gradient: gradeGrey,
                                  // color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            "Or continue with",
                            style: TextStyle(
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 1,
                              decoration: BoxDecoration(
                                gradient: gradeGrey,
                                // color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      child: CupertinoButton(
                        color: const Color(0xFF2C3E50),
                        onPressed: () {
                          // signUpController.googleSignIn(
                          //   _emailController.text,
                          //   _passwordController.text,
                          //   context,
                          // );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/google.png",
                              scale: 2,
                            ),
                            const SizedBox(width: 20),
                            const Text("Google SignIn"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already a member?',
                      style: TextStyle(
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      onPressed: () async {
                        await Future.delayed(
                          const Duration(milliseconds: 100),
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "SignIn here",
                        style: TextStyle(
                          color: Colors.blue,
                          // color: Color(0xFF2C3E50),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signUp(BuildContext context) async {
    final user = await signUpController.signUp(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
      context,
    );

    // InfoBox(
    //   "Signed Up Successfully",
    //   context: context,
    //   infoCategory: InfoCategory.success,
    // );
  }
}
