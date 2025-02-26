import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notnotes/ui/pages/list/components/list_category_dialog.dart';
import 'package:notnotes/ui/pages/list/components/list_note_tile.dart';
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
                    ? DefaultCardWidget(
                        title: model.categories[index].name,
                        selected: model.categorySelected == index,
                        onTap: () => model.selectCategory(index),
                        onLongPress: index != 0 && index != 1
                            ? () => ListCategoryDialog.deleteCategory(
                                  context: context,
                                  id: model.categories[index].id,
                                )
                            : null,
                      )
                    : DefaultCardAddWidget(
                        onTap: () =>
                            ListCategoryDialog.addCategory(context: context),
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

                      onPressed: () => model.openNotePage(),

                      child: Text('Создать'),
                    ),
                  ],
                )
              : ListView.separated(
                  ///
                  itemCount: model.notesFiltered.length,

                  separatorBuilder: (context, index) => const Gap(16),

                  itemBuilder: (context, index) => ListNoteTileWidget(
                    note: model.notesFiltered[index],
                    index: index,
                  ),
                ),
        ),
      ],
    );
  }
}
