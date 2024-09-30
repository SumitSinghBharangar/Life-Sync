import 'package:firebase_auth/firebase_auth.dart';

import 'package:life_sync/common/constants/app_collection.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
}

Future<bool> fetchUser() async {
  try {
    String id = FirebaseAuth.instance.currentUser!.uid;

    var user = await usersCollection.doc(id).get();

    if (user.exists) {
      if (user.data()?['imageUrl'] == null) {
        throw UserIncompleteProfileAuthServicesException();
      } else {
        return true;
      }
    }
  } on Exception {
    rethrow;
  }
  return false;
}

abstract class AuthServicesException implements Exception {}

abstract class IncompleteProfileAuthServicesException
    extends AuthServicesException {}

class UserIncompleteProfileAuthServicesException
    extends IncompleteProfileAuthServicesException {}

class DriverIncompleteProfileAuthServicesException
    extends IncompleteProfileAuthServicesException {}

class IncorrectCredentailsAuthServicesException extends AuthServicesException {}
