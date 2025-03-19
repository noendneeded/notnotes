import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:notnotes/ui/pages/list/widgets/list_dialog.dart';
import 'package:notnotes/ui/widgets/default_popup/default_popup.dart';
import 'package:notnotes/ui/widgets/default_popup/default_popup_item_content.dart';
import 'package:provider/provider.dart';

class ListAppBarSelectingActionsWidget extends StatelessWidget {
  const ListAppBarSelectingActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListViewModel>();

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Row(
        children: [
          ///
          IconButton(
            icon: !model.noteStates.values.contains(false)
                ? Icon(Icons.radio_button_unchecked_rounded)
                : Icon(Icons.check_circle_outline_rounded),
            onPressed: () => model.changeAllNoteTileStates(),
          ),

          DefaultPopupWidget(
            ///
            itemBuilder: <PopupMenuEntry<String>>[
              ///
              PopupMenuItem<String>(
                value: 'pin',
                child: DefaultPopupItemContent(
                  icon: Icons.push_pin_outlined,
                  title:
                      model.getCommonNotesPinMode() ? 'Закрепить' : 'Открепить',
                ),
              ),

              PopupMenuDivider(),

              PopupMenuItem<String>(
                value: 'add_to_category',
                child: DefaultPopupItemContent(
                    icon: Icons.label_outline_rounded,
                    title: 'Изменить категорию'),
              ),

              PopupMenuDivider(),

              PopupMenuItem<String>(
                value: 'delete',
                child: DefaultPopupItemContent(
                  icon: Icons.delete_rounded,
                  title: model.noteStates.entries
                              .where((element) => element.value)
                              .length >
                          1
                      ? 'Удалить заметки'
                      : 'Удалить заметку',
                  color: Colors.red.shade700,
                ),
              ),
            ],

            onSelected: (p0) {
              switch (p0) {
                case 'pin':
                  model.pinNotes();
                  break;
                case 'delete':
                  ListDialog.deleteNotes(context: context);
                  break;
                case 'add_to_category':
                  ListDialog.changeNoteCategory(context: context);
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
