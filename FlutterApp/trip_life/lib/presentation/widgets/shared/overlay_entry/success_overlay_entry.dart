import 'package:flutter/material.dart';

class SuccessOverlayEntry {
  static OverlayEntry build(Animation<double> sizeFactorAnimation) {
    return OverlayEntry(builder: (context) {
      return Scaffold(
          backgroundColor: Colors.grey[600]!.withOpacity(0.5),
          body: Center(
              child: AnimatedBuilder(
                  animation: sizeFactorAnimation,
                  builder: (_, child) => ClipRect(
                        child: Align(
                          alignment: Alignment.center,
                          heightFactor: null,
                          widthFactor: sizeFactorAnimation.value,
                          child: child,
                        ),
                      ),
                  child: const Icon(Icons.check,
                      color: Color.fromARGB(255, 57, 217, 45), size: 80))));
    });
  }
}
