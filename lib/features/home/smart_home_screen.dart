import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_sync/features/auth/screens/complete_profile.dart';
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
                  Text(
                    "Manage Home",
                    style: TextStyle(
                      fontSize: 23.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
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
                  )
                      .animate(
                        delay: 200.ms,
                      )
                      .slideX(
                          begin: 0.25,
                          end: 0,
                          duration: 0.5.seconds,
                          curve: Curves.easeInOut)
                      .fadeIn(duration: 0.5.seconds, curve: Curves.easeInOut),
                  QuickActionWidget(),
                  SizedBox(
                    height: 10.h,
                  ),
                  const RoomListWidget(),
                  SizedBox(
                    height: 20.h,
                  ),
                  const DeviceGridWidget(),
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
