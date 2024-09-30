import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:life_sync/common/buttons/dynamic_button.dart';
import 'package:life_sync/screens/auth_screens/otp_screen.dart';
import 'package:lottie/lottie.dart';

import '../../common/constants/custom_textfield.dart';
import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phone = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.paddingOf(context).top + 50),
            const Text(
              "To continue enter",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "your phone number.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Center(
                child: Lottie.asset(
                  'assets/lottie/login.json',
                ),
              ),
            ),
            CustomTextField(
              controller: _phone,
              autofocus: true,
              removeFocusOutside: true,
              isNumber: true,
              hintText: "Phone Number",
              iconData: Iconsax.call,
            ),
            const SizedBox(height: 40),
            DynamicButton.fromText(
              // isLoading: w.isLoading,
              onPressed: () {
                if (_phone.text.length == 6) {
                  Utils.go(
                      context: context,
                      screen: const OtpScreen(),
                      replace: true);
                } else {
                  Fluttertoast.showToast(msg: "OTP must have 6 chars");
                }
                // w.sendOtp(
                //     phone: _phone.text,
                //     onSend: (_) {
                //       if (_) {
                //         context.go(Routes.otpScreen.path);
                //       }
                //     });
              },
              text: "SEND OTP",
            ),
            SizedBox(
              height: MediaQuery.paddingOf(context).bottom + 25,
            ),
          ],
        ),
      ),
    );
  }
}
