import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
    required this.pageController,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
  final PageController pageController;
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
