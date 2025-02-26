// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'package:notnotes/ui/widgets/default_box_shadow/default_box_shadow.dart';

class DefaultToastification {
  DefaultToastification({
    required this.context,
  });

  final BuildContext context;

  void show(String message) {
    Toastification().show(
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 3),
      boxShadow: [DefaultBoxShadow.get(context)],
      primaryColor: Colors.black,
      showProgressBar: false,
      title: Text(message),
    );
  }
}
