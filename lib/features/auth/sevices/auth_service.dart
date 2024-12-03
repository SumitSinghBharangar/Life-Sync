import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../common/constants/app_collection.dart';
import '../../../common/models/user_model.dart';

class AuthServices extends ChangeNotifier {
  bool isLoading = false;
  String? _verificationId;
  String? phoneNumber;
  String? location;

  UserModel? user;
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

  Future<bool> verifyOTP({required String otp}) async {
    isLoading = true;
    notifyListeners();

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      isLoading = false;
      notifyListeners();

      String uid = FirebaseAuth.instance.currentUser!.uid;

      var usr = await usersCollection.doc(uid).get();

      if (usr.exists || usr.data() != null) {
        Fluttertoast.showToast(msg: "Can't use this phone number to register.");

        return false;
      }

      await init();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'credential-already-in-use') {
        Fluttertoast.showToast(
          gravity: ToastGravity.CENTER,
          msg: "This Number is already linked with one account",
          toastLength: Toast.LENGTH_LONG,
        );

        return false;
      }
      if (e.code == 'session-expired') {
        Fluttertoast.showToast(
          msg: "Session expired..",
        );
        return false;
      }

      isLoading = false;
      Fluttertoast.showToast(
          msg: e.code == 'invalid-verification-code'
              ? "Incorrect OTP"
              : e.message ?? e.code);

      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong");

      isLoading = false;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  init() async {
    isLoading = true;
    notifyListeners();

    var u = FirebaseAuth.instance.currentUser!;

    var data = await usersCollection.doc(u.uid).get();

    if (data.exists) {
      user = UserModel.fromMap(data.data()!);
      notifyListeners();
    } else {
      await usersCollection.doc(u.uid).set({
        'uid': u.uid,
        'phone': u.phoneNumber,
        'createdAt':
            Timestamp.fromDate(u.metadata.creationTime ?? DateTime.now()),
        'lastSignIn':
            Timestamp.fromDate(u.metadata.lastSignInTime ?? DateTime.now())
      });
    }

    // if (u.displayName == null) {
    //   try {
    //     var data = await driversCollection.doc(u.uid).get();
    //     if (data.data() == null) {
    //       user = UserModel.fromMap(data.data()!);
    //     }
    //   } catch (e) {
    //     log(e.toString());
    //   }
    // }
    // var r = await _getCurrentLocationName();
    // location = r;

    isLoading = false;
    notifyListeners();
  }

  Future<String> fileToFirebase({
    required List<String> path,
    required String name,
    required File file,
  }) async {
    String url;
    var ref = FirebaseStorage.instance.ref(path.first);
    for (var p in (path.length > 1 ? path.sublist(1) : [])) {
      ref = ref.child(p);
    }

    ref = ref.child('$name.${file.path.split('.').last}');

    await ref.putData(await file.readAsBytes()).whenComplete(
      () async {
        url = await ref.getDownloadURL();
      },
    );

    url = await ref.getDownloadURL();

    return url;
  }

  
}
