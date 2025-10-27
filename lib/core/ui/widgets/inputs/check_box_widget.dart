
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/extension/core/empty_extensions.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CheckBoxWidget extends StatelessWidget {
  final String? label;
  final RxBool isCheck;
  const CheckBoxWidget({
    super.key,
    this.label,
    required this.isCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: isCheck.value,
            onChanged: (value) {
              isCheck.value = value ?? false;
            },
            activeColor: AppThemeColors.primary,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          if (label != null)
            TextWidget(
              text: label.orEmpty(),
              size: 12,
            ),
        ],
      ),
    );
  }
}
