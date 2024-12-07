import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:life_sync/features/auth/sevices/auth_service.dart';

import 'package:life_sync/features/providers/device_provider.dart';
import 'package:life_sync/features/providers/health_data_provider.dart';
import 'package:life_sync/features/providers/healthprovider.dart';
import 'package:life_sync/features/providers/room_provider.dart';
import 'package:life_sync/features/providers/step_count_provider.dart';
import 'package:life_sync/splash_screen.dart';
import 'package:life_sync/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:life_sync/firebase_options.dart';

import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Permissions.requestActivityRecognitionPermission();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) => DeviceProvider()),
        ChangeNotifierProvider(create: (_) => RoomProvider()),
        ChangeNotifierProvider(create: (context) => HealthDataProvider()),
        ChangeNotifierProvider(create: (_) => HealthDataProvider1()),
        ChangeNotifierProvider(create: (_) => StepCounterProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              scrolledUnderElevation: 0,
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 244, 255, 244),
              iconTheme: const IconThemeData(
                size: 30,
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                fontFamily: GoogleFonts.beVietnamPro().fontFamily,
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            fontFamily: GoogleFonts.inter().fontFamily,
            bottomAppBarTheme: const BottomAppBarTheme(
              color: Color.fromARGB(255, 244, 255, 244),
            ),
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              surface: Colors.white,
            ),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
