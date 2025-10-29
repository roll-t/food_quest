import 'package:flutter/material.dart';

class AppAnimations {
  AppAnimations._();

  static Widget fade({
    required Animation<double> animation,
    required Widget child,
    Curve curve = Curves.easeInOut,
  }) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: curve),
      child: child,
    );
  }

  static Widget scale({
    required Animation<double> animation,
    required Widget child,
    Curve curve = Curves.easeOutBack,
  }) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: animation, curve: curve),
      child: child,
    );
  }

  static Widget slide({
    required Animation<Offset> animation,
    required Widget child,
  }) {
    return SlideTransition(position: animation, child: child);
  }

  static Widget rotate({
    required Animation<double> animation,
    required Widget child,
  }) {
    return RotationTransition(turns: animation, child: child);
  }

  static Widget fadeAndScale({
    required Animation<double> animation,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(scale: animation, child: child),
    );
  }
}
