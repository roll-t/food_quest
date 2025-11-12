import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/extension/export/extension.dart';
import 'package:food_quest/core/ui/animations/scale_on_tap.dart';
import 'package:food_quest/core/ui/widgets/images/cache_image_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FoodDetailWidget extends StatelessWidget {
  final FoodModel food;
  final bool hasThumbnail;
  const FoodDetailWidget({
    super.key,
    required this.food,
    this.hasThumbnail = false,
  });
  @override
  Widget build(BuildContext context) {
    Size containerSize = Size(95.w, 55.h);
    return Center(
      child: Container(
        width: containerSize.width,
        constraints: BoxConstraints(
          maxHeight: containerSize.height,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasThumbnail)
              CacheImageWidget(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                imageUrl: food.metaDataModel?.imageUrl,
                height: containerSize.height * .5,
                width: containerSize.width,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: AppEdgeInsets.all12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Row(
                    children: [
                      if (food.name?.isNotEmpty ?? false)
                        Expanded(
                          child: TextWidget(
                            text: (food.metaDataModel?.title).orEmpty(),
                            textStyle: AppTextStyle.semiBold20,
                            maxLines: 3,
                          ),
                        ),
                    ],
                  ),
                  if (food.metaDataModel?.description.isNotEmpty ?? false)
                    TextWidget(
                      textAlign: TextAlign.start,
                      text: (food.metaDataModel?.description).orEmpty(),
                      maxLines: 5,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 8,
                    children: [
                      Expanded(
                        child:
                            TextWidget(text: (food.name?.isNotEmpty ?? false) ? "Note: ${food.name}" : "", maxLines: 1),
                      ),
                      ScaleOnTap(
                        onTap: () {
                          if (food.metaDataModel?.url.isNotEmpty ?? false) {
                            Utils.lanchUrl(food.metaDataModel?.url ?? "/");
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppThemeColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                              const TextWidget(
                                text: "Đi đến bài viết",
                                color: AppColors.white,
                              ),
                              Utils.getSocialIcon(urlSocial: food.metaDataModel?.url) ?? const SizedBox.shrink()
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
