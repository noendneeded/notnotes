import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notnotes/theme/constants.dart';

abstract class DefaultDialog {
  /// Общий диалог
  static show({
    required BuildContext context,
    required String title,
    required Widget content,
    Function()? onTapPositive,
    Function()? onTapNegative,
    bool showActions = true,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        ///
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide.none,
        ),

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        titlePadding: const EdgeInsets.only(top: 16, left: 16),
        contentPadding: EdgeInsets.only(
          top: showActions ? 16 : 8,
          bottom: showActions ? 8 : 16,
          left: 16,
          right: 16,
        ),
        actionsPadding: EdgeInsets.only(bottom: 4, left: 4, right: 4),

        elevation: 0,

        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),

        content: content,

        actions: showActions
            ? [
                TextButton(
                  onPressed: onTapNegative ?? context.pop,
                  child: const Text(
                    'Отмена',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onTapPositive,
                  child: const Text(
                    'ОК',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ]
            : [],
      ),
    );
  }

  /// Удаление
  static showDelete({
    required BuildContext context,
    String? title,
    Function()? onTapPositive,
    Function()? onTapNegative,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        ///
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide.none,
        ),

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        titlePadding: const EdgeInsets.only(top: 16, left: 16),
        contentPadding:
            const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
        actionsPadding: EdgeInsets.only(bottom: 4, left: 4, right: 4),

        elevation: 0,

        title: Text(
          title ?? 'Вы уверены?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),

        actions: [
          TextButton(
            onPressed: onTapNegative ?? context.pop,
            child: const Text(
              'Нет',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          TextButton(
            onPressed: onTapNegative,
            child: const Text(
              'Да',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: kErrorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
