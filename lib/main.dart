import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_sync/bloc/auth/auth_bloc.dart';

import 'package:life_sync/firebase_options.dart';
import 'package:life_sync/repositories/auth_repo.dart';
import 'package:life_sync/screens/splash/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'common/constants/appcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(authRepo: AuthRepo()),
        ),
      ],
      child: ScreenUtilInit(
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
                seedColor: AppColors.greenColor,
                surface: Colors.white,
              ),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

//  updating the font style in main.dart
