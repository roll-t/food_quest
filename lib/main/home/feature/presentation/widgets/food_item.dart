import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_icons.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/extension/export/extension.dart';
import 'package:food_quest/core/ui/widgets/images/cache_image_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({
    super.key,
    required this.food,
    this.onRemove,
  });

  final FoodModel food;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(16));

    return Stack(
      children: [
        Container(
          margin: AppEdgeInsets.all8,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.blue.shade100,
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Stack(
              fit: StackFit.expand,
              children: [
                /// ẢNH NỀN
                CacheImageWidget(
                  imageUrl: food.image.orEmpty(),
                  fit: BoxFit.cover,
                ),

                /// CHỮ TÊN MÓN
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.white.withOpacity(.85),
                    ),
                    child: TextWidget(
                      text: food.name.orNA(),
                      textStyle: AppTextStyle.medium12,
                      colorFixed: true,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// NÚT XOÁ
        if (onRemove.isNotNull)
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: AppIcons.icCloseV2.show(),
            ),
          ),
      ],
    );
  }
}
