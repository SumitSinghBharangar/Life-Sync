import 'package:flutter/foundation.dart';
import 'package:life_sync/common/models/health_record_model.dart';

class HealthDataProvider with ChangeNotifier {
  List<HealthRecord> _healthRecords = [];

  List<HealthRecord> get healthRecords => _healthRecords;

  void addHealthRecord(HealthRecord record) {
    _healthRecords.add(record);
    notifyListeners();
  }

  void updateHealthRecord(HealthRecord updatedRecord) {
    final index =
        _healthRecords.indexWhere((record) => record.id == updatedRecord.id);
    if (index != -1) {
      _healthRecords[index] = updatedRecord;
      notifyListeners();
    }
  }

  void deleteHealthRecord(String id) {
    _healthRecords.removeWhere((record) => record.id == id);
    notifyListeners();
  }

  // Additional methods for analytics and tracking
  double calculateBMI(double weight, double height) {
    return weight / (height * height);
  }

  List<HealthRecord> getRecordsByType(HealthRecordType type) {
    return _healthRecords.where((record) => record.type == type).toList();
  }
}
