import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:life_sync/common/app_colors.dart';
import 'package:life_sync/common/buttons/dynamic_button.dart';
import 'package:life_sync/common/widgets/custom_textfield.dart';
import 'package:life_sync/features/auth/screens/complete_profile.dart';
import 'package:life_sync/features/auth/sevices/auth_service.dart';
import 'package:life_sync/features/home/root_screen.dart';
import 'package:life_sync/features/home/smart_home_screen.dart';
import 'package:life_sync/utils/utils.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp = TextEditingController();

  final ValueNotifier<int> _timer = ValueNotifier<int>(59);
  late Timer _countdownTimer;

  startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timer.value > 0) {
        _timer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    _timer.dispose();
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
              "Enter sent OTP",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "We've sent opt to +91 ${w.phoneNumber}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Lottie.asset('assets/lottie/otp.json'),
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(height: 40),
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      bottomPadding: false,
                      autofocus: true,
                      controller: otp,
                      onChanged: (_) {
                        if (_.length == 6) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                        if (_.length > 6) {
                          otp.text = _.substring(0, 6);
                        }
                      },
                      isNumber: true,
                      hintText: "Enter OTP",
                      iconData: Iconsax.password_check,
                    ),
                  ),

                  const SizedBox(width: 20),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: DynamicButton(
                      isLoading: w.isLoading,
                      onPressed: () async {
                        if (otp.text.length == 6) {
                          var r = await w.verifyOTP(otp: otp.text);
                          if (r) {
                            if (context.mounted) {
                              Utils.go(
                                context: context,
                                screen: const SmartHomeScreen(),
                                replace: true,
                              );
                            }
                          } else {
                            Fluttertoast.showToast(msg: "Invalid OTP");
                          }
                        } else {
                          Fluttertoast.showToast(msg: "OTP must have 6 chars");
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(Iconsax.arrow_right_1),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Iconsax.arrow_right,
                  //   ),
                  // )
                ],
              ),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder(
                valueListenable: _timer,
                builder: (context, value, _) {
                  return AnimatedCrossFade(
                    firstChild: Row(
                      children: [
                        const Text(
                          " We will resend the code in ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${value}s",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    secondChild: Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            // w.resend(onSend: (_) {
                            //   _timer.value = 59;
                            //   startTimer();
                            // });
                          },
                          child: const Text(
                            "Resend Code",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    crossFadeState: value == 0
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 400),
                  );
                }),
            const SizedBox(height: 16),
            SizedBox(height: 10 + MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }
}
