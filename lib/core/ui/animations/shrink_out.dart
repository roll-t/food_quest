import 'package:flutter/material.dart';

class ShrinkOut extends StatelessWidget {
  final Widget child;
  final bool visible;
  final Duration duration;

  const ShrinkOut({
    super.key,
    required this.child,
    required this.visible,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: visible ? 1.0 : 0.0,
      duration: duration,
      curve: Curves.easeInBack,
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: duration,
        curve: Curves.easeInOut,
        child: Visibility(
          visible: visible,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: child,
        ),
      ),
    );
  }
}
