import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notnotes/domain/entities/note/note_entity.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:notnotes/ui/pages/list/widgets/list_note_tile_checklist_content.dart';
import 'package:notnotes/ui/pages/list/widgets/list_note_tile_text_content.dart';
import 'package:notnotes/ui/widgets/default_box_shadow/default_box_shadow.dart';
import 'package:provider/provider.dart';

class ListNoteTileWidget extends StatelessWidget {
  const ListNoteTileWidget({
    super.key,
    required this.index,
    required this.note,
  });

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
              border: Border.all(
                color: model.noteStates[index] ?? false
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 3,
              )),

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                        Text(
                          maxLines: 1,

                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),

                          ///
                          note.title,
                        ),

                        const Spacer(),

                        if (note.pinned)
                          Transform.rotate(
                            angle: 45 * math.pi / 180,
                            child: Icon(
                              Icons.push_pin_rounded,
                              color: Theme.of(context).hintColor.withAlpha(80),
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const Gap(8),

                Hero(
                  tag: 'note_${note.id}_content',
                  child: Material(
                    type: MaterialType.transparency,
                    child: note.type == NoteType.checklist
                        ? ListNoteTileChecklistContentWidget()
                        : ListNoteTileTextContentWidget(
                            text: note.contentText,
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
