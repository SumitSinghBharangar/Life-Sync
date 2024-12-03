import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_sync/features/auth/screens/complete_profile.dart';

class QuickActionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  // Implement add device logic
                },
              ),
              _buildQuickActionButton(
                icon: Icons.settings,
                label: 'Manage Devices',
                onTap: () {
                  // Implement manage devices logic
                },
              ),
              _buildQuickActionButton(
                icon: Icons.wifi,
                label: 'Check Connection',
                onTap: () {
                  // Implement connection check logic
                },
              ),
              _buildQuickActionButton(
                icon: Icons.meeting_room_outlined,
                label: 'Add Rooms',
                onTap: () {
                  // Implement add rooms logic
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(
                12.h,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: Colors.blue),
            ),
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
    );
  }
}
