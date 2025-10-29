import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Fade Animation Controller
class FadeAnimationController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController fadeCtrl;
  late Animation<double> fade;

  @override
  void onInit() {
    super.onInit();
    fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    fade = CurvedAnimation(parent: fadeCtrl, curve: Curves.easeInOut);
  }

  Future<void> fadeIn() async => fadeCtrl.forward();
  Future<void> fadeOut() async => fadeCtrl.reverse();

  @override
  void onClose() => fadeCtrl.dispose();
}

/// Scale Animation Controller
class ScaleAnimationController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController scaleCtrl;
  late Animation<double> scale;

  @override
  void onInit() {
    super.onInit();
    scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.9,
      upperBound: 1.0,
    );
    scale = CurvedAnimation(parent: scaleCtrl, curve: Curves.easeInOut);
    scaleCtrl.value = 1.0;
  }

  Future<void> playTapScale() async {
    await scaleCtrl.reverse();
    await scaleCtrl.forward();
  }

  @override
  void onClose() => scaleCtrl.dispose();
}

/// Slide Animation Controller
class SlideAnimationController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController slideCtrl;
  late Animation<Offset> slide;

  @override
  void onInit() {
    super.onInit();
    slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    slide = Tween(begin: const Offset(0, 0.2), end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(slideCtrl);
  }

  Future<void> slideIn() async => slideCtrl.forward();
  Future<void> slideOut() async => slideCtrl.reverse();

  @override
  void onClose() => slideCtrl.dispose();
}

/// Rotate Animation Controller
class RotateAnimationController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController rotateCtrl;
  late Animation<double> rotate;

  @override
  void onInit() {
    super.onInit();
    rotateCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    rotate =
        Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.linear)).animate(rotateCtrl);
  }

  void startRotate() => rotateCtrl.repeat();
  void stopRotate() => rotateCtrl.stop();

  @override
  void onClose() => rotateCtrl.dispose();
}
