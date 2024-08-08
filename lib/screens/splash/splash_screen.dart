import 'package:flutter/material.dart';

import '../../services/splash_services.dart';

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
      SplashServices.isFirstTime(context: context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}