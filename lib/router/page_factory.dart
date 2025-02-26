import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notnotes/domain/di/injection.dart';
import 'package:notnotes/domain/entities/note/note_entity.dart';
import 'package:notnotes/domain/repositories/category_repository/i_category_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';
import 'package:notnotes/ui/pages/_admin/admin_page.dart';
import 'package:notnotes/ui/pages/_admin/admin_vm.dart';
import 'package:notnotes/ui/pages/list/list_page.dart';
import 'package:notnotes/ui/pages/list/list_vm.dart';
import 'package:notnotes/ui/pages/note/note_page.dart';
import 'package:notnotes/ui/pages/note/note_vm.dart';
import 'package:provider/provider.dart';

class PageFactory {
  /// Страница 'Admin'
  Widget makeAdminPage() {
    return ChangeNotifierProvider(
      create: (context) => AdminViewModel(
        context: context,
        noteRepository: getIt<INoteRepository>(),
        categoryRepository: getIt<ICategoryRepository>(),
      ),
      child: const AdminPage(),
    );
  }

  /// Страница 'List'
  Widget makeListPage() {
    return ChangeNotifierProvider(
      create: (context) => ListViewModel(
        context: context,
        noteRepository: getIt<INoteRepository>(),
        categoryRepository: getIt<ICategoryRepository>(),
      ),
      child: const ListPage(),
    );
  }

  /// Страница 'Note'
  Widget makeNotePage(BuildContext context, GoRouterState state) {
    final note = state.extra as NoteEntity?;

    return ChangeNotifierProvider(
      create: (_) => NoteViewModel(
        context: context,
        noteRepository: getIt<INoteRepository>(),
        categoryRepository: getIt<ICategoryRepository>(),
        note: note,
      ),
      child: const NotePage(),
    );
  }
}
