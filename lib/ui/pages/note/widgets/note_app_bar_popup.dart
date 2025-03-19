import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/note/note_vm.dart';
import 'package:notnotes/ui/pages/note/widgets/note_dialog.dart';
import 'package:notnotes/ui/utils/default_toast/default_toast.dart';
import 'package:notnotes/ui/widgets/default_popup/default_popup.dart';
import 'package:notnotes/ui/widgets/default_popup/default_popup_item_content.dart';
import 'package:provider/provider.dart';

class NoteAppBarPopupWidget extends StatelessWidget {
  const NoteAppBarPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NoteViewModel>();

    return DefaultPopupWidget(
      ///
      itemBuilder: model.isLoading
          ? []
          : <PopupMenuEntry<String>>[
              ///
              PopupMenuItem<String>(
                value: 'create_notification',
                child: DefaultPopupItemContent(
                  icon: Icons.alarm_rounded,
                  title: 'Создать напоминание',
                ),
              ),

              PopupMenuDivider(),

              PopupMenuItem<String>(
                value: 'add_to_category',
                child: DefaultPopupItemContent(
                  icon: Icons.label_outline_rounded,
                  title: 'Изменить категорию',
                ),
              ),

              PopupMenuDivider(),

              PopupMenuItem<String>(
                value: 'delete',
                child: DefaultPopupItemContent(
                  icon: Icons.delete_rounded,
                  title: 'Удалить заметку',
                  color: Colors.red.shade700,
                ),
              ),
            ],

      onSelected: (p0) {
        switch (p0) {
          case 'create_notification':
            DefaultToast.show('В разработке...');
            break;
          case 'add_to_category':
            NoteDialog.changeNoteCategory(context: context);
            break;
          case 'delete':
            NoteDialog.deleteNote(context: context);
            break;
        }
      },
    );
  }
}
