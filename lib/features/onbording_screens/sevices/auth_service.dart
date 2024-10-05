import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthServices extends ChangeNotifier {
  bool isLoading = false;
  String? _verificationId;
  String? phoneNumber;
  String? location;

  // UserModel? user;
  String? primaryAdress;
  Future<void> sendOtp(
      {required String phone,
      required void Function(bool success) onSend}) async {
    isLoading = true;
    notifyListeners();

    phoneNumber = phone;

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          log(e.message ?? "");
          Fluttertoast.showToast(msg: e.message ?? "Failed");
          isLoading = false;
          notifyListeners();
          onSend(false);
        },
        codeSent: (String verificationId, int? resendToken) {
          onSend(false);
          Fluttertoast.showToast(msg: "Code sent");
          _verificationId = verificationId;

          isLoading = false;
          notifyListeners();
          onSend(true);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          isLoading = false;
          notifyListeners();
          onSend(false);
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message ?? e.code);
      isLoading = false;

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
