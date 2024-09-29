import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _animation = ColorTween(begin: circleColors.first, end: circleColors.first)
        .animate(_controller);

    _controller.addListener(() => setState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
    _pageController.addListener(
      () => setState(
        () {
          page = _pageController.page ?? 0;
        },
      ),
    );
  }

  double page = 0;
  List<Color> circleColors = [
    Colors.green,
    Colors.purple,
    Colors.amber,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                _onboardingText(
                  title: "Welcome to LifeSync",
                  subtitle:
                      'Discover a unified platform for managing your smart home, health, and habits.',
                ),
                _onboardingText(
                  title: "Smart Home Control",
                  subtitle:
                      'Seamlessly manage your smart devices from a single app, making your home smarter and more efficient.',
                ),
                _onboardingText(
                  title: "Health Tracking & Habit Formation",
                  subtitle:
                      'Monitor your health metrics and build positive habits with personalized insights and recommendations.',
                ),
                _onboardingText(
                  title: "Connect with Your Community",
                  subtitle:
                      'Stay informed about local events and activities, and engage with your community like never before.',
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const Spacer(flex: 2),
                SizedBox.square(
                  dimension: size.width - 40,
                  child: Stack(
                    children: [
                      Transform.rotate(
                        angle: page * pi * 1.2,
                        child: _rotatedBoxes(),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: WormEffect(
                    offset: BorderSide.strokeAlignInside,
                    dotColor:
                        (_animation.value ?? Colors.white).withOpacity(.3),
                    activeDotColor: (_animation.value ?? Colors.white),
                    dotHeight: 5,
                  ),
                ),
                const Spacer(flex: 4),
                SizedBox(
                  width: 72,
                  height: 72,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CircularProgressIndicator(
                          color: (_animation.value ?? Colors.white),
                          value: (page + 1) / 4,
                          strokeWidth: 4,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Positioned.fill(
                        top: 5,
                        bottom: 5,
                        left: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () {
                            if (page.round() == 3) {
                              // Utils.go(
                              //     context: context,
                              //     screen: const AuthScreen(),
                              //     replace: true);
                              return;
                            }
                            _controller.dispose();
                            _controller = AnimationController(
                              vsync: this,
                              duration: const Duration(milliseconds: 400),
                            );
                            _animation = ColorTween(
                              begin: _animation.value!,
                              end: circleColors[page.round() + 1],
                            ).animate(_controller)
                              ..addListener(() => setState(() {}));
                            _controller.forward();
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.fastEaseInToSlowEaseOut,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _animation.value,
                            ),
                            child: const Icon(
                              Iconsax.arrow_right_1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.paddingOf(context).bottom + 30),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _onboardingText({
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(flex: 1),
          const Spacer(flex: 3),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: MediaQuery.paddingOf(context).bottom + 150,
          )
        ],
      ),
    );
  }

  Widget _rotatedBoxes() {
    return Stack(
      children: [
        Positioned.fill(
          child: Transform.rotate(
            angle: -page * pi * .2,
            child: Container(
              padding: const EdgeInsets.only(
                top: 50,
                right: 20,
              ),
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: _animation.value!.withOpacity(.1),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _animation.value!.withOpacity(.1),
                      blurRadius: 20,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 5,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Transform.rotate(
            angle: -page * pi * 1.5,
            child: Container(
              padding: const EdgeInsets.only(right: 35, top: 85),
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: _animation.value!.withOpacity(.15),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _animation.value!.withOpacity(.2),
                      blurRadius: 40,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          left: 15,
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: _animation.value!.withOpacity(.4),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _animation.value!.withOpacity(.4),
                  blurRadius: 10,
                  blurStyle: BlurStyle.outer,
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          right: 55,
          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color: _animation.value!.withOpacity(.7),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _animation.value!.withOpacity(.5),
                  blurRadius: 10,
                  blurStyle: BlurStyle.outer,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OnboardingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    Offset p1 = Offset((size.width / 3) / 5, 380);
    Offset p2 = Offset(((size.width / 3) / 2.5) - 20, (size.width / 3) - 80);
    Offset p3 = const Offset(248, 217);
    Offset p4 = Offset((size.width / 3), (size.width / 3) - 20);

    path.lineTo(0, 400);
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    path.quadraticBezierTo(p3.dx, p3.dy, p4.dx, p4.dy);

    path.lineTo(size.width, 0);

    Paint paint = Paint();
    paint.color = Colors.white;

    canvas.drawPath(path, paint);

    Paint paint2 = Paint();
    paint2.color = Colors.red;

    canvas.drawCircle(p1, 3, paint2);
    canvas.drawCircle(p2, 3, paint2);
    canvas.drawCircle(p3, 3, paint2);
    canvas.drawCircle(p4, 3, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
