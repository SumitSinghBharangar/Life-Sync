import 'package:flutter/material.dart';
import 'package:life_sync/common/models/health_record_model.dart';
import 'package:life_sync/features/heath/add_record_screen.dart';
import 'package:life_sync/features/heath/record_detais_screen.dart';
import 'package:life_sync/features/providers/health_data_provider.dart';
import 'package:provider/provider.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tracker'),
        centerTitle: true,
      ),
      body: Consumer<HealthDataProvider>(
        builder: (context, healthProvider, child) {
          return ListView.builder(
            itemCount: healthProvider.healthRecords.length,
            itemBuilder: (context, index) {
              final record = healthProvider.healthRecords[index];
              return ListTile(
                title: Text(_getRecordTitle(record)),
                subtitle: Text('${record.timestamp}'),
                trailing: Text('${record.value}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecordDetailsScreen(record: record),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRecordScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _getRecordTitle(HealthRecord record) {
    switch (record.type) {
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
