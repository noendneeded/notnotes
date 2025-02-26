import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:notnotes/ui/widgets/default_container.dart/focusable_container.dart';
import 'package:provider/provider.dart';

class ListAppBarWidget extends StatelessWidget {
  const ListAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListViewModel>();

    return FocusableContainerWidget(
      width: double.infinity,
      height: 56,

      ///
      child: Row(
        children: [
          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.search_rounded, color: Colors.grey.shade600),
          ),

          Expanded(
            child: TextField(
              maxLines: 1,

              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),

              controller: model.listController,

              onChanged: (value) => model.search(),

              ///
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Искать в заметках',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
          ),

          // IconButton(
          //   onPressed: null,
          //   icon: Icon(Icons.tune_rounded),
          //   color: Colors.grey.shade600,
          // ),

          IconButton(
            onPressed: () {
              kDebugMode ? model.openAdminPage() : null;
            },
            icon: Icon(
              Icons.circle,
              color: Colors.black,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}
