import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController? _accountNameController;

  @override
  void initState() {
    _accountNameController = TextEditingController();
    super.initState();
  }

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
              controller: _accountNameController,
              decoration: const InputDecoration(
                hintText: '********',
              ),
              cursorColor: Colors.grey,
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Signed in successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Sign In'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
