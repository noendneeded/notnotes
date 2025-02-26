import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notnotes/domain/entities/note/note_entity.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:notnotes/ui/widgets/default_box_shadow/default_box_shadow.dart';
import 'package:provider/provider.dart';

class ListNoteTileWidget extends StatelessWidget {
  const ListNoteTileWidget({
    super.key,
    // required this.title,
    // required this.content,
    required this.index,
    required this.note,
  });

  // final String title;
  // final String content;

  final int index;

  final NoteEntity note;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () async => model.noteStates.containsValue(true)
            ? model.changeNoteTileState(index)
            : model.openNotePageWithIndex(index),

        onLongPress: () => model.noteStates.containsValue(true)
            ? null
            : model.changeNoteTileState(index),

        ///
        child: AnimatedContainer(
          width: double.infinity,

          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOut,

          ///
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: model.noteStates[index] ?? false
                ? Theme.of(context).highlightColor
                : Theme.of(context).scaffoldBackgroundColor,

            ///
            boxShadow: model.noteStates[index] ?? false
                ? []
                : [DefaultBoxShadow.get(context)],

            border: model.noteStates[index] ?? false
                ? Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  )
                : null,
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              ///
              children: [
                ///
                Hero(
                  tag: 'note_${note.id}_title',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Row(
                      children: [
                        ///
                        Expanded(
                          flex: 5,
                          child: Text(
                            maxLines: 1,

                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),

                            ///
                            note.title,
                          ),
                        ),

                        if (kDebugMode)
                          Text(
                            note.categoryId.isNotEmpty
                                ? note.categoryId
                                : 'empty',
                          )
                      ],
                    ),
                  ),
                ),

                const Gap(8),

                Hero(
                  tag: 'note_${note.id}_content',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      maxLines: 2,

                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                        overflow: TextOverflow.ellipsis,
                      ),

                      ///
                      note.content.isNotEmpty ? note.content : '...',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
