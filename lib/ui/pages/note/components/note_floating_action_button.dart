import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/note/note_vm.dart';
import 'package:provider/provider.dart';

class NoteFloatingActionButtonWidget extends StatelessWidget {
  const NoteFloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NoteViewModel>();

    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).scaffoldBackgroundColor,

      onPressed: () => model.createOrUpdateNote(),

      ///
      child: Icon(
        Icons.check_rounded,
        size: 32,
      ),
    );
  }
}
