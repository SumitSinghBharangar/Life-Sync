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

  void addDevice(
      {required String name,
      required DeviceType type,
      required String roomName}) {
    // Generate a unique ID
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    // Create new device
    final newDevice =
        DeviceModel(id: id, name: name, type: type, roomName: roomName);

    // Add device to the list
    _devices.add(newDevice);
    notifyListeners();
  }

  void deleteDevice(String id) {
    _devices.removeWhere((device) => device.id == id);
    notifyListeners();
  }

  void updateDevice(String id,
      {String? name, DeviceType? type, String? roomName}) {
    final index = _devices.indexWhere((device) => device.id == id);
    if (index != -1) {
      _devices[index] = DeviceModel(
        id: id,
        name: name ?? _devices[index].name,
        type: type ?? _devices[index].type,
        roomName: roomName ?? _devices[index].roomName,
        status: _devices[index].status,
        isConnected: _devices[index].isConnected,
      );
      notifyListeners();
    }
  }

  void toggleDeviceStatus(String deviceId) {
    final device = _devices.firstWhere((d) => d.id == deviceId);
    device.toggleStatus();
    notifyListeners();
  }
}
