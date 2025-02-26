import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/_admin/components/admin_app_bar.dart';
import 'package:notnotes/ui/pages/_admin/components/admin_body.dart';
import 'package:notnotes/ui/pages/_admin/components/admin_floating_action_button.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      appBar: AppBar(toolbarHeight: 80, title: AdminAppBarWidget()),

      body: AdminBodyWidget(),

      floatingActionButton: AdminFloatingActionButtonWidget(),
    );
  }
}
