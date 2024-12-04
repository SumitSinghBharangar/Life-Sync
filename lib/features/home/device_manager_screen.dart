import 'package:flutter/material.dart';
import 'package:life_sync/common/models/device_model.dart';
import 'package:life_sync/features/providers/device_provider.dart';
import 'package:provider/provider.dart';

class DeviceManagerScreen extends StatelessWidget {
  const DeviceManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Manager'),
      ),
      body: Consumer<DeviceProvider>(
        builder: (context, deviceProvider, child) {
          return ListView.builder(
            itemCount: deviceProvider.devices.length,
            itemBuilder: (context, index) {
              final device = deviceProvider.devices[index];
              return ListTile(
                title: Text(device.name),
                subtitle: Text(
                    '${device.type.toString().split('.').last} in ${device.roomName}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Edit Icon
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Show edit dialog
                        _showEditDeviceDialog(context, device);
                      },
                    ),
                    // Delete Icon
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Show delete confirmation
                        _showDeleteConfirmation(context, device.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showEditDeviceDialog(BuildContext context, DeviceModel device) {
    final nameController = TextEditingController(text: device.name);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Device'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Device Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Update device
              Provider.of<DeviceProvider>(context, listen: false).updateDevice(
                device.id,
                name: nameController.text,
              );
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String deviceId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this device?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Delete device
              Provider.of<DeviceProvider>(context, listen: false)
                  .deleteDevice(deviceId);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
