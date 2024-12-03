import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_sync/features/widgets/device_grid_screen.dart';
import 'package:life_sync/features/widgets/quick_action_widget.dart';
import 'package:life_sync/features/widgets/room_list_widget.dart';

class SmartHomeScreen extends StatefulWidget {
  const SmartHomeScreen({super.key});

  @override
  State<SmartHomeScreen> createState() => _SmartHomeScreenState();
}

class _SmartHomeScreenState extends State<SmartHomeScreen> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manage Home",
                  style: TextStyle(
                    fontSize: 18.sp,
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
                RoomListWidget(),
                SizedBox(
                  height: 20.h,
                ),
                DeviceGridWidget(),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
