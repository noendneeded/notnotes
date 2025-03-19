import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:provider/provider.dart';

class ListAppBarSelectingWidget extends StatelessWidget {
  const ListAppBarSelectingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListViewModel>();

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Text(
        'Выбрано: ${model.noteStates.entries.where((element) => element.value == true).length}',
      ),
    );
  }
}
