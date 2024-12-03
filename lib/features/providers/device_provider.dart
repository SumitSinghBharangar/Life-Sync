import 'package:flutter/foundation.dart';
import 'package:life_sync/common/enum/enum.dart';
import 'package:life_sync/common/models/device_model.dart';

class DeviceProvider with ChangeNotifier {
  List<DeviceModel> _devices = [
    DeviceModel(
        id: '1',
        name: 'Living Room Light',
        type: DeviceType.light,
        roomName: 'Living Room'),
    DeviceModel(
        id: '2',
        name: 'Kitchen Plug',
        type: DeviceType.plug,
        roomName: 'Kitchen'),
    DeviceModel(
        id: '3',
        name: 'Bedroom Thermostat',
        type: DeviceType.thermostat,
        roomName: 'Bedroom'),
  ];

  List<DeviceModel> get devices => _devices;

  void addDevice(DeviceModel device) {
    _devices.add(device);
    notifyListeners();
  }

  void toggleDeviceStatus(String deviceId) {
    final device = _devices.firstWhere((d) => d.id == deviceId);
    device.toggleStatus();
    notifyListeners();
  }
}
