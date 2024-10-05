import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:iconsax/iconsax.dart';
import 'package:life_sync/common/buttons/dynamic_button.dart';
import 'package:life_sync/common/widgets/custom_textfield.dart';
import 'package:life_sync/features/onbording_screens/sevices/auth_service.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../common/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phone = TextEditingController();
  bool _agreed = false;

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = context.watch<AuthServices>();

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
              // decoration: InputDecoration(
              //   contentPadding:
              //       const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              //   prefixIcon: const SizedBox(
              //     width: 40,
              //     child: Center(
              //       child: Text("+91"),
              //     ),
              //   ),
              //   border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(12),
              //     borderSide: BorderSide.none,
              //   ),
              //   hintText: "Phone Number",
              //   filled: true,
              // ),
              hintText: "Phone Number",
              iconData: Iconsax.call,
            ),
            SizedBox(
              height: 5.h,
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: Center(
                child: FittedBox(
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      Checkbox(
                        activeColor: AppColors.buttonColor,
                        focusColor: Colors.indigoAccent,
                        hoverColor: Colors.indigoAccent,
                        value: _agreed,
                        onChanged: (_) {
                          setState(() {
                            _agreed = !_agreed;
                          });
                        },
                      ),
                      Text(
                        "I agree to all the",
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (context.mounted) {
                            // context.push(Routes.termUseScreen.path);
                          }
                        },
                        child: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DynamicButton.fromText(
              isLoading: w.isLoading,
              onPressed: () {
                if (!_agreed) {
                  Fluttertoast.showToast(
                      msg: "Please agree to our Terms & conditions");
                } else {
                  w.sendOtp(
                      phone: _phone.text,
                      onSend: (_) {
                        if (_) {
                          // context.go(Routes.otpScreen.path);
                        }
                      });
                }
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
