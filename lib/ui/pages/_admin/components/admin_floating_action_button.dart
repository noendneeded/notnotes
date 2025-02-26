import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminFloatingActionButtonWidget extends StatelessWidget {
  const AdminFloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      ///
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).scaffoldBackgroundColor,

      onPressed: () => context.pop(true),

      child: Icon(Icons.check_rounded, size: 32),
    );
  }
}
