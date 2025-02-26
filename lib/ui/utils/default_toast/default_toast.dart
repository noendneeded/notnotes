import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class DefaultToast {
  static show(String message) {
    Fluttertoast.showToast(
      ///
      fontSize: 14,
      backgroundColor: Colors.black,

      msg: message,
    );
  }
}
