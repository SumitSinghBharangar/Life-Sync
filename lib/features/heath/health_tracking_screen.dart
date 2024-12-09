import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:life_sync/common/animations/fade_in_animation.dart';
import 'package:life_sync/common/animations/increasing_text.dart';
import 'package:life_sync/common/widgets/app_card.dart';
import 'package:life_sync/common/animations/progress_with_text.dart';
import 'package:life_sync/features/providers/step_count_provider.dart';
import 'package:provider/provider.dart';

class HealthTrackingScreen extends StatelessWidget {
  const HealthTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String photoUrl = FirebaseAuth.instance.currentUser!.photoURL ??
        "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=";

    String _getTodayDate() {
      final now = DateTime.now();
      return DateFormat('EEE, d MMM').format(now);
    }

    final stepCounter = Provider.of<StepCounterProvider>(context);
    double w = (MediaQuery.sizeOf(context).width / 2) - 35;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInAnimation(
              delay: 1,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getTodayDate(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "My Day",
                        style: TextStyle(fontSize: 34),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    decoration: ShapeDecoration(
                      shape: StarBorder(
                        innerRadiusRatio: 0.9,
                        pointRounding: 0.2,
                        points: 10,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(photoUrl),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInAnimation(
                        delay: 1.5,
                        child: AppCard(
                          height: 250,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Walk",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      'assets/icons/footprints.png',
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: ProgressWithText(
                                  value: 2232,
                                  indicatorValue: .78,
                                  title: 'steps',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInAnimation(
                        delay: 2,
                        child: AppCard(
                          height: w,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Sleep",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Iconsax.moon,
                                    color: Colors.deepPurple,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IncreasingText(
                                      7.21,
                                      isSingle: false,
                                      style: TextStyle(fontSize: 28),
                                    ),
                                    Text(
                                      "hours",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInAnimation(
                        delay: 2.5,
                        child: AppCard(
                          height: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text("Water"),
                                  const Spacer(),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      'assets/icons/waterdrop.png',
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Center(
                                  child: Image.asset(
                                    'assets/icons/glass-of-water.png',
                                    height: 50,
                                  ),
                                ),
                              ),
                              const IncreasingText(
                                2,
                                isSingle: true,
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              const Text(
                                "bottles",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: w,
                  child: Column(
                    children: [
                      FadeInAnimation(
                        delay: 1.5,
                        child: AppCard(
                          height: 300,
                          color: Colors.deepPurple,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    "Heart",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Iconsax.heart, color: Colors.white),
                                ],
                              ),
                              Expanded(
                                child: Image.asset(
                                  'assets/images/graph.png',
                                  color: Colors.white,
                                ),
                              ),
                              const IncreasingText(
                                98,
                                isSingle: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  height: .9,
                                ),
                              ),
                              const Text(
                                "bmp",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInAnimation(
                        delay: 2,
                        child: AppCard(
                          height: 225,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Calories",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      'assets/icons/thunderbolt.png',
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: ProgressWithText(
                                  indicatorValue: .78,
                                  title: 'kcal',
                                  value: 553,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const FadeInAnimation(
                        delay: 2.5,
                        child: AppCard(
                          height: 155,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Gym",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Iconsax.speedometer5,
                                    color: Colors.deepPurple,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                "0",
                                style: TextStyle(fontSize: 32),
                              ),
                              Text(
                                "min",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),

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
