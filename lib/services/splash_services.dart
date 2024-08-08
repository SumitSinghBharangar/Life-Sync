import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_sync/screens/onboarding/onbording_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/utils.dart';

class SplashServices {
  static isFirstTime({required BuildContext context}) async {
    bool permission = await Utils.requestPermission();
    Timer(const Duration(milliseconds: 1500), () async {
      if (permission) {
        FirebaseAuth.instance.currentUser == null
            ? Utils.go(
                context: context,
                screen: const OnbordingScreen(),
                replace: true)
            : Utils.go(
                context: context,
                screen: const OnbordingScreen(),  // change screen onboarding to HomeScreen home page designed
                replace:
                    true); 
      } else {
        await openAppSettings();
      }
    });
  }
}
