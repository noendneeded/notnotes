import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:notnotes/ui/utils/default_toast/default_toast.dart';
import 'package:notnotes/ui/widgets/default_card/default_card.dart';
import 'package:notnotes/ui/widgets/default_container.dart/focusable_container.dart';
import 'package:notnotes/ui/widgets/default_dialog/default_dialog.dart';
import 'package:notnotes/ui/widgets/default_text_form/default_text_form.dart';
import 'package:provider/provider.dart';

abstract class ListDialog {
  /// Создание категории
  static createCategory({required BuildContext context}) {
    final model = context.read<ListViewModel>();

    DefaultDialog.show(
      ///
      context: context,

      title: 'Создать категорию',

      content: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 500),
        child: FocusableContainerWidget(
          child: Padding(
            ///
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 12,
            ),

            child: DefaultTextFormWidget(
              controller: model.categoryController,
              hint: 'Название',
            ),
          ),
        ),
      ),

      onTapPositive: () async {
        if (model.categoryController.value.text.isEmpty) {
          DefaultToast.show('Название не может быть пустым');
          return;
        }

        if (model.categories.any((category) =>
            category.name == model.categoryController.value.text)) {
          DefaultToast.show('Имя категории должно быть уникальным');
          return;
        }

        await model.createCategory();

        Navigator.pop(context);
      },
    );
  }

  /// Редактирование категории
  static editCategory({required BuildContext context, required String id}) {
    final model = context.read<ListViewModel>();

    /// Начальное значение контроллера - название редактируемой категории
    model.categoryController.text =
        model.categories.singleWhere((category) => category.id == id).name;

    DefaultDialog.show(
      ///
      context: context,

      title: 'Изменить категорию',

      content: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 500),
        child: FocusableContainerWidget(
          child: Padding(
            ///
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 12,
            ),

            child: DefaultTextFormWidget(
              controller: model.categoryController,
              hint: 'Название',
            ),
          ),
        ),
      ),

      onTapPositive: () {
        model.categoryController.text = '';
        context.pop();
      },
    );
  }

  /// Удаление заметки
  static deleteNotes({required BuildContext context}) {
    final model = context.read<ListViewModel>();

    DefaultDialog.showDelete(
      ///
      context: context,

      onTapPositive: () async {
        model.deleteNotes();

        Navigator.pop(context);
      },
    );
  }

  /// Изменение категории заметки
  static changeNoteCategory({required BuildContext context}) {
    final model = context.read<ListViewModel>();

    DefaultDialog.show(
      ///
      context: context,

      showActions: false,

      title: 'Выберите категорию',

      content: SizedBox(
        ///
        width: 500,
        height: 40,

        child: ListView.separated(
          ///
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),

          itemCount: model.categories.length,

          separatorBuilder: (context, index) => const Gap(8),

          itemBuilder: (context, index) => DefaultCardWidget(
            title: model.categories[index].name,
            onTap: () async {
              await model.changeNotesCategory(model.categories[index].id);
              Navigator.pop(context, index);
            },
            selected: model.categories[index].id ==
                model.getCommonSelectedCategoryId(),
          ),
        ),
      ),
    );
  }
}
