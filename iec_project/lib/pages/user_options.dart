import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iec_project/Widgets/user_optionCards.dart';
import 'package:iec_project/pages/company_bio.dart';

import 'package:iec_project/pages/seeker_bio.dart';

import 'package:iec_project/utils/gradients.dart';

class UserOptions extends StatelessWidget {
  const UserOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradeGrey),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Are you a new user? what's on your mind?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              UserCards(
                text: "Want to Hire people for your organization?",
                icon: CupertinoIcons.building_2_fill,
                WidgetPage: const CompanyBio(),
              ),
              const SizedBox(
                height: 30,
              ),
              UserCards(
                text: "Looking for a job? what are you waiting for?",
                icon: CupertinoIcons.search_circle_fill,
                WidgetPage: const SeekerBio(),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
