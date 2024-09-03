import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:life_sync/screens/home/home_screen.dart';
import 'package:life_sync/screens/onboarding/onbording_screen.dart';
import 'package:life_sync/screens/profile_screen/user_profile_screen.dart';

import 'package:life_sync/utils/utils.dart';

import '../../common/constants/app_collection.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetch();
    });
  }

  fetch() async {
    if (FirebaseAuth.instance.currentUser == null) {
      Utils.go(
        context: context,
        screen: const OnbordingScreen(),
        replace: true,
      );
    } else {
      String id = FirebaseAuth.instance.currentUser!.uid;

      var user = await usersCollection.doc(id).get();

      if (user.exists) {
        if (user.data()?['imageUrl'] == null) {
          Utils.go(
              context: context,
              screen: const UserProfileScreen(),
              replace: true);
        } else {
          Utils.go(context: context, screen: const HomeScreen(), replace: true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
