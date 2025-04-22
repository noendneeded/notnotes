import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/note/widgets/note_app_bar_popup.dart';
import 'package:notnotes/ui/pages/note/components/note_body.dart';
import 'package:notnotes/ui/pages/note/components/note_floating_action_button.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      // resizeToAvoidBottomInset: false,

      appBar: AppBar(actions: [NoteAppBarPopupWidget()]),

      body: NoteBodyWidget(),

      floatingActionButton: NoteFloatingActionButtonWidget(),
    );
  }
}
