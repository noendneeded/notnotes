import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/note/note_vm.dart';
import 'package:notnotes/ui/pages/note/widgets/note_dialog.dart';
import 'package:notnotes/ui/utils/date_time_picker/date_time_picker.dart';
import 'package:notnotes/ui/widgets/default_popup/default_popup.dart';
import 'package:notnotes/ui/widgets/default_popup/default_popup_item_content.dart';
import 'package:provider/provider.dart';

class NoteAppBarPopupWidget extends StatelessWidget {
  const NoteAppBarPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NoteViewModel>();

    final items = <PopupMenuEntry<String>>[];

    items.addAll([
      ///
      PopupMenuItem<String>(
        value: 'add_to_category',
        child: DefaultPopupItemContent(
          icon: Icons.label_outline_rounded,
          title: 'Изменить категорию',
        ),
      ),

      const PopupMenuDivider(),

      PopupMenuItem<String>(
        value: 'create_notification',
        child: DefaultPopupItemContent(
          icon: Icons.alarm_rounded,
          title: model.note.remindAt == null
              ? 'Создать напоминание'
              : 'Изменить напоминание',
        ),
      ),

      const PopupMenuDivider(),

      if (model.note.remindAt != null) ...{
        PopupMenuItem<String>(
          value: 'remove_notification',
          child: DefaultPopupItemContent(
            icon: Icons.alarm_off_rounded,
            title: 'Удалить напоминание',
            iconColor: Colors.red.shade700,
            textColor: Colors.red.shade700,
          ),
        ),
        const PopupMenuDivider(),
      },

      PopupMenuItem<String>(
        value: 'delete',
        child: DefaultPopupItemContent(
          icon: Icons.delete_rounded,
          title: 'Удалить заметку',
          iconColor: Colors.red.shade700,
          textColor: Colors.red.shade700,
        ),
      ),
    ]);

    return DefaultPopupWidget(
      itemBuilder: model.isLoading ? [] : items,
      onSelected: (value) async {
        switch (value) {
          case 'remove_notification':
            await model.removeReminder();
            // DefaultToast.show('Напоминание удалено');
            break;

          case 'create_notification':
            var initial = DateTime.now();
            if (model.note.remindAt != null &&
                model.note.remindAt!.isAfter(initial)) {
              initial = model.note.remindAt!;
            }

            final dt = await showDateTimePicker(
              context,
              initial: initial,
            );
            if (dt == null) break;

            model.setReminder(dt);
            // DefaultToast.show(
            //   'Напоминание на ${DateFormat('d MMMM HH:mm', 'ru_RU').format(dt)}',
            // );

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
