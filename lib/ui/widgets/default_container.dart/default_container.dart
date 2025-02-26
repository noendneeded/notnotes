import 'package:flutter/material.dart';
import 'package:notnotes/ui/widgets/default_box_shadow/default_box_shadow.dart';

class DefaultContainerWidget extends StatelessWidget {
  const DefaultContainerWidget({
    super.key,
    required this.context,
    required this.child,
  });

  final BuildContext context;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      ///
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).scaffoldBackgroundColor,

        ///
        boxShadow: [DefaultBoxShadow.get(context)],
      ),

      child: child,
    );
  }
}
