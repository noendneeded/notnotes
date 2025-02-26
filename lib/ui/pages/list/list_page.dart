import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/list/components/list_app_bar.dart';
import 'package:notnotes/ui/pages/list/components/list_app_bar_selecting.dart';
import 'package:notnotes/ui/pages/list/components/list_app_bar_selecting_actions.dart';
import 'package:notnotes/ui/pages/list/components/list_body.dart';
import 'package:notnotes/ui/pages/list/components/list_floating_action_button.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListViewModel>();

    return Scaffold(
      ///
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: model.noteStates.containsValue(true)
              ? AppBar(
                  key: const ValueKey('selecting'),
                  toolbarHeight: 80,
                  title: ListAppBarSelectingWidget(),
                  actions: [ListAppBarSelectingActionsWidget()],
                )
              : AppBar(
                  key: const ValueKey('default'),
                  toolbarHeight: 80,
                  title: ListAppBarWidget(),
                ),
        ),
      ),

      body: ListBodyWidget(),

      floatingActionButton: model.noteStates.containsValue(true)
          ? null
          : ListFloatingActionButtonWidget(),
    );
  }
}
