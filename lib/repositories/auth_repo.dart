import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_sync/common/constants/app_collection.dart';

import '../common/models/user_model.dart';

class AuthRepo {
  




  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Future<User?> signInMethod(String mail, String pass) async {
  //   try {
  //     UserCredential? credential =
  //         await _auth.signInWithEmailAndPassword(email: mail, password: pass);
  //     return credential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == "user-not-found") {
  //       print("User not found");
  //     } else if (e.code == 'wrong-password') {
  //       print("wrong password provided");
  //     }
  //   }
  //   return null;
  // }

  Future<bool> userSignUp(String fullName, String mail, String password) async {
    try {
      var u = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);

      if (u.user == null) return false;

      await usersCollection.doc(u.user?.uid).set({
        'mail': mail,
        'uid': u.user!.uid,
        'name': fullName,
      });

      await FirebaseAuth.instance.currentUser?.updateDisplayName(fullName);
      await FirebaseAuth.instance.currentUser?.reload();
    } catch (e) {
      return false;
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

  Future<UserModel> userLogin(String mail, String password) async {
    try {
      var u = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: password);

      if (u.user == null) throw IncorrectCredentailsAuthServicesException();

      var d = await usersCollection.doc(u.user!.uid).get();

      if (d.data()?['imageUrl'] == null) {
        throw UserIncompleteProfileAuthServicesException();
      }
      return UserModel.fromMap(d.data()!);
    } catch (e) {
      if (e is AuthServicesException) {
        rethrow;
      }
      throw IncorrectCredentailsAuthServicesException();
    }
  }
}

abstract class AuthServicesException implements Exception {}

abstract class IncompleteProfileAuthServicesException
    extends AuthServicesException {}

class UserIncompleteProfileAuthServicesException
    extends IncompleteProfileAuthServicesException {}

class DriverIncompleteProfileAuthServicesException
    extends IncompleteProfileAuthServicesException {}

class IncorrectCredentailsAuthServicesException extends AuthServicesException {}

