import 'package:flutter/material.dart';

class DefaultPopupWidget<T> extends StatelessWidget {
  const DefaultPopupWidget({
    super.key,
    required this.itemBuilder,
    this.onSelected,
  });

  final List<PopupMenuEntry<T>> itemBuilder;
  final Function(T)? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      ///
      elevation: 6,
      color: Theme.of(context).scaffoldBackgroundColor,

      icon: Icon(Icons.more_vert_rounded),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      onSelected: onSelected,

      itemBuilder: (context) => itemBuilder,
    );
  }
}
