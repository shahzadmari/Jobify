// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:iec_project/pages/introduction.dart';

import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  //set timer in initsate so that splashScreen would navigate to sign in after 5 seconds
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), (() {
      Get.offAll(const IntroductionScreen());
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image.asset("assets/talent-search.png"),
            ),
            const SizedBox(height: 20),
            const textAnimation(
                text1: "happy Hiring!", text2: "With", text3: "Jobify")
          ],
        ),
      ),
    );
  }
}

//this widget contains the animated text kit which supposed to animate the text
//to use this add dependency flutter pub add animated_text_kit
class textAnimation extends StatefulWidget {
  final text1, text2, text3;
  const textAnimation({super.key, this.text1, this.text2, this.text3});

  @override
  State<textAnimation> createState() => _textAnimationState();
}

class _textAnimationState extends State<textAnimation> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(animatedTexts: [
      TypewriterAnimatedText(
        widget.text1,
        textStyle: const TextStyle(
            fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      TypewriterAnimatedText(
        widget.text2,
        textStyle: const TextStyle(
            fontSize: 32, fontFamily: 'Canterbury', color: Colors.white),
      ),
      TypewriterAnimatedText(
        widget.text3,
        textStyle: const TextStyle(
            fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ]);
  }
}
