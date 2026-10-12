import 'package:flutter/material.dart';
import '../widgets/auth_shell.dart';
import 'package:flutter/cupertino.dart';

class AdaptivePageTransitionsBuilder extends PageTransitionsBuilder {
  const AdaptivePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Layar lebar (browser): fade halus
    if (AuthShell.isWide(context)) {
      return FadeTransition(
        opacity: animation.drive(CurveTween(curve: Curves.easeOut)),
        child: child,
      );
    }

    // HP / jendela sempit: transisi bawaan seperti sebelumnya
    final platform = Theme.of(context).platform;
    final PageTransitionsBuilder fallback =
        (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS)
            ? const CupertinoPageTransitionsBuilder()
            : const ZoomPageTransitionsBuilder();
    return fallback.buildTransitions<T>(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}