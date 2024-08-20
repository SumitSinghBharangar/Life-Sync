import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_sync/screens/auth_screens/auth_screen.dart';
import 'package:life_sync/screens/auth_screens/register_screen.dart';
import 'package:life_sync/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await _auth.signOut();
                Utils.go(
                    // ignore: use_build_context_synchronously
                    context: context,
                    screen: const AuthScreen(),
                    replace: true);
                Fluttertoast.showToast(msg: "Succesfly logout");
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
    );
  }
}
