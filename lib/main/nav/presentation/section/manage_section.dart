import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/ui/widgets/app_bar/main_appbar.dart';
import 'package:food_quest/core/ui/widgets/standard_layout_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/ui/widgets/wrap_body_widget.dart';
import 'package:food_quest/core/utils/custom_state.dart';
import 'package:food_quest/main/nav/model/item_menu_feature_model.dart';
import 'package:food_quest/main/nav/presentation/controller/manage_controller.dart';
import 'package:food_quest/main/nav/presentation/widgets/item_menu_feature_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// NAV Manage
class ManageSection extends CustomState {
  const ManageSection({super.key});

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

class _BodyBuilder extends GetView<ManageController> {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return StandardLayoutWidget(
      appBar: const MainAppBar(title: "Quản Lý"),
      bodyBuilder: SingleChildScrollView(
        child: Column(
          children: [
            _buildFeatureSection(
              title: "Quản lý Showroom",
              items: controller.listShowroomFeature,
            ),
            const SizedBox(height: 20),
            _buildFeatureSection(
              title: "Cửa hàng cầm đồ",
              items: controller.listCreditFeature,
            ),
            const SizedBox(height: 20),
            _buildFeatureSection(
              title: "Công ty vàng bạc",
              items: controller.listDiamondFeature,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureSection({
    required String title,
    required List<ItemMenuFeatureModel> items,
  }) {
    return WrapBodyWidget(
      header: TextWidget(
        text: title,
        textStyle: AppTextStyle.bold16,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        itemBuilder: (_, index) {
          final item = items[index];
          return ItemMenuFeatureWidget(
            title: item.title,
            iconUrl: item.iconUrl,
            routeNameUrl: item.routeNameUrl,
          );
        },
      ),
    );
  }
}
