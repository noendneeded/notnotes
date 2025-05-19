import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ListNoteTileChecklistContentWidget extends StatelessWidget {
  const ListNoteTileChecklistContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              // Icons.check_box_outline_blank_rounded,
              Icons.check_box_rounded,
              size: 15,
              color: Theme.of(context).hintColor,
            ),
            const Gap(4),
            Text(
              '123',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            'и еще 3 пункта',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
    // return Text(
    //   '4 пункта',
    //   style: TextStyle(
    //     fontSize: 14,
    //     color: Theme.of(context).hintColor,
    //     overflow: TextOverflow.ellipsis,
    //   ),
    // );
  }
}
