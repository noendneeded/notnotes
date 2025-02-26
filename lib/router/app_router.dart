import 'package:go_router/go_router.dart';
import 'package:notnotes/router/app_routes.dart';
import 'package:notnotes/router/page_factory.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.list,

    ///
    routes: [
      /// Страница 'Admin'
      GoRoute(
        path: AppRoutes.admin,
        builder: (context, state) => PageFactory().makeAdminPage(),
      ),

      /// Страница 'List'
      GoRoute(
        path: AppRoutes.list,
        builder: (context, state) => PageFactory().makeListPage(),

        ///
        routes: [
          /// Страница 'Note'
          GoRoute(
            path: AppRoutes.note,
            builder: (context, state) =>
                PageFactory().makeNotePage(context, state),
          ),
        ],
      ),
    ],
  );
}
