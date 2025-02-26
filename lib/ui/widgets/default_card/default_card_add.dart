import 'package:flutter/material.dart';

class DefaultCardAddWidget extends StatelessWidget {
  const DefaultCardAddWidget({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        ///
        // height: 32,

        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,

        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: null,
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Icon(
              Icons.add,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
