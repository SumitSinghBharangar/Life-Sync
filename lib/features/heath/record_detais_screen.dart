import 'package:flutter/material.dart';
import 'package:life_sync/common/models/health_record_model.dart';

class RecordDetailsScreen extends StatelessWidget {
  final HealthRecord record;

  const RecordDetailsScreen({Key? key, required this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Type', _getRecordTypeTitle(record.type)),
            _buildDetailRow('Value', record.value.toString()),
            _buildDetailRow('Timestamp', record.timestamp.toString()),
            if (record.additionalNotes != null)
              _buildDetailRow('Notes', record.additionalNotes!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  String _getRecordTypeTitle(HealthRecordType type) {
    switch (type) {
      case HealthRecordType.weight:
        return 'Weight';
      case HealthRecordType.bloodPressure:
        return 'Blood Pressure';
      case HealthRecordType.heartRate:
        return 'Heart Rate';
      case HealthRecordType.bloodSugar:
        return 'Blood Sugar';
      case HealthRecordType.sleep:
        return 'Sleep';
      case HealthRecordType.exercise:
        return 'Exercise';
    }
  }
}
