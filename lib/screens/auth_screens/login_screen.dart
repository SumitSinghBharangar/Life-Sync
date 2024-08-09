import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_sync/common/appcolor.dart';
import 'package:iconly/iconly.dart';
import 'package:life_sync/utils/utils.dart';
import 'package:neopop/neopop.dart';

import '../../common/buttons/bold_button.dart';

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
                  return "Enter you mail address";
                }
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              controller: _mail,
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
              child: BoldButton(text: "Log In", onPressed: () async {}),
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(
              "Create An Account",
              style: TextStyle(
                fontSize: 21.sp,
                color: Colors.deepPurple,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(
              "Forgot Password",
              style: TextStyle(
                fontSize: 21.sp,
                color: Colors.deepPurple,
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
      ),
    );
  }
}
