import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:life_sync/common/animations/fade_in_animation.dart';
import 'package:life_sync/features/auth/screens/complete_profile.dart';
import 'package:life_sync/features/onbording_screens/on_bording_screen.dart';
import 'package:life_sync/features/widgets/device_grid_screen.dart';
import 'package:life_sync/features/widgets/quick_action_widget.dart';
import 'package:life_sync/features/widgets/room_list_widget.dart';
import 'package:life_sync/utils/utils.dart';

class SmartHomeScreen extends StatefulWidget {
  const SmartHomeScreen({super.key});

  @override
  State<SmartHomeScreen> createState() => _SmartHomeScreenState();
}

class _SmartHomeScreenState extends State<SmartHomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUser();
    });
    super.initState();
  }

  _fetchUser() async {
    FirebaseAuth.instance.currentUser?.displayName == null
        ? Utils.go(
            context: context,
            screen: const UserCompleteProfile(),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              transform: GradientRotation(pi * .4),
              colors: [
                Color.fromARGB(255, 229, 227, 238),
                Color.fromARGB(255, 163, 157, 201),
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 22.w,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.paddingOf(context).top + 20.h,
                  ),
                  FadeInAnimation(
                    delay: 1,
                    child: Row(
                      children: [
                        Text(
                          "Manage Home",
                          style: TextStyle(
                            fontSize: 23.sp,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            if (context.mounted) {
                              Utils.go(
                                context: context,
                                screen: const OnbordingScreen(),
                                replace: true,
                              );
                              Fluttertoast.showToast(
                                  msg: "You have successfully logout");
                            }
                          },
                          icon: const Icon(
                            Iconsax.logout,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  FadeInAnimation(
                    delay: 1.5,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text(
                          "Quick Actions",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const FadeInAnimation(
                    delay: 1.5,
                    child: QuickActionWidget(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const FadeInAnimation(
                    delay: 2,
                    child: RoomListWidget(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const FadeInAnimation(
                    delay: 2.5,
                    child: DeviceGridWidget(),
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
