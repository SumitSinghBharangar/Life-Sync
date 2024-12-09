import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_sync/common/animations/fade_in_animation.dart';
import 'package:life_sync/common/buttons/dynamic_button.dart';
import 'package:life_sync/common/enum/enum.dart';
import 'package:provider/provider.dart';
import '../providers/device_provider.dart';
import '../providers/room_provider.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _deviceName = '';
  DeviceType _selectedDeviceType = DeviceType.light;
  String? _selectedRoom;

  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DeviceProvider>(context);
    final roomProvider = Provider.of<RoomProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              FadeInAnimation(
                delay: 1,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Device Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a device name';
                    }
                    return null;
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  onSaved: (value) {
                    _deviceName = value!;
                  },
                ),
              ),
              const SizedBox(height: 20),
              const FadeInAnimation(
                delay: 1.4,
                child: Text(
                  'Select Device Type',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FadeInAnimation(
                delay: 2,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: DeviceType.values.map((type) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      child: ChoiceChip(
                        label: Text(_getDeviceTypeName(type)),
                        selected: _selectedDeviceType == type,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedDeviceType = type;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const FadeInAnimation(
                delay: 2.4,
                child: Text(
                  'Select Room',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FadeInAnimation(
                delay: 2.7,
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Choose Room',
                  ),
                  value: _selectedRoom,
                  items: roomProvider.rooms.map((room) {
                    return DropdownMenuItem(
                      value: room.name,
                      child: Text(room.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRoom = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a room';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              FadeInAnimation(
                delay: 3,
                child: DynamicButton.fromText(
                    text: "Add Device",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        deviceProvider.addDevice(
                          name: _deviceName,
                          type: _selectedDeviceType,
                          roomName: _selectedRoom!,
                        );
                        Fluttertoast.showToast(
                            msg: "Device added Successfully");
                        Navigator.pop(context);
                      }
                    }),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       _formKey.currentState!.save();

              //       // Add device using provider
              //       deviceProvider.addDevice(
              //           name: _deviceName,
              //           type: _selectedDeviceType,
              //           roomName: _selectedRoom!);

              //       // Show success message
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text('Device added successfully!')),
              //       );

              //       // Navigate back
              //       Navigator.pop(context);
              //     }
              //   },
              //   child: Text('Add Device'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to get readable device type names
  String _getDeviceTypeName(DeviceType type) {
    switch (type) {
      case DeviceType.light:
        return 'Smart Light';
      case DeviceType.thermostat:
        return 'Thermostat';
      case DeviceType.plug:
        return 'Smart Plug';
      case DeviceType.camera:
        return 'Security Camera';
      case DeviceType.speaker:
        return 'Smart Speaker';
    }
  }
}
