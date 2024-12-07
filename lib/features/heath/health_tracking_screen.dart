import 'package:flutter/material.dart';
import 'package:life_sync/features/providers/step_count_provider.dart';
import 'package:provider/provider.dart';

class HealthTrackingScreen extends StatelessWidget {
  const HealthTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stepCounter = Provider.of<StepCounterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tracker'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section for Step Counter
            Text(
              'Step Counter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Text(
                    'Steps Taken',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${stepCounter.steps}',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Status: ${stepCounter.status}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Divider(height: 30, thickness: 1),
            // Additional Health Metrics (Placeholder for Future Enhancements)
            Text(
              'Other Health Metrics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '• Heart Rate: Coming Soon',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              '• Calories Burned: Coming Soon',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              '• Sleep Tracker: Coming Soon',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
