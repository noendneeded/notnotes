import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:provider/provider.dart';

class ListFloatingActionButtonWidget extends StatelessWidget {
  const ListFloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListViewModel>();

    return FloatingActionButton(
      ///
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).scaffoldBackgroundColor,

      onPressed: () => model.noteStates.containsValue(true)
          ? model.deleteNotes()
          : model.openNotePageWithCategory(),

      child: AnimatedSwitcher(
        ///
        duration: const Duration(milliseconds: 150),

        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),

        child: model.noteStates.containsValue(true)
            ? Icon(
                Icons.delete_rounded,
                key: const ValueKey('delete'),
                size: 32,
              )
            : Icon(
                Icons.add_rounded,
                key: const ValueKey('add'),
                size: 32,
              ),
      ),
    );
  }
}
