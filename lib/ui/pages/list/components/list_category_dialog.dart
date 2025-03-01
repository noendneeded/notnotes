import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:notnotes/ui/utils/default_toast/default_toast.dart';
import 'package:notnotes/ui/widgets/default_container.dart/focusable_container.dart';
import 'package:notnotes/ui/widgets/default_text_form/default_text_form.dart';
import 'package:provider/provider.dart';

abstract class ListCategoryDialog {
  static deleteCategory({required BuildContext context, required String id}) {
    final model = context.read<ListViewModel>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          ///
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide.none,
          ),

          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // backgroundColor: Colors.transparent,

          titlePadding: const EdgeInsets.only(top: 24, left: 24, bottom: 12),
          actionsPadding: EdgeInsets.only(bottom: 12, left: 12, right: 12),

          elevation: 0,

          title: Text('Удалить категорию?'),

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
                await model.deleteCategory(id);

                Navigator.pop(context);
              },
              child: const Text(
                'Да',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  static addCategory({
    required BuildContext context,
  }) {
    final model = context.read<ListViewModel>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          ///
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide.none,
          ),

          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // backgroundColor: Colors.transparent,

          titlePadding: const EdgeInsets.only(top: 24, left: 24),
          actionsPadding: EdgeInsets.only(bottom: 12, left: 12, right: 12),

          elevation: 0,

          title: Text('Создать категорию'),
          content: ConstrainedBox(
            ///
            constraints: BoxConstraints(minWidth: 500),

            child: FocusableContainerWidget(
              child: Padding(
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

          actions: [
            TextButton(
              onPressed: () {
                model.categoryController.text = '';
                Navigator.pop(context);
              },
              child: const Text(
                'Отмена',
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () async {
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
              child: const Text(
                'ОК',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
  }
}
