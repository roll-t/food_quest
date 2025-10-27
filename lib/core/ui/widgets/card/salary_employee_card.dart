
import 'package:food_quest/core/config/const/app_images.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/ui/widgets/images/asset_image_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/ui/widgets/wrap_body_widget.dart';
import 'package:flutter/material.dart';

class SalaryEmployeeCard extends StatelessWidget {
  const SalaryEmployeeCard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: WrapBodyWidget(
          backgroundHeader: AppColors.text200,
          header: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                    color: AppColors.text200,
                  ),
                ),
                width: 35,
                height: 35,
                child: AssetImageWidget(
                  borderRadius: BorderRadius.circular(1000),
                  assetPath: AppImages.iLogo,
                ),
              ),
              const SizedBox(width: 10),
              const TextWidget(
                text: "Tên Nhân viên",
                textStyle: AppTextStyle.medium14,
              )
            ],
          ),
          child: const Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      text: "Tổng thu nhập",
                      textStyle: AppTextStyle.regular14,
                    ),
                  ),
                  TextWidget(
                    text: "984234.4234 VND",
                    textStyle: AppTextStyle.bold14,
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      text: "Tổng Khấu trừ",
                      textStyle: AppTextStyle.regular14,
                    ),
                  ),
                  TextWidget(
                    text: "984234.4234 VND",
                    textStyle: AppTextStyle.bold14,
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      text: "Tạm ứng",
                      textStyle: AppTextStyle.regular14,
                    ),
                  ),
                  TextWidget(
                    text: "984234.4234 VND",
                    textStyle: AppTextStyle.bold14,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Divider(
                thickness: .5,
                color: AppColors.text400,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      text: "Lương thực lĩnh",
                      textStyle: AppTextStyle.regular14,
                    ),
                  ),
                  TextWidget(
                    color: AppColors.green,
                    text: "984234.4234 VND",
                    textStyle: AppTextStyle.bold14,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
