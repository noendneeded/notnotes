import 'package:flutter/material.dart';

abstract class DefaultBoxShadow {
  static BoxShadow get(BuildContext context) {
    return BoxShadow(
      color: Theme.of(context).highlightColor,
      blurRadius: 6,
      spreadRadius: 1,
      offset: Offset(0, 4),
    );
  }
}
