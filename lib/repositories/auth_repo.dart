import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_sync/common/constants/app_collection.dart';

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

  Future<bool> signUpMethod(String email, String password, String name) async {
    try {
      UserCredential? credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user == null) return false;

      await usersCollection.doc(credential.user?.uid).set({
        "mail": email,
        "uid": credential.user?.uid,
        "name": name,
      });
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser?.reload();
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return false;
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
