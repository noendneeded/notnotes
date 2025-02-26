import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notnotes/ui/pages/note/note_vm.dart';
import 'package:notnotes/ui/widgets/default_container.dart/focusable_container.dart';
import 'package:notnotes/ui/widgets/default_text_form/default_text_form.dart';
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
                  children: [
                    ///
                    Text(
                      model.getStateText(),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),

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
                          vertical: 4, horizontal: 16),
                      child: DefaultTextFormWidget(
                        ///
                        // initial: model.note.content,
                        hint: 'Текст заметки',

                        controller: model.contentController,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
