import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_sync/screens/auth_screens/forgot_password.dart';

import 'login_screen.dart';
import 'register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.offset >= 0 &&
          _pageController.offset <= MediaQuery.sizeOf(context).width) {
        _scrollController.jumpTo(_pageController.offset);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        width: size.width * 3,
        height: size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: size.width * 3,
                  height: size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 15.w,
                        top: -125.w,
                        child: _circle(
                            Colors.indigoAccent.withOpacity(.8), 220.w, false),
                      ),
                      Positioned(
                        left: -160.w,
                        top: -160.w,
                        child:
                            _circle(Colors.indigoAccent.shade400, 300.w, true),
                      ),
                      Positioned(
                        right: 15.w,
                        top: -125.w,
                        child: _circle(
                            Colors.indigoAccent.withOpacity(.8), 220.w, false),
                      ),
                      Positioned(
                        right: -160.w,
                        top: -160.w,
                        child:
                            _circle(Colors.indigoAccent.shade400, 300.w, true),
                      ),
                      AnimatedPositioned(
                        bottom: -MediaQuery.viewInsetsOf(context).bottom * 1.3,
                        left: 0,
                        right: 0,
                        top: 0,
                        duration: const Duration(milliseconds: 0),
                        child: Stack(
                          children: [
                            Positioned(
                              right: (size.width / 2) + 100.w,
                              bottom: -50.w,
                              child: _circle(
                                  Colors.indigoAccent.withOpacity(.8),
                                  220.w,
                                  false),
                            ),
                            Positioned(
                              right: (size.width / 2) + 100.w,
                              bottom: -200.w,
                              child: _circle(
                                  Colors.indigoAccent.shade400, 300.w, false),
                            ),
                            Positioned(
                              right: (size.width / 2) + 75 / 2.w,
                              bottom: -200.w,
                              child: _circle(
                                  Colors.indigoAccent.shade400, 300.w, false),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  LoginScreen(
                    pageController: _pageController,
                  ),
                  RegisterScreen(
                    pageController: _pageController,
                  ),
                  ForgotPasswordScreen(pageController: _pageController)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _circle(Color color, double radius, bool hasGlow) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: !hasGlow
            ? null
            : [
                BoxShadow(
                  color: color,
                  blurRadius: 20,
                ),
              ],
      ),
    );
  }
}
