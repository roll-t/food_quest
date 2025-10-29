import 'package:flutter/cupertino.dart';
import 'package:food_quest/core/config/const/app_images.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/buttons/primary_button.dart';
import 'package:food_quest/core/ui/widgets/images/asset_image_widget.dart';
import 'package:food_quest/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/utils/custom_state.dart';
import 'package:food_quest/main/user/features/auth/login/presentation/page/login_page.dart';
import 'package:food_quest/main/user/features/auth/signin/presentation/controller/signin_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SigninPage extends CustomState {
  const SigninPage({super.key});
  @override
  bool get dismissKeyboard => true;

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

class _BodyBuilder extends GetView<SigninController> {
  const _BodyBuilder();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppEdgeInsets.h16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 12.h),
            AssetImageWidget(
              assetPath: AppImages.iLogo,
              width: 20.w,
            ),
            const SizedBox(height: 18),
            const TextWidget(
              text: "Đăng Ký",
              textStyle: AppTextStyle.bold30,
            ),
            const SizedBox(height: 40),
            CustomTextField(
              hintText: "Tên đăng nhập",
              controller: controller.userNameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: "Họ",
              controller: controller.firstNameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: "Tên",
              controller: controller.lastNameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: "Số điện thoại",
              controller: controller.phoneNumberController,
              scrollPadding: const EdgeInsets.only(bottom: 160),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: "Mật khẩu",
              controller: controller.passwordController,
              scrollPadding: const EdgeInsets.only(bottom: 140),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: "Nhập lại mật khẩu",
              controller: controller.confirmPasswordController,
              scrollPadding: const EdgeInsets.only(bottom: 120),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: "Đăng Ký",
              textSize: 18,
              isMaxParent: true,
              onPressed: controller.onSignin,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextWidget(
                  text: "Đã có tài khoản. ",
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAndToNamed(const LoginPage().routeName);
                  },
                  child: TextWidget(
                    textStyle: AppTextStyle.medium12,
                    text: "Đăng nhập ngay",
                    color: AppThemeColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
