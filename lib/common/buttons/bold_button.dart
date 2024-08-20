import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoldButton extends StatefulWidget {
  const BoldButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final FutureOr<void> Function() onPressed;
  final String text;

  @override
  State<BoldButton> createState() => _BoldButtonState();
}

class _BoldButtonState extends State<BoldButton> {
  bool _isLoadig = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _isLoadig,
      child: FilledButton(
        style: FilledButton.styleFrom(
          disabledBackgroundColor: Colors.indigoAccent.withOpacity(.7),
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white,
          backgroundColor: Colors.indigoAccent,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
        ),
        onPressed: _isLoadig
            ? null
            : () async {
                _isLoadig = true;
                setState(() {});
                try {
                  await widget.onPressed();
                } on Exception {
                  _isLoadig = false;
                  setState(() {});
                  rethrow;
                }
                _isLoadig = false;
                setState(() {});
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            AnimatedContainer(
              height: _isLoadig ? 25 : 0,
              width: _isLoadig ? 25.w + 20 : 0,
              padding: const EdgeInsets.only(left: 20),
              duration: const Duration(milliseconds: 200),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 25.w,
                  width: 25.w + 20,
                  child: AnimatedOpacity(
                    opacity: _isLoadig ? 1 : 0,
                    duration: const Duration(microseconds: 400),
                    child: CircularProgressIndicator(
                      color: _isLoadig ? Colors.white : Colors.transparent,
                      strokeAlign: BorderSide.strokeAlignInside,
                      strokeWidth: _isLoadig ? 2 : 0,
                    ),
                  ),
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
