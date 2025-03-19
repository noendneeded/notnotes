import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DefaultPopupItemContent extends StatelessWidget {
  const DefaultPopupItemContent({
    super.key,
    required this.icon,
    required this.title,
    this.color,
  });

  final IconData icon;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///
        Icon(icon, size: 20, color: color),

        const Gap(8),

        Text(title, style: TextStyle(fontSize: 16, color: color)),
      ],
    );
  }
}
