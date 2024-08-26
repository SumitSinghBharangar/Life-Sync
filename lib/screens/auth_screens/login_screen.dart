import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:life_sync/bloc/auth/auth_bloc.dart';
import 'package:life_sync/common/buttons/bold_button.dart';
import 'package:life_sync/enum/enum.dart';
import 'package:life_sync/screens/home/home_screen.dart';
import 'package:life_sync/screens/profile_screen/user_profile_screen.dart';

import 'package:life_sync/utils/utils.dart';
import 'package:neopop/neopop.dart';

import '../../common/buttons/round_bold_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.pageController,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  final PageController pageController;
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final _fKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _mail.dispose();
    _password.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 45.w),
      child: Form(
        key: _fKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200.w),
            Text(
              "Sign In",
              style: TextStyle(
                fontSize: 28.sp,
                color: Colors.blue,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 80.h),
            TextFormField(
              style: TextStyle(
                fontSize: 20.sp,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your mail address";
                }
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              controller: _mail,
              focusNode: _emailFocusNode,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: InputDecoration(
                labelText: "Email..",
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20.sp),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 3.0,
                  ),
                ),
              ),
              onFieldSubmitted: (value) {
                Utils.fieldfocuschange(
                    context, _emailFocusNode, _passwordFocusNode);
              },
            ),
            SizedBox(
              height: 40.h,
            ),
            TextFormField(
              focusNode: _passwordFocusNode,
              obscureText: true,
              style: TextStyle(
                fontSize: 20.sp,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter you mail password";
                }
                if (value.length < 6) {
                  return "Must have at least 6 chars";
                }
                return null;
              },
              controller: _password,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: InputDecoration(
                labelText: "Password..",
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20.sp),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 3.0,
                  ),
                ),
              ),
              onFieldSubmitted: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            SizedBox(
              height: 40.h,
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: Bounce(
                child: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      previous.loginStatus != current.loginStatus,
                  builder: (context, state) {
                    return RoundBoldButton(
                        onPressed: () async {
                          if (_fKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(LoginButtonEvent(
                                mail: _mail.text.trim(),
                                pass: _password.text.trim()));
                            if (context.mounted) {
                              state.loginStatus == LoginStatus.incomplete
                                  ? Utils.go(
                                      context: context,
                                      screen: const UserProfileScreen(),
                                      replace: true)
                                  : Utils.go(
                                      context: context,
                                      screen: const HomeScreen(),
                                      replace: true);
                            }
                          }
                        },
                        child: state.loginStatus == LoginStatus.loading
                            ? CupertinoActivityIndicator(
                                color: Colors.white,
                                radius: 24,
                              )
                            : Text(
                                "Sign in",
                                style: TextStyle(fontSize: 24.sp),
                              ));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              child: Text(
                "Create An Account",
                style: TextStyle(
                  fontSize: 21.sp,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w900,
                ),
              ),
              onTap: () {
                widget.pageController.previousPage(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastEaseInToSlowEaseOut,
                );
              },
            ),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 21.sp,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w900,
                ),
              ),
              onTap: () {
                widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastEaseInToSlowEaseOut,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
