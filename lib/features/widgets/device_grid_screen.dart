import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_sync/common/enum/enum.dart';
import 'package:life_sync/features/auth/screens/complete_profile.dart';
import 'package:life_sync/utils/utils.dart';
import 'package:provider/provider.dart';
import '../providers/device_provider.dart';

class DeviceGridWidget extends StatelessWidget {
  const DeviceGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DeviceProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Devices',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        // const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: deviceProvider.devices.length,
          itemBuilder: (context, index) {
            final device = deviceProvider.devices[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _getDeviceIcon(device.type),
                        Switch(
                          value: device.status == DeviceStatus.on,
                          onChanged: (_) {
                            showLoading(context);
                            Future.delayed(const Duration(seconds: 10), () {
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Connection Time out");
                            });
                            deviceProvider.toggleDeviceStatus(device.id);
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          device.roomName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _getDeviceIcon(DeviceType type) {
    switch (type) {
      case DeviceType.light:
        return const Icon(Icons.lightbulb_outline,
            size: 30, color: Colors.amber);
      case DeviceType.thermostat:
        return const Icon(Icons.thermostat, size: 30, color: Colors.blue);
      case DeviceType.plug:
        return const Icon(Icons.power, size: 30, color: Colors.green);
      case DeviceType.camera:
        return const Icon(Icons.camera_alt_outlined,
            size: 30, color: Colors.purple);
      case DeviceType.speaker:
        return const Icon(Icons.speaker, size: 30, color: Colors.red);
    }
  }
}
