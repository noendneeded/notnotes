import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notnotes/domain/dependencies/dependencies.dart';
import 'package:notnotes/domain/entities/note/note_entity.dart';
import 'package:notnotes/domain/repositories/category_repository/i_category_repository.dart';
import 'package:notnotes/domain/repositories/note_repository/i_note_repository.dart';
import 'package:notnotes/ui/pages/note/note_view.dart';
import 'package:notnotes/ui/pages/note/note_vm.dart';
import 'package:provider/provider.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key, required this.state});

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteViewModel(
        ///
        context: context,

        noteRepository: getIt<INoteRepository>(),
        categoryRepository: getIt<ICategoryRepository>(),

        note: state.extra as NoteEntity?,
      ),
      child: const NoteView(),
    );
  }
}
