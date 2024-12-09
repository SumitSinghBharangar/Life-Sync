import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:life_sync/common/buttons/scale_button.dart';

import 'package:life_sync/features/heath/health_tracking_screen.dart';
import 'package:life_sync/features/home/smart_home_screen.dart';
import 'package:life_sync/features/profile/profile_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({
    super.key,
  });

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final List<Widget> screenList = [
    const SmartHomeScreen(),
    const HealthTrackingScreen(),
  ];
  int selectedIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const SmartHomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ScaleButton(
                scale: .97,
                onTap: () {
                  setState(() {
                    currentScreen = const SmartHomeScreen();
                    selectedIndex = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.home,
                      color: selectedIndex == 0 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        color: selectedIndex == 0 ? Colors.blue : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              ScaleButton(
                scale: .97,
                onTap: () {
                  setState(() {
                    currentScreen = HealthTrackingScreen();
                    selectedIndex = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.health_and_safety,
                      color: selectedIndex == 1 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      "Health Tack",
                      style: TextStyle(
                        color: selectedIndex == 1 ? Colors.blue : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              ScaleButton(
                scale: .97,
                onTap: () {
                  setState(() {
                    currentScreen = const UserProfilePage();
                    selectedIndex = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: selectedIndex == 2 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      "profile",
                      style: TextStyle(
                        color: selectedIndex == 2 ? Colors.blue : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
