import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:iec_project/controllers/auth_controller.dart';

import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    Authcontroller auth = Get.put(Authcontroller());
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              auth.signOut();
            },
            child: const Text("sign out")),
      ),
    );
  }
}
