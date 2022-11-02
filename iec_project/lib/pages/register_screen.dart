import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iec_project/Firebase/auth_Service.dart';
import 'package:iec_project/utils/constants.dart';

class Regiser extends StatefulWidget {
  const Regiser({super.key});

  @override
  State<Regiser> createState() => _RegiserState();
}

class _RegiserState extends State<Regiser> {
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confrimPassword = TextEditingController();
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
                                "Register",
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
                              const Text(
                                "Confirm Password",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextFormField(
                                controller: _confrimPassword,
                                decoration: const InputDecoration(
                                    hintText: '********',
                                    prefixIcon: Icon(Icons.lock)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Field is empty";
                                  } else if (value.length < 6) {
                                    return "password is less than 6";
                                  } else if (value !=
                                      _passwordController.text) {
                                    return "password is different";
                                  }
                                },
                                cursorColor: Colors.grey,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      print("you are registered");
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
                                          'Register',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
