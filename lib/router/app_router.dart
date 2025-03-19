import 'package:go_router/go_router.dart';
import 'package:notnotes/router/app_routes.dart';
import 'package:notnotes/ui/pages/list/list_page.dart';
import 'package:notnotes/ui/pages/note/note_page.dart';

abstract class AppRouter {
  static final router = GoRouter(
    ///
    initialLocation: AppRoutes.list,

    routes: [
      /// Страница 'List'
      GoRoute(
        ///
        path: AppRoutes.list,
        builder: (context, state) => const ListPage(),

        routes: [
          /// Страница 'Note'
          GoRoute(
            path: AppRoutes.note,
            builder: (context, state) => NotePage(state: state),
          ),
        ],
      ),
    ],
  );
}
