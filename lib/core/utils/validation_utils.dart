import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';

class ValidationUtils {
  static bool validateRequiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        title: "Thông báo",
        content: "$fieldName không được bỏ trống",
      );
      return false;
    }
    return true;
  }
}
