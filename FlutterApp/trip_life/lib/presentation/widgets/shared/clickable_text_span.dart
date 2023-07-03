import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClickableTextSpan extends TextSpan {
  ClickableTextSpan({required this.texte, required this.callback})
      : super(
            text: texte, recognizer: TapGestureRecognizer()..onTap = callback);

  final String texte;
  final void Function() callback;
}
