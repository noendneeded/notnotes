import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notnotes/ui/pages/list/widgets/list_dialog.dart';
import 'package:notnotes/ui/pages/list/widgets/list_note_tile.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:notnotes/ui/widgets/default_card/default_card.dart';
import 'package:notnotes/ui/widgets/default_card/default_card_add.dart';
import 'package:notnotes/ui/widgets/default_loading/default_loading.dart';
import 'package:provider/provider.dart';

class ListBodyWidget extends StatelessWidget {
  const ListBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListViewModel>();

    /// Загрузка данных
    if (model.isLoading) {
      return const DefaultLoadingWidget();
    }

    return Column(
      children: [
        ///
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SizedBox(
            ///
            height: 40,
            child: ListView.separated(
              ///
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),

              itemCount: model.categories.length + 1,

              separatorBuilder: (context, index) => const Gap(8),

              itemBuilder: (context, index) => Padding(
                ///
                padding: EdgeInsets.only(
                  left: index == 0 ? 16 : 0,
                  right: index == model.categories.length ? 16 : 0,
                ),

                child: index != model.categories.length
                    ? Builder(
                        builder: (context) {
                          final GlobalObjectKey cardKey =
                              GlobalObjectKey(model.categories[index].id);

                          return DefaultCardWidget(
                            ///
                            key: cardKey,
                            selected: model.categorySelected == index,

                            title: model.categories[index].name,

                            onTap: () => model.noteStates.containsValue(true)
                                ? null
                                : model.selectCategory(index),

                            onLongPressStart: index != 0 && index != 1
                                ? (details) async {
                                    final RenderBox cardBox = cardKey
                                        .currentContext!
                                        .findRenderObject() as RenderBox;

                                    final Offset cardPosition =
                                        cardBox.localToGlobal(Offset.zero);

                                    final Size cardSize = cardBox.size;

                                    final RenderBox overlay =
                                        Overlay.of(context)
                                            .context
                                            .findRenderObject() as RenderBox;

                                    final RelativeRect position =
                                        RelativeRect.fromRect(
                                      Rect.fromLTWH(
                                        cardPosition.dx,
                                        cardPosition.dy + cardSize.height,
                                        cardSize.width,
                                        cardSize.height,
                                      ),
                                      Offset.zero & overlay.size,
                                    );

                                    final selected = await showMenu<String>(
                                      ///
                                      context: context,
                                      position: position,

                                      constraints: BoxConstraints(
                                        maxWidth: 200,
                                      ),

                                      elevation: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),

                                      items: [
                                        ///
                                        PopupMenuItem<String>(
                                          value: 'edit',
                                          height: 36,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit_rounded,
                                                size: 18,
                                                color: Colors.black,
                                              ),
                                              const Gap(8),
                                              Text(
                                                'Изменить категорию',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        PopupMenuDivider(),

                                        PopupMenuItem<String>(
                                          value: 'delete',
                                          height: 36,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete_rounded,
                                                size: 18,
                                                color: Colors.red.shade700,
                                              ),
                                              const Gap(8),
                                              Text(
                                                'Удалить категорию',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.red.shade700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                    switch (selected) {
                                      case 'delete':
                                        await model.deleteCategory(
                                          model.categories[index].id,
                                        );
                                        break;
                                      case 'edit':
                                        // ListCategoryDialog.editCategory(
                                        //   id: model.categories[index].id,
                                        //   context: context,
                                        // );
                                        ListDialog.editCategory(
                                          context: context,
                                          id: model.categories[index].id,
                                        );
                                        break;
                                    }
                                  }
                                : null,
                          );
                        },
                      )
                    : DefaultCardAddWidget(
                        onTap: () =>
                            ListDialog.createCategory(context: context),
                        // ListCategoryDialog.addCategory(context: context),
                      ),
              ),
            ),
          ),
        ),

        Expanded(
          child: model.notesFiltered.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///
                    const Gap(8),

                    Image.asset(
                      'assets/unluck.png',
                      width: 96,
                    ),

                    const Gap(8),

                    const Text(
                      textAlign: TextAlign.center,
                      'Ничего нет..',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),

                    const Gap(8),

                    ElevatedButton(
                      ///
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).primaryColor),
                        foregroundColor: WidgetStateProperty.all(
                          Theme.of(context).scaffoldBackgroundColor,
                        ),
                        elevation: WidgetStatePropertyAll(4),
                      ),

                      onPressed: () => model.openNotePageWithCategory(),

                      child: Text('Создать'),
                    ),
                  ],
                )
              : ListView.separated(
                  ///
                  itemCount: model.notesFiltered.length,

                  separatorBuilder: (context, index) => const Gap(16),

                  itemBuilder: (context, index) => index ==
                          model.pinnedCount - 1
                      ? Column(
                          children: [
                            ListNoteTileWidget(
                              note: model.notesFiltered[index],
                              index: index,
                            ),
                            const Gap(16),
                            if (index != model.notesFiltered.length - 1)
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .highlightColor
                                      .withAlpha(60),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                          ],
                        )
                      : ListNoteTileWidget(
                          note: model.notesFiltered[index],
                          index: index,
                        ),
                ),
        ),
      ],
    );
  }
}
