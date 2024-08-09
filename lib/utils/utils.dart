import 'package:flutter/cupertino.dart';
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
