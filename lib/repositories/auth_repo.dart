import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signInMethod(String mail, String pass) async {
    try {
      UserCredential? credential =
          await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("User not found");
      } else if (e.code == 'wrong-password') {
        print("wrong password provided");
      }
    }
    return null;
  }

  Future<User?> signUpMethod(String email, String password) async {
    try {
      UserCredential? credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> passwordResetMethod(String fmail) async {
    try {
      await _auth.sendPasswordResetEmail(email: fmail);
      print("password reset mail sended to to gmail account");
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return;
  }
}
