import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  final AuthService _authService =
      AuthService(firebaseAuth: FirebaseAuth.instance);
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Name",
              style: TextStyle(
                color: Colors.amber,
              ),
            ),
            TextField(
              controller: _accountNameController,
              decoration: const InputDecoration(
                hintText: 'e.g username_01',
              ),
              cursorColor: Colors.grey,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Password",
              style: TextStyle(
                color: Colors.amber,
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: '********',
              ),
              cursorColor: Colors.grey,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Confirm Password",
              style: TextStyle(
                color: Colors.amber,
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: '********',
              ),
              cursorColor: Colors.grey,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  User? result = await _authService.Singup(
                      _accountNameController.text,
                      _passwordController.text,
                      context);
                  if (result != null) {
                    dialog('success', context);
                    setState(() {
                      loading = false;
                    });
                  }
                },
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text('Regiser'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
