import 'package:flutter/widgets.dart';
import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:food_quest/core/config/const/app_logger.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:food_quest/core/utils/validation_utils.dart';
import 'package:food_quest/main/user/domain/usecase/user_usecase.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final UserUseCase _userUseCase;

  SigninController(this._userUseCase);
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController(text: "123456");
  final TextEditingController confirmPasswordController = TextEditingController(text: "123456");

  final isLoading = false.obs;

  ///---> [Validation]
  bool _validation() {
    final fields = [
      {"value": userNameController.text, "label": "Tên đăng nhập"},
      {"value": firstNameController.text, "label": "Họ"},
      {"value": lastNameController.text, "label": "Tên"},
      {"value": phoneNumberController.text, "label": "Số điện thoại"},
      {"value": passwordController.text, "label": "Mật khẩu"},
      {"value": confirmPasswordController.text, "label": "Nhập lại mật khẩu"},
    ];

    for (final field in fields) {
      final isValid = ValidationUtils.validateRequiredField(
        field["value"]!,
        field["label"]!,
      );
      if (!isValid) return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Lỗi", "Mật khẩu nhập lại không khớp");
      return false;
    }

    return true;
  }

  ///---> [Events]
  Future<void> onSignin() async {
    KeyboardUtils.hiddenKeyboard();
    if (!_validation()) return;
    isLoading.value = true;
    try {
      final user = await _userUseCase.register(
        username: userNameController.text.trim(),
        password: passwordController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
      );

      if (user != null) {
        DialogUtils.showConfirm(
          barrierDismissible: false,
          alertType: AlertType.success,
          content: "Tài khoản đã được đăng ký",
          title: "Đăng ký thành công",
          confirmText: "Login ngay",
          cancelText: "Thoát",
          onCancel: () {
            Get.back();
          },
          onConfirm: () async {
            Get.back();
            final bool? isLoginSuccess = await Utils.runWithLoading<bool>(
              () async {
                return _userUseCase.login(
                  userNameController.text.trim(),
                  passwordController.text.trim(),
                );
              },
            );

            if (isLoginSuccess == true) {
              // Get.offAllNamed(const NavigationPage().routeName);
            }
          },
        );
      }
    } catch (e) {
      AppLogger.i(e);
    } finally {
      isLoading.value = false;
    }
  }
}
