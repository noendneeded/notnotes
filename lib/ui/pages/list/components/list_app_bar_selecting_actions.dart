import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:notnotes/ui/widgets/default_card/default_card.dart';
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

            onSelected: (p0) {
              switch (p0) {
                case 'delete':
                  model.deleteNotes();
                  break;
                case 'add_to_category':
                  showDialog<int>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        ///
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,

                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide.none,
                        ),

                        titlePadding: const EdgeInsets.only(top: 24, left: 24),
                        contentPadding: const EdgeInsets.only(
                            top: 12, bottom: 24, left: 16, right: 16),

                        title: const Text('Выберите категорию'),

                        content: SizedBox(
                          ///
                          width: 500,
                          height: 40,

                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: ListView.separated(
                              ///
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(),

                              itemCount: model.categories.length,

                              separatorBuilder: (context, index) =>
                                  const Gap(8),

                              itemBuilder: (context, index) =>
                                  DefaultCardWidget(
                                title: model.categories[index].name,
                                onTap: () {
                                  model.changeNotesCategory(
                                      model.categories[index].id);
                                  Navigator.pop(context, index);
                                },
                                selected: model.categories[index].id ==
                                    model.getCommonSelectedCategoryId(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
