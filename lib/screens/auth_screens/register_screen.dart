import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:life_sync/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:life_sync/common/buttons/bold_button.dart';
import 'package:life_sync/enum/enum.dart';
import 'package:life_sync/screens/home/home_screen.dart';

import '../../utils/utils.dart';

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
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _repass = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _mailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  final FocusNode _repassFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  final _fKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _name.dispose();
    _mail.dispose();
    _pass.dispose();
    _phone.dispose();
    _repass.dispose();
    _mailFocus.dispose();
    _passFocus.dispose();
    _repassFocus.dispose();
    _phoneFocus.dispose();
    _nameFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Form(
          key: _fKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 180.w),
              Text(
                "Create An Account",
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 60.h),
              TextFormField(
                style: TextStyle(
                  fontSize: 20.sp,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your name";
                  }

                  return null;
                },
                controller: _name,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  labelText: "Name..",
                  hintText: 'Enter your Name',
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
                  Utils.fieldfocuschange(context, _nameFocus, _phoneFocus);
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
                  String pattern = r'^[0-9]{10}$';
                  RegExp regExp = RegExp(pattern);
                  if (value == null || value.isEmpty) {
                    return "Enter your Phone";
                  } else if (!regExp.hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
                controller: _phone,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  labelText: "Phone..",
                  hintText: 'Enter your Phone',
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
                  Utils.fieldfocuschange(context, _phoneFocus, _mailFocus);
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
                  Utils.fieldfocuschange(context, _mailFocus, _passFocus);
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              TextFormField(
                obscureText: true,
                style: TextStyle(
                  fontSize: 20.sp,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Password";
                  }
                  if (value.length < 6) {
                    return "Must have at least 6 chars";
                  }
                  return null;
                },
                controller: _pass,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  labelText: "Password..",
                  hintText: 'Enter your Password',
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
                  Utils.fieldfocuschange(context, _passFocus, _repassFocus);
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              TextFormField(
                obscureText: true,
                style: TextStyle(
                  fontSize: 20.sp,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  } else if (value != _pass.text) {
                    return "Password did'n match";
                  }
                  return null;
                },
                controller: _repass,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  labelText: "Password..",
                  hintText: 'Re-enter your password',
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
                child: BlocListener<AuthBloc, AuthState>(
                  listenWhen: (previous, current) =>
                      current.registerStatus != previous.registerStatus,
                  listener: (context, state) async {
                    if (state.registerStatus == RegisterStatus.error) {
                      await showAppDailog(
                        context,
                        iconData: Iconsax.info_circle5,
                        title: "Unable to Login",
                        subTitle:
                            "You are not able to create account at that time",
                      );
                    }
                    if (state.registerStatus == RegisterStatus.success) {
                      Utils.go(
                          context: context,
                          screen: const HomeScreen(),
                          replace: true);
                    }
                  },
                  child: BoldButton(
                      onPressed: () async {
                        if (_fKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                SignUpButtonEvent(
                                  email: _mail.text.trim(),
                                  password: _pass.text.trim(),
                                ),
                              );
                        }
                      },
                      text: "Create An Account"),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.purple,
                      fontSize: 22.sp),
                ),
                onTap: () {
                  widget.pageController.nextPage(
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
