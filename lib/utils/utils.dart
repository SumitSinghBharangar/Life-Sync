import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  static void fieldfocuschange(
      BuildContext context, FocusNode current, FocusNode nextfocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextfocus);
  }

  static go(
      {required BuildContext context,
      required dynamic screen,
      bool replace = false}) {
    replace
        ? Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => screen,
            ))
        : Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => screen,
            ));
  }

  static Future<bool> requestPermission() async {
    var status1 = await Permission.bluetooth.status;
    if (status1.isGranted) {
      return true;
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.audio,
        Permission.manageExternalStorage,
        Permission.bluetoothScan,
        Permission.bluetooth,
        Permission.bluetoothAdvertise,
        Permission.bluetoothConnect,
      ].request();
      var temp1 = await Permission.bluetoothAdvertise.status;
      var temp2 = await Permission.bluetooth.status;
      if (temp1.isGranted && temp2.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}

Future<bool> showAppDailog(
  BuildContext context, {
  required IconData iconData,
  Color color = Colors.red,
  required String title,
  required String subTitle,
}) async {
  bool res = false;
  showCupertinoDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => _InfoDailogContent(
      onAction: (res) {
        res = res;
      },
      iconData: iconData,
      color: color,
      subTitle: subTitle,
      title: title,
    ),
  );

  return res;
}

class _InfoDailogContent extends StatelessWidget {
  const _InfoDailogContent(
      {required this.onAction,
      required this.iconData,
      required this.color,
      required this.title,
      required this.subTitle});

  final Function(bool res) onAction;
  final IconData iconData;
  final Color color;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: CupertinoAlertDialog(
          content: Center(
            child: Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.close_circle5,
                      color: Colors.red,
                      size: 50.sp,
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     Text(
                      subTitle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                onAction(true);
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                onAction(false);
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }
}
