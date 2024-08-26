import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_sync/bloc/auth/auth_bloc.dart';

import '../../common/buttons/bold_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key, required this.pageController});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
  final PageController pageController;
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _mail = TextEditingController();
  final FocusNode _mailFocus = FocusNode();
  final _fKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _mail.dispose();
    _mailFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 45.w),
      child: Form(
          key: _fKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400.h,
              ),
              Text(
                "Reset Your Password",
                style: TextStyle(
                    fontSize: 27.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.purple),
              ),
              SizedBox(
                height: 60.h,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20.sp,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Email";
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
                  hintText: 'Enter Registered Email',
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
                onFieldSubmitted: (value) {},
              ),
              SizedBox(
                height: 60.h,
              ),
              FractionallySizedBox(
                widthFactor: 1,
                child: BoldButton(
                    onPressed: () {
                      if (_fKey.currentState!.validate()) {
                        context
                            .read<AuthBloc>()
                            .add(PasswordResetEvent(fmail: _mail.text.trim()));
                        Fluttertoast.showToast(
                            msg: "Password reset email send to your Mail");
                      }
                    },
                    child: Text("Submit"),),
              ),
              SizedBox(
                height: 60.h,
              ),
              GestureDetector(
                child: Text(
                  "Sign In?",
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.purple),
                ),
                onTap: () {
                  widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                },
              )
            ],
          )),
    );
  }
}
