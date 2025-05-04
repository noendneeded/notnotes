import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DefaultPopupItemContent extends StatelessWidget {
  const DefaultPopupItemContent({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.textColor,
  });

  final IconData icon;
  final String title;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///
        Icon(icon, size: 20, color: iconColor),

        const Gap(8),

        Text(title, style: TextStyle(fontSize: 16, color: textColor)),
      ],
    );
  }
}
