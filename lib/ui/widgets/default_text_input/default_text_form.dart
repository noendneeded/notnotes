import 'package:flutter/material.dart';

class DefaultTextFormWidget extends StatelessWidget {
  const DefaultTextFormWidget({
    super.key,
    // this.initial,
    this.hint,
    this.controller,
    this.isLarge = false,
  });

  final TextEditingController? controller;

  // final String? initial;
  final String? hint;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      ///
      maxLines: isLarge ? 1 : null,
      minLines: isLarge ? 1 : null,

      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),

      controller: controller,

      style: TextStyle(
        fontSize: isLarge ? 24 : 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),

      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: isLarge ? 24 : 16,
          fontWeight: FontWeight.w400,
          color: Colors.black.withValues(alpha: isLarge ? 0.6 : 0.5),
        ),
      ),
    );
  }
}
