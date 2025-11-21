// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/config/theme/theme_controller.dart';
import 'package:food_quest/features/setting/presentation/page/setting_page.dart';
import 'package:food_quest/features/user/features/profile/presentation/widgets/info_profile_widget.dart';
import 'package:get/get.dart';

///Nav profile
class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});
  @override
  Widget build(BuildContext context) => const _ThemeBuilder();
}

///---> [Theme-setting-status]
class _ThemeBuilder extends StatelessWidget {
  const _ThemeBuilder();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      id: "THEME_SITTING_ID",

      ///[Not set const to update the status]
      builder: (context) => _BodyBuilder(),
    );
  }
}

class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppThemeColors.background300,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          SizedBox(height: 16),
          InfoProfileWidget(),
          SizedBox(height: 40),
          SettingPage(),
        ],
      ),
    );
  }
}
