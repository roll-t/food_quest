import 'package:flutter/material.dart';

class ScaleOnTap extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  final Duration duration;

  const ScaleOnTap({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.9,
    this.duration = const Duration(milliseconds: 120),
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> pressed = ValueNotifier(false);

    return GestureDetector(
      onTapDown: (_) => pressed.value = true,
      onTapUp: (_) {
        pressed.value = false;
        if (onTap != null) onTap!();
      },
      onTapCancel: () => pressed.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: pressed,
        builder: (context, isPressed, _) {
          return AnimatedScale(
            scale: isPressed ? scale : 1.0,
            duration: duration,
            curve: Curves.easeOut,
            child: child,
          );
        },
      ),
    );
  }
}
