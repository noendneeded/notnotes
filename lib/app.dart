import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notnotes/router/app_router.dart';
import 'package:notnotes/theme/app_theme.dart';
import 'package:toastification/toastification.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        supportedLocales: const [
          Locale('ru', 'RU'),
          Locale('en', 'US'),
        ],

        /// Название приложения
        title: 'NotNotes',

        /// Тема
        theme: AppTheme.theme,

        /// Навигация
        routerConfig: AppRouter.router,
        key: rootNavigatorKey,
      ),
    );
  }
}
