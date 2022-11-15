import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confrimPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFBBC6D2),
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
                      color: Color(0xFF203A43),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    child: Text(
                      "Register now and become a part of Us!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF203A43),
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
                          labelStyle: const TextStyle(color: Color(0xFF8E9EAB)),
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
                        // signUpController.googleSignIn(
                        //   _emailController.text,
                        //   _passwordController.text,
                        //   context,
                        // );
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
    );
  }

  _signUp(BuildContext context) {
    InfoBox(
      "Signed In Successfully",
      context: context,
      infoCategory: InfoCategory.success,
    );
  }
}
