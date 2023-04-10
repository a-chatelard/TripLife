import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

TextSpan ClickableTextSpan(String texte, void Function() callback) {
  return TextSpan(
      text: texte, recognizer: TapGestureRecognizer()..onTap = callback);
}
