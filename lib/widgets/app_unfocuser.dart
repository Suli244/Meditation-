import 'package:flutter/material.dart';

class AppUnfocuser extends StatelessWidget {
  const AppUnfocuser({
    required this.child,
    Key? key,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: child,
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
    );
  }
}
