import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notnotes/ui/pages/note/note_vm.dart';
import 'package:notnotes/ui/widgets/default_card/default_card.dart';
import 'package:notnotes/ui/widgets/default_dialog/default_dialog.dart';
import 'package:provider/provider.dart';

abstract class NoteDialog {
  /// Изменение категории заметки
  static changeNoteCategory({required BuildContext context}) {
    final model = context.read<NoteViewModel>();

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
            onTap: () {
              model.changeCategory(
                id: model.categories[index].id,
              );
              Navigator.pop(context, index);
            },
            selected: model.note.categoryId == model.categories[index].id,
          ),
        ),
      ),
    );
  }

  /// Удалить заметку
  static deleteNote({required BuildContext context}) {
    DefaultDialog.showDelete(
      ///
      context: context,

      onTapPositive: () {
        context.read<NoteViewModel>().deleteNote();

        Navigator.pop(context);
      },
    );
  }
}
