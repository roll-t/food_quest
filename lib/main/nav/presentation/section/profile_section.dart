// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:food_quest/core/ui/widgets/app_bar/main_appbar.dart';
import 'package:food_quest/core/ui/widgets/standard_layout_widget.dart';
import 'package:food_quest/core/utils/custom_state.dart';
import 'package:food_quest/main/setting/presentation/page/setting_page.dart';
import 'package:food_quest/core/config/theme/theme_controller.dart';
import 'package:food_quest/main/user/features/profile/presentation/widgets/info_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSection extends CustomState {
  const ProfileSection({super.key});

  @override
  Widget buildBody(BuildContext context) => const _ThemeBuilder();
}

///---> [Theme-setting-status]
class _ThemeBuilder extends StatelessWidget {
  const _ThemeBuilder();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      id: "THEME_SITTING_ID",

      ///[Not set const to update the status]
      // ignore: prefer_const_constructors
      builder: (context) => _BodyBuilder(),
    );
  }
}

class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return StandardLayoutWidget(
      appBar: const MainAppBar(title: "Cá nhân"),
      padding: EdgeInsets.zero,
      bodyBuilder: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          ///[Not set const to update the status]
          // ignore: prefer_const_constructors
          InfoProfileWidget(),
          const SizedBox(height: 40),

          ///[Not set const to update the status]
          // ignore: prefer_const_constructors
          SettingPage(),
        ],
      ),
    );
  }
}
