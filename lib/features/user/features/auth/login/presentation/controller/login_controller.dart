import 'package:flutter/material.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:food_quest/core/utils/validation_utils.dart';
import 'package:food_quest/features/user/domain/usecase/user_usecase.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final UserUseCase _useCase;

  LoginController(this._useCase);

  final TextEditingController userNameController = TextEditingController(text: "linh123");
  final TextEditingController passwordController = TextEditingController(text: "123456");

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Validate input
  bool _validation() {
    final fields = [
      {
        "value": userNameController.text,
        "label": "Tên đăng nhập",
      },
      {
        "value": passwordController.text,
        "label": "Mật khẩu",
      },
    ];
    for (final field in fields) {
      final isValid = ValidationUtils.validateRequiredField(
        field["value"]!,
        field["label"]!,
      );
      if (!isValid) return false;
    }

    return true;
  }

  /// Login event
  Future<void> onLogin() async {
    KeyboardUtils.hiddenKeyboard();
    if (!_validation()) return;

    errorMessage.value = '';

    final bool? isLoginSuccess = await Utils.runWithLoading<bool>(() async {
      return _useCase.login(
        userNameController.text.trim(),
        passwordController.text.trim(),
      );
    });

    if (isLoginSuccess == true) {
      // Get.offAllNamed(const NavigationPage().routeName);
    }
  }

  @override
  void onClose() {
    userNameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
