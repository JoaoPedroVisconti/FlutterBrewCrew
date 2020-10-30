import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to Sign In Anony
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // Method to Sign In Email and Password

  // Method to Register Email and Password

  // Method to Sign Out

}
