import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoldButton extends StatefulWidget {
  const BoldButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final FutureOr<void> Function() onPressed;
  final Widget child;

  @override
  State<BoldButton> createState() => _BoldButtonState();
}

class _BoldButtonState extends State<BoldButton> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: FilledButton(
        style: FilledButton.styleFrom(
          disabledBackgroundColor: Colors.indigoAccent.withOpacity(.7),
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white,
          backgroundColor: Colors.indigoAccent,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: widget.onPressed,
        child: Center(child: widget.child),
      ),
    );
  }
}
