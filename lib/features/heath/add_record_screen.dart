import 'package:flutter/material.dart';
import 'package:life_sync/common/models/health_record_model.dart';
import 'package:provider/provider.dart';
import '../providers/health_data_provider.dart';

class AddRecordScreen extends StatefulWidget {
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  HealthRecordType _selectedType = HealthRecordType.weight;
  final _valueController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Health Record'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<HealthRecordType>(
                value: _selectedType,
                items: HealthRecordType.values
                    .map((type) => DropdownMenuItem(
                          child: Text(_getRecordTypeTitle(type)),
                          value: type,
                        ))
                    .toList(),
                onChanged: (type) {
                  setState(() {
                    _selectedType = type!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Record Type',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Value',
                  hintText: 'Enter your measurement',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Additional Notes',
                  hintText: 'Optional notes',
                ),
                maxLines: 3,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveRecord,
                child: Text('Save Record'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveRecord() {
    if (_formKey.currentState!.validate()) {
      final newRecord = HealthRecord(
        type: _selectedType,
        value: double.parse(_valueController.text),
        additionalNotes:
            _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      Provider.of<HealthDataProvider>(context, listen: false)
          .addHealthRecord(newRecord);

      Navigator.pop(context);
    }
  }

  String _getRecordTypeTitle(HealthRecordType type) {
    switch (type) {
      case HealthRecordType.weight:
        return 'Weight (kg)';
      case HealthRecordType.bloodPressure:
        return 'Blood Pressure (mmHg)';
      case HealthRecordType.heartRate:
        return 'Heart Rate (bpm)';
      case HealthRecordType.bloodSugar:
        return 'Blood Sugar (mg/dL)';
      case HealthRecordType.sleep:
        return 'Sleep (hours)';
      case HealthRecordType.exercise:
        return 'Exercise (minutes)';
    }
  }

  @override
  void dispose() {
    _valueController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
