import 'package:flutter/material.dart';
import 'package:iec_project/pages/sign_up.dart';
import 'package:iec_project/utils/gradients.dart';

import 'sign_in.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: moonlitAestroid,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        // color: const Color(0xFF395B64),
                        color: const Color(0xFFA5C9CA),
                        // color: Colors.blueGrey[300],
                        // color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Image.asset(
                        'assets/Adventure.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: const [
                      Text(
                        "Discover your",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Dream Job Here!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Text(
                          "Become a part of this amazing platform and find the job you admire.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await Future.delayed(
                              const Duration(milliseconds: 200),
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUp(),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: const Color(0xFFA5C9CA),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Color(0xFF203A43),
                            ),
                          ),
                        ),
                        MaterialButton(
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
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
