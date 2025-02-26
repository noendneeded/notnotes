import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notnotes/ui/widgets/default_card/default_card.dart';

class AdminBodyWidget extends StatelessWidget {
  const AdminBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///
        SizedBox(
          height: 40,
          child: ListView.separated(
            ///
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            separatorBuilder: (context, index) => const Gap(8),

            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: DefaultCardWidget(
                    title: 'Card_$index',
                    selected: true,
                  ),
                );
              } else if (index == 9) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: DefaultCardWidget(title: 'Card_$index'),
                );
              } else {
                return DefaultCardWidget(title: 'Card_$index');
              }
            },
          ),
        ),
      ],
    );
  }
}
