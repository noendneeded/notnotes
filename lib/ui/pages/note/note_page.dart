import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/note/components/note_app_bar_popup.dart';
import 'package:notnotes/ui/pages/note/components/note_body.dart';
import 'package:notnotes/ui/pages/note/components/note_floating_action_button.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      appBar: AppBar(actions: [NoteAppBarPopupWidget()]),

      body: NoteBodyWidget(),

      floatingActionButton: NoteFloatingActionButtonWidget(),
    );
  }
}
