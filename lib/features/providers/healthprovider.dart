import 'package:flutter/material.dart';
import 'package:life_sync/common/models/health_metric_model.dart';

class HealthDataProvider1 extends ChangeNotifier {
  List<HealthMetric> _metrics = [
    HealthMetric(name: 'Steps', value: '0', icon: Icons.directions_walk),
    HealthMetric(name: 'Heart Rate', value: '0 bpm', icon: Icons.favorite),
    HealthMetric(
        name: 'Calories Burned',
        value: '0 kcal',
        icon: Icons.local_fire_department),
  ];

  List<HealthMetric> get metrics => _metrics;

  void updateMetric(String name, String newValue) {
    final metricIndex = _metrics.indexWhere((metric) => metric.name == name);
    if (metricIndex != -1) {
      _metrics[metricIndex] = HealthMetric(
        name: _metrics[metricIndex].name,
        value: newValue,
        icon: _metrics[metricIndex].icon,
      );
      notifyListeners();
    }
  }
}
