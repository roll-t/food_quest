import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_images.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/extension/core/empty_extensions.dart';
import 'package:food_quest/core/ui/widgets/buttons/primary_button.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/features/user/data/model/user_model.dart';
import 'package:food_quest/features/user/features/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InfoProfileWidget extends StatelessWidget {
  const InfoProfileWidget({
    super.key,
  });

  @override
  // ignore: prefer_const_constructors
  Widget build(BuildContext context) => _BodyBuilder();
}

class _BodyBuilder extends GetView<ProfileController> {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final UserModel? user = controller.user.value;
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppThemeColors.background100,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.light300),
                color: AppColors.cardBackground2,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  AppImages.iAvatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                TextWidget(
                  text: (user?.displayName).orNA(),
                  color: AppThemeColors.text,
                  textStyle: AppTextStyle.medium18,
                ),
                const SizedBox(height: 12.0),
                PrimaryButton(
                  text: "Đăng xuất",
                  onPressed: controller.onLogOut,
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
