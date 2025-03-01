import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notnotes/ui/pages/note/note_vm.dart';
import 'package:notnotes/ui/utils/default_toast/default_toast.dart';
import 'package:notnotes/ui/widgets/default_card/default_card.dart';
import 'package:notnotes/ui/widgets/default_popup/default_popup.dart';
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
                child: Row(
                  children: [
                    ///
                    Icon(
                      Icons.alarm_rounded,
                      size: 20,
                    ),

                    const Gap(8),

                    Text(
                      'Создать напоминание',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              PopupMenuDivider(),

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
                      model.note.categoryId == 'all'
                          ? 'Добавить в категорию'
                          : 'Изменить категорию',
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
                      'Удалить заметку',
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
          case 'create_notification':
            DefaultToast.show('В разработке...');
            break;
          case 'add_to_category':
            showDialog<int>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  ///
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,

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

                        separatorBuilder: (context, index) => const Gap(8),

                        itemBuilder: (context, index) => DefaultCardWidget(
                          title: model.categories[index].name,
                          onTap: () {
                            model.changeCategory(
                              id: model.categories[index].id,
                            );
                            Navigator.pop(context, index);
                          },
                          selected: model.note.categoryId ==
                              model.categories[index].id,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
            break;
          case 'delete':
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                ///
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,

                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide.none,
                ),

                titlePadding: const EdgeInsets.only(top: 24, left: 24),
                contentPadding: const EdgeInsets.only(
                    top: 12, bottom: 24, left: 16, right: 16),
                actionsPadding:
                    const EdgeInsets.only(bottom: 12, left: 12, right: 12),

                title: const Text('Вы уверены?'),

                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Нет',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      model.deleteNote();

                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Да',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
            // model.deleteNote();
            break;
        }
      },
    );
  }
}
