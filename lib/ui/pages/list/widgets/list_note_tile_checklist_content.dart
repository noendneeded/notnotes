import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notnotes/domain/entities/note/note_entity.dart';

class ListNoteTileChecklistContentWidget extends StatelessWidget {
  const ListNoteTileChecklistContentWidget(
      {super.key, required this.listItems});

  final List<ListItem> listItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              // Icons.check_box_outline_blank_rounded,
              size: 15,
              color: Theme.of(context).hintColor,
              listItems.first.checked
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
            ),
            const Gap(4),
            Text(
              listItems.first.text,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (listItems.length != 1)
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              'и еще ${listItems.length - 1} пунктов',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
      ],
    );
  }
}
