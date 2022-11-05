import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iec_project/controllers/sign_in_controller.dart';
import 'package:iec_project/pages/home_page.dart';
import 'package:iec_project/pages/sign_up.dart';
import 'package:iec_project/utils/gradients.dart';

import 'dart:math' as math;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignInController signInController = SignInController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(gradient: moonlitAestroid),
      decoration: BoxDecoration(gradient: gradeGrey),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
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
                      "Hello Again!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 10.0),
                      child: Text(
                        "Welcome back you've been missed!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
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
                          controller: _emailController,
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: CupertinoButton(
                          padding: const EdgeInsets.only(right: 5),
                          onPressed: () {},
                          child: const Text(
                            "Recover Password",
                            style: TextStyle(
                              color: Color(0xFF2C3E50),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: CupertinoButton(
                          color: const Color(0xFF2C3E50),
                          onPressed: () => _signIn(context),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("Sign In"),
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
                            signInController.googleSignIn(
                              _emailController.text,
                              _passwordController.text,
                              context,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/google.png",
                                scale: 2,
                              ),
                              const SizedBox(width: 20),
                              const Text("Sign in with Google"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
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
                              builder: (context) => const SignUp(),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Register Now",
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

  _signIn(BuildContext context) async {
    User? user = await signInController.signIn(
      _emailController.text,
      _passwordController.text,
      context,
    );

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }
}
