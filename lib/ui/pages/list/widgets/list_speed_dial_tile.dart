import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ListSpeedDialTileWidget extends StatelessWidget {
  const ListSpeedDialTileWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        ///
        height: 56,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.grey.shade900,
        ),

        padding: EdgeInsets.symmetric(horizontal: 16),

        child: Row(
          children: [
            ///
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            if (icon != null) ...{
              const Gap(6),
              Icon(
                icon,
                size: 24,
                color: Colors.white,
              ),
            }
          ],
        ),
      ),
    );
  }
}
