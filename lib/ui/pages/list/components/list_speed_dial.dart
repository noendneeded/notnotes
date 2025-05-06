import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:notnotes/ui/pages/list/widgets/list_speed_dial_tile.dart';
import 'package:provider/provider.dart';

class ListSpeedDialWidget extends StatelessWidget {
  const ListSpeedDialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListViewModel>();

    return SpeedDial(
      ///
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).scaffoldBackgroundColor,

      overlayColor: Colors.black,
      overlayOpacity: 0.35,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      curve: Curves.easeIn,
      animationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 150),

      spacing: 6,
      spaceBetweenChildren: 0,

      openCloseDial: model.isOpen,

      children: [
        SpeedDialChild(
          ///
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).scaffoldBackgroundColor,

          labelWidget: ListSpeedDialTileWidget(
            label: 'Текст',
            icon: Icons.text_fields_rounded,
            onTap: () {
              model.isOpen.value = false;
              model.openNotePageWithCategory();
            },
          ),
        ),
        SpeedDialChild(
          ///
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).scaffoldBackgroundColor,

          labelWidget: ListSpeedDialTileWidget(
            label: 'В разработке...',
            icon: null,
            onTap: () {},
          ),
        ),
      ],

      activeChild: Icon(
        Icons.close_rounded,
        size: 28,
      ),

      child: Icon(
        Icons.add_rounded,
        size: 32,
      ),
    );
  }
}
