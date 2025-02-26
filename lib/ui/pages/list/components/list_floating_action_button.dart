import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:provider/provider.dart';

class ListFloatingActionButtonWidget extends StatelessWidget {
  const ListFloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListViewModel>();

    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).scaffoldBackgroundColor,

      onPressed: () => model.openNotePage(),

      ///
      child: Icon(
        Icons.add_rounded,
        size: 32,
      ),
    );
  }
}
