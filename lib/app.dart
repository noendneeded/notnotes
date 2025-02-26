import 'package:flutter/material.dart';
import 'package:notnotes/router/app_router.dart';
import 'package:notnotes/theme/app_theme.dart';
import 'package:toastification/toastification.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        /// Название приложения
        title: 'NotNotes',

        /// Тема
        theme: AppTheme.theme,

        /// Навигация
        routerConfig: AppRouter.router,
      ),
    );
  }
}
