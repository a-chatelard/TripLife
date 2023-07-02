import 'package:flutter/material.dart';

class LoaderOverlayEntry {
  static OverlayEntry build() {
    return OverlayEntry(builder: (context) {
      return Scaffold(
          backgroundColor: Colors.grey[600]!.withOpacity(0.5),
          body: const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.green)));
    });
  }
}
