import 'package:flutter/material.dart';

class AdminAppBarWidget extends StatelessWidget {
  const AdminAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///
        Text(
          'Администрирование',
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
