import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notnotes/data/local/predefined_categories.dart';
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
      onSelected: (p0) {
        switch (p0) {
          case 'create_notification':
            DefaultToast.show('Coming soon...');
            break;
          case 'add_to_category':
            showModalBottomSheet<int>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  ///
                  height: 180,

                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///

                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          'Выберите категорию: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const Gap(8),

                      SizedBox(
                        ///
                        height: 40,
                        child: ListView.separated(
                          ///
                          scrollDirection: Axis.horizontal,
                          physics: AlwaysScrollableScrollPhysics(),

                          itemCount: kPredefinedCategories.length,

                          separatorBuilder: (context, index) => const Gap(8),

                          itemBuilder: (context, index) => Padding(
                            ///
                            padding: EdgeInsets.only(
                              left: index == 1 ? 8 : 0,
                              right: index == kPredefinedCategories.length - 1
                                  ? 16
                                  : 0,
                            ),

                            child: index == 0
                                ? null
                                : DefaultCardWidget(
                                    title: kPredefinedCategories[index].name,
                                    onTap: () => Navigator.pop(context, index),
                                    selected: model.note.categoryId ==
                                        kPredefinedCategories[index].id,
                                  ),
                          ),
                        ),
                      ),

                      const Gap(8),

                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            ///
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context).primaryColor),
                              foregroundColor: WidgetStateProperty.all(
                                Theme.of(context).scaffoldBackgroundColor,
                              ),
                              elevation: WidgetStatePropertyAll(4),
                            ),

                            onPressed: () {
                              if (model.note.categoryId != 'all') {
                                model.changeCategory();

                                Navigator.pop(context);

                                DefaultToast.show('Категория удалена');
                              } else {
                                Navigator.pop(context);
                              }
                            },

                            child: model.note.categoryId != 'all'
                                ? Text('Убрать категорию')
                                : Text('Отмена'),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ).then((selectedIndex) {
              if (selectedIndex != null) {
                DefaultToast.show(
                    'Выбрана категория: ${kPredefinedCategories[selectedIndex].name}');

                model.changeCategory(
                    id: kPredefinedCategories[selectedIndex].id);
              }
            });
            break;
          case 'delete':
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide.none,
                  ),
                  actionsPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text('Вы уверены?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        model.deleteNote();
                      },
                      child: const Text(
                        'Да',
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Нет',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                );
              },
            );
            break;
        }
      },

      itemBuilder: <PopupMenuEntry<String>>[
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
                    ? 'Добавить категорию'
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
    );
  }
}
