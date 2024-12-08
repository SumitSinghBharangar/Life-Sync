import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:io' show Platform;

class StepCounterProvider extends ChangeNotifier {
  int _steps = 0;
  String _status = 'Unknown';
  StreamSubscription<StepCount>? _stepCountSubscription;
  bool _isSupported = true;

  // ignore: constant_identifier_names
  static const double CALORIES_PER_STEP = 0.04; // Average estimate
  // ignore: constant_identifier_names
  static const double WEIGHT_KG = 70.0;

  int get steps => _steps;
  String get status => _status;
  bool get isSupported => _isSupported;

  StepCounterProvider() {
    _initializePedometer();
  }

  void _initializePedometer() {
    // Listen to step count stream
    if (Platform.isAndroid || Platform.isIOS) {
      _stepCountSubscription = Pedometer.stepCountStream.listen(
        _onStepCount,
        onError: _onError,
        cancelOnError: true,
      );
    } else {
      _isSupported = false;
      print('Pedometer not supported on this platform');
    }
    Pedometer.stepCountStream.listen(
      _onStepCount,
      onError: _onError,
    );

    // Listen to pedestrian status stream
    Pedometer.pedestrianStatusStream.listen(
      _onPedestrianStatus,
      onError: _onError,
    );
  }

  void _onStepCount(StepCount event) {
    _steps = event.steps;
    notifyListeners();
  }

  void _onPedestrianStatus(PedestrianStatus event) {
    _status = event.status;
    notifyListeners();
  }

  double calculateCaloriesBurned() {
    // Simple calorie calculation based on steps
    return _steps * CALORIES_PER_STEP;
  }

  void _onError(dynamic error) {
    _status = 'Sensor Error';
    notifyListeners();
  }

  @override
  void dispose() {
    _stepCountSubscription?.cancel();
    super.dispose();
  }
}
