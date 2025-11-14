import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_images.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/ui/widgets/images/asset_image_widget.dart';
import 'package:food_quest/core/utils/custom_state.dart';
import 'package:food_quest/main/food/presentation/widgets/add_food_widget.dart';

class AddFromDeepLinkPage extends CustomState {
  const AddFromDeepLinkPage({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AssetImageWidget(
            assetPath: AppImages.iLogo,
            width: 120,
          ),
          SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: AddFoodWidget(),
          ),
        ],
      ),
    );
  }
}
