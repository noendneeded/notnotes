import 'package:flutter/material.dart';

class DefaultTextFieldWidget extends StatelessWidget {
  const DefaultTextFieldWidget({
    super.key,
    this.controller,
    this.hint,
  });

  final TextEditingController? controller;

  final String? hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      ///
      maxLines: 1,

      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),

      controller: controller,

      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),

      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
