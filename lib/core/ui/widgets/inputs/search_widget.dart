import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_vectors.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/inputs/custom_text_field.dart';

class SearchWidget extends StatelessWidget {
  final Function(String value)? onSearch;
  final Function(String value)? onSubmit;
  final TextEditingController? searchController;
  final double height;
  final String hint;
  final Color? backgroundColor;
  const SearchWidget({
    super.key,
    this.hint = "Nhập nội dung tìm kiếm....",
    this.onSearch,
    this.onSubmit,
    this.height = 45,
    this.backgroundColor,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: searchController,
      onSubmit: onSubmit,
      onChanged: onSearch,
      enableBorder: true,
      borderColor: AppThemeColors.light100,
      borderWidth: 1,
      textSize: 14,
      hintText: hint,
      prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 8.0,
            bottom: 8.0,
          ),
          child: AppVectors.icSearch.show(
            color: AppColors.grey.withValues(alpha: .5),
            size: 20,
          )),
      backgroundColor: backgroundColor ?? AppThemeColors.background300,
      boxShadow: const [],
      height: height,
    );
  }
}
