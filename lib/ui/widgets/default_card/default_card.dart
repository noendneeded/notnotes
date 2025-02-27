import 'package:flutter/material.dart';

class DefaultCardWidget extends StatelessWidget {
  const DefaultCardWidget({
    super.key,
    required this.title,
    this.onTap,
    this.onLongPress,
    this.onLongPressStart,
    this.selected = false,
  });

  final String title;
  final Function()? onTap;
  final Function()? onLongPress;
  final void Function(LongPressStartDetails)? onLongPressStart;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onLongPressStart: onLongPressStart,
      child: AnimatedContainer(
        ///
        // height: 32,

        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,

        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).highlightColor
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: selected
              ? Border.all(width: 3, color: Theme.of(context).primaryColor)
              : null,
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
