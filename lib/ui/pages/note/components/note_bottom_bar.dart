import 'package:flutter/material.dart';

class NoteBottomBarWidget extends StatelessWidget {
  const NoteBottomBarWidget({super.key, required this.isUpdated});

  final bool isUpdated;

  @override
  Widget build(BuildContext context) {
    return Text(
      isUpdated ? 'Изменено ' : 'Создано ',
    );
  }
}
