import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_icons.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';

class DataNullWidget extends StatelessWidget {
  const DataNullWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIcons.icNoData.show(size: 150),
        const SizedBox(height: 10),
        TextWidget(
          text: "Không có dữ liệu",
          color: AppThemeColors.text300,
          textStyle: AppTextStyle.regular14,
        ),
      ],
    );
  }
}
