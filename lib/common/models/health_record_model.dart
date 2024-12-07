import 'package:firebase_auth/firebase_auth.dart';

enum HealthRecordType {
  weight,
  bloodPressure,
  heartRate,
  bloodSugar,
  sleep,
  exercise
}

class HealthRecord {
  final String id;
  final HealthRecordType type;
  final DateTime timestamp;
  final double value;
  final String? additionalNotes;

  HealthRecord({
    String? id,
    required this.type,
    DateTime? timestamp,
    required this.value,
    this.additionalNotes,
  })  : id = FirebaseAuth.instance.currentUser!.uid,
        timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString(),
      'timestamp': timestamp.toIso8601String(),
      'value': value,
      'additionalNotes': additionalNotes,
    };
  }

  factory HealthRecord.fromJson(Map<String, dynamic> json) {
    return HealthRecord(
      id: json['id'],
      type: HealthRecordType.values
          .firstWhere((e) => e.toString() == json['type']),
      timestamp: DateTime.parse(json['timestamp']),
      value: json['value'],
      additionalNotes: json['additionalNotes'],
    );
  }
}
