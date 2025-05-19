import 'package:flutter/material.dart';

class ListNoteTileTextContentWidget extends StatelessWidget {
  const ListNoteTileTextContentWidget({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 2,

      style: TextStyle(
        fontSize: 14,
        color: Theme.of(context).hintColor,
        overflow: TextOverflow.ellipsis,
      ),

      ///
      text != null && text!.isNotEmpty ? text! : '...',
    );
  }
}
