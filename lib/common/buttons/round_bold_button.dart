import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundBoldButton extends StatefulWidget {
  const RoundBoldButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final FutureOr<void> Function() onPressed;
  final Widget child;

  @override
  State<RoundBoldButton> createState() => _RoundBoldButtonState();
}

class _RoundBoldButtonState extends State<RoundBoldButton> {
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
            borderRadius: BorderRadius.circular(10),
          ),
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
            widget.child,
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
            // AnimatedCrossFade(
            //   firstChild: SizedBox(width: 0, height: 25.w),
            //   secondChild: SizedBox(
            //     width: 30.w,
            //     height: 25.w,
            //     child: Align(
            //       alignment: Alignment.centerRight,
            //       child: SizedBox(
            //         width: 20.w,
            //         height: 20.w,
            //         child: AnimatedOpacity(
            //           duration: const Duration(milliseconds: 300),
            //           opacity: _isLoadig ? 1 : 0,
            //           child: const CircularProgressIndicator(
            //             color: Colors.white,
            //             strokeAlign: BorderSide.strokeAlignInside,
            //             strokeWidth: 2,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            //   crossFadeState: _isLoadig
            //       ? CrossFadeState.showSecond
            //       : CrossFadeState.showFirst,
            //   duration: const Duration(milliseconds: 300),
            // ),
          ],
        ),
      ),
    );
  }
}
