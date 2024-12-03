import 'package:life_sync/common/enum/enum.dart';

class DeviceModel {
  final String id;
  final String name;
  final DeviceType type;
  DeviceStatus status;
  bool isConnected;
  String roomName;

  DeviceModel({
    required this.id,
    required this.name,
    required this.type,
    this.status = DeviceStatus.off,
    this.isConnected = false,
    required this.roomName,
  });

  void toggleStatus() {
    status = status == DeviceStatus.on ? DeviceStatus.off : DeviceStatus.on;
  }
}
