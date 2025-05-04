import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notnotes/ui/pages/list/components/list_app_bar.dart';
import 'package:notnotes/ui/pages/list/widgets/list_app_bar_selecting.dart';
import 'package:notnotes/ui/pages/list/widgets/list_app_bar_selecting_actions.dart';
import 'package:notnotes/ui/pages/list/components/list_body.dart';
import 'package:notnotes/ui/pages/list/components/list_floating_action_button.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:notnotes/ui/widgets/default_dialog/default_dialog.dart';
import 'package:provider/provider.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListViewModel>();

    if (model.shouldShowPermissionsSheet) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        DefaultDialog.show(
          context: context,
          title: 'Разрешения',
          content: const Text(
            'Чтобы напоминания работали корректно, приложению необходим доступ к уведомлениям и точным будильникам.',
            style: TextStyle(fontSize: 15),
          ),
          onTapPositive: () async {
            context.pop();
            await model.requestPermissions();
            model.markPermissionsRequested();
          },
          onTapNegative: () {
            context.pop();
            model.markPermissionsRequested();
          },
        );
        // await _showPermissionsSheet(context, model);
      });
    }

    return Scaffold(
      ///
      resizeToAvoidBottomInset: false,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AnimatedSwitcher(
          ///
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

  // Future<void> _showPermissionsSheet(
  //     BuildContext context, ListViewModel model) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (_) => Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           const Text(
  //             'Разрешения для уведомлений',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 8),
  //           const Text(
  //             'Чтобы напоминания работали корректно, нужно разрешить '
  //             'показ уведомлений и точные будильники.',
  //           ),
  //           const SizedBox(height: 16),
  //           ElevatedButton(
  //             onPressed: () async {
  //               context.pop();
  //               await model.requestPermissions();
  //               model.markPermissionsRequested();
  //             },
  //             child: const Text('Дать разрешения'),
  //           ),
  //           const SizedBox(height: 8),
  //           TextButton(
  //             onPressed: () {
  //               context.pop();
  //               model.markPermissionsRequested();
  //             },
  //             child: const Text('Не сейчас'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
