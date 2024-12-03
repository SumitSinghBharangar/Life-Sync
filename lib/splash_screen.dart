import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_sync/features/home/root_screen.dart';
import 'package:life_sync/features/onbording_screens/on_bording_screen.dart';
import 'package:life_sync/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });

    super.initState();
  }

  _init() async {
    FirebaseAuth.instance.currentUser == null
        ? Utils.go(
            context: context,
            screen: const OnbordingScreen(),
            replace: true,
          )
        : Utils.go(
            context: context,
            screen: const RootScreen(),
            replace: true,
          );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
