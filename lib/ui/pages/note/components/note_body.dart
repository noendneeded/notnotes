import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:notnotes/ui/pages/note/note_vm.dart';
import 'package:notnotes/ui/utils/default_toast/default_toast.dart';
import 'package:notnotes/ui/widgets/default_container.dart/focusable_container.dart';
import 'package:notnotes/ui/widgets/default_text_input/default_text_field.dart';
import 'package:notnotes/ui/widgets/default_text_input/default_text_form.dart';
import 'package:provider/provider.dart';

class NoteBodyWidget extends StatelessWidget {
  const NoteBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NoteViewModel>();

    return ConstrainedBox(
      ///
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),

      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ///
              const Gap(8),

              Hero(
                tag: 'note_${model.note.id}_title',
                child: Material(
                  type: MaterialType.transparency,
                  child: FocusableContainerWidget(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      child: DefaultTextFormWidget(
                        ///
                        // initial: model.note.title,
                        hint: 'Название заметки',
                        isLarge: true,

                        controller: model.titleController,
                      ),
                    ),
                  ),
                ),
              ),

              const Gap(16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///
                    Text(
                      model.getStateText(),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),

                    if (model.note.remindAt != null) ...{
                      const Gap(4),
                      GestureDetector(
                        child: Icon(
                          Icons.alarm_rounded,
                          size: 16,
                        ),
                        onTap: () => DefaultToast.show(
                            'Напоминание на ${DateFormat('d MMMM HH:mm', 'ru_RU').format(model.note.remindAt!)}'),
                      )
                    },

                    const Spacer(),

                    !model.isLoading
                        ? Text(
                            model.note.categoryId == 'all'
                                ? ''
                                : model.categories
                                    .singleWhere((category) =>
                                        category.id == model.note.categoryId)
                                    .name,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          )
                        : Text(''),
                  ],
                ),
              ),

              const Gap(16),

              Hero(
                tag: 'note_${model.note.id}_content',
                child: Material(
                  type: MaterialType.transparency,
                  child: FocusableContainerWidget(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      // child: DefaultTextFormWidget(
                      //   hint: 'Текст заметки',
                      //   controller: model.contentController,
                      // ),
                      child: Column(
                        children: List.generate(
                          //
                          model.listItemsCount,
                          (index) => index != model.listItemsCount - 1
                              ? Row(
                                  children: [
                                    ///
                                    // InkWell(
                                    //   onTap: () => model.checkListItem(index),
                                    //   child: Icon(
                                    //     model.note.contentItems![index].checked
                                    //         ? Icons.check_box_rounded
                                    //         : Icons
                                    //             .check_box_outline_blank_rounded,
                                    //   ),
                                    // ),

                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: 24, maxHeight: 24),
                                      child: IconButton(
                                        ///
                                        padding: const EdgeInsets.all(0),

                                        onPressed: () =>
                                            model.checkListItem(index),

                                        isSelected: model
                                            .note.contentItems![index].checked,

                                        icon: Icon(Icons
                                            .check_box_outline_blank_rounded),
                                        selectedIcon:
                                            Icon(Icons.check_box_rounded),
                                      ),
                                    ),

                                    const Gap(8),

                                    Expanded(
                                      child: DefaultTextFieldWidget(
                                        controller:
                                            model.listItemControllers[index],
                                      ),
                                    ),

                                    const Gap(8),

                                    InkWell(
                                      onTap: () => model.deleteListItem(index),
                                      child: Icon(Icons.close_rounded),
                                    ),
                                  ],
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                    top: model.listItemsCount != 1 ? 4 : 12,
                                    bottom: 12,
                                  ),
                                  child: InkWell(
                                    onTap: () => model.createListItem(),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add_rounded,
                                        ),
                                        const Gap(10),
                                        Text('Новый пункт'),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }
}
