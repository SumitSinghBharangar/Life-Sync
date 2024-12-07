import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_sync/common/buttons/scale_button.dart';

import 'package:life_sync/features/home/add_device_screen.dart';
import 'package:life_sync/features/home/add_room_screen.dart';
import 'package:life_sync/features/home/device_manager_screen.dart';
import 'package:life_sync/utils/utils.dart';

class QuickActionWidget extends StatelessWidget {
  const QuickActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildQuickActionButton(
                icon: Icons.add_circle_outline,
                label: 'Add Device',
                onTap: () {
                  Utils.go(context: context, screen: const AddDeviceScreen());
                },
              ),
              SizedBox(
                width: 10.w,
              ),
              _buildQuickActionButton(
                icon: Icons.meeting_room_outlined,
                label: 'Add Rooms',
                onTap: () {
                  Utils.go(context: context, screen: const AddRoomScreen());
                },
              ),
              SizedBox(
                width: 10.w,
              ),
              _buildQuickActionButton(
                icon: Icons.settings,
                label: 'Manage Devices',
                onTap: () {
                  Utils.go(
                    context: context,
                    screen: const DeviceManagerScreen(),
                  );
                },
              ),
              SizedBox(
                width: 10.w,
              ),
              _buildQuickActionButton(
                icon: Icons.wifi,
                label: 'Check Connection',
                onTap: () {
                  // Implement connection check logic
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ScaleButton(
      onTap: onTap,
      scale: 0.97,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(9),
          color: Colors.blue.shade100,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(
                  12.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: Colors.blue),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
