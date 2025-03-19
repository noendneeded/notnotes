import 'package:flutter/material.dart';
import 'package:notnotes/domain/dependencies/dependencies.dart';
import 'package:notnotes/domain/repositories/category_repository/i_category_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';
import 'package:notnotes/ui/pages/list/list_view.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListViewModel(
        ///
        context: context,

        noteRepository: getIt<INoteRepository>(),
        categoryRepository: getIt<ICategoryRepository>(),
      ),
      child: const NotesListView(),
    );
  }
}
