import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iec_project/controllers/auth_controller.dart';
import 'package:iec_project/pages/register_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Authcontroller acontroller = Authcontroller();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue[900],
                  width: 150,
                  height: 150,
                  child: Image.asset("assets/talent-search.png"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: _accountNameController,
                            decoration: const InputDecoration(
                              hintText: 'e.g username_01',
                              prefixIcon: Icon(CupertinoIcons.person),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Field is empty";
                              } else if (!value.contains("@")) {
                                return "Invalid email";
                              }
                            },
                            cursorColor: Colors.grey,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Password",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                                hintText: '********',
                                prefixIcon: Icon(Icons.lock)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Field is empty";
                              } else if (value.length < 6) {
                                return "password is less than 6";
                              }
                            },
                            cursorColor: Colors.grey,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        acontroller.login(
                                            _passwordController.text,
                                            _accountNameController.text,
                                            context);
                                      });
                                    }
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: const Text(
                                          'Sign In',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      )),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Regiser()));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: const Text(
                                          'Create',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 150,
                                  child: Image.asset("assets/google.png")),
                              SizedBox(
                                height: 30,
                                width: 2,
                                child: Container(
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text("Forget Password?"))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
