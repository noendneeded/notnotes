import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:notnotes/ui/widgets/default_popup/default_popup.dart';
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
            onSelected: (p0) {
              switch (p0) {
                case 'delete':
                  model.deleteNotes();
                  break;
                case 'add_to_category':
                  break;
              }
            },

            itemBuilder: <PopupMenuEntry<String>>[
              ///
              PopupMenuItem<String>(
                value: 'add_to_category',
                child: Row(
                  children: [
                    ///
                    Icon(
                      Icons.label_outline_rounded,
                      size: 20,
                    ),

                    const Gap(8),

                    Text(
                      'Добавить в категорию',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              PopupMenuDivider(),

              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    ///
                    Icon(
                      Icons.delete_rounded,
                      size: 20,
                      color: Colors.red.shade700,
                    ),

                    const Gap(8),

                    Text(
                      model.noteStates.entries
                                  .where((element) => element.value)
                                  .length >
                              1
                          ? 'Удалить заметки'
                          : 'Удалить заметку',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
