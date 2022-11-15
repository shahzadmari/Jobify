import 'package:firebase_auth/firebase_auth.dart';

class SingoutController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future SignOut() async {
    await firebaseAuth.signOut();
  }
}
