import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/extension/core/empty_extensions.dart';
import 'package:food_quest/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:food_quest/core/ui/widgets/inputs/date_time_picker_text_field_widget.dart';
import 'package:food_quest/core/ui/widgets/inputs/year_picker_text_field_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_span_widget.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final double? textSize;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? leading;
  final bool enabled;
  final String? errorText;
  final int maxLines;
  final int minLines;
  final Function(String)? onChanged;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;
  final BottomSheetController? bottomSheetController;
  final Function(String)? onSubmit;

  final double borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color disabledBorderColor;
  final Color errorBorderColor;
  final double borderWidth;
  final bool enableBorder;
  final EdgeInsets? scrollPadding;
  final bool isRequired;
  final bool hasClear;
  final FocusNode? focusNode;

  final double? height;
  final List<BoxShadow>? boxShadow;

  /// NEW: type of input
  final CustomTextFieldType type;

  /// Dropdown-specific
  final VoidCallback? onTap;

  /// DatePicker-specific
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime)? onDateSelected;

  /// YearPicker-specific
  final int? startYear;
  final int? endYear;
  final Function(int)? onYearSelected;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.textSize,
    this.controller,
    this.scrollPadding,
    this.onSubmit,
    this.bottomSheetController,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.leading,
    this.enabled = true,
    this.errorText,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    this.enableBorder = true,
    this.backgroundColor,
    this.isRequired = false,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.borderRadius = 8,
    this.borderColor = AppColors.text400,
    this.focusedBorderColor = AppColors.text300,
    this.disabledBorderColor = Colors.grey,
    this.errorBorderColor = Colors.red,
    this.borderWidth = .5,
    this.height = 45,
    this.boxShadow,
    this.type = CustomTextFieldType.text,
    this.onTap,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.hasClear = false,
    this.startYear,
    this.endYear,
    this.onYearSelected,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    Widget inputChild;

    switch (type) {
      case CustomTextFieldType.text:
        inputChild = _buildTextField();
        break;
      case CustomTextFieldType.money:
        inputChild = _buildMoneyField();
        break;
      case CustomTextFieldType.dropdown:
        inputChild = InkWell(
          onTap: () {
            KeyboardUtils.hiddenKeyboard();
            onTap?.call();
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: IgnorePointer(
            child: _buildTextField(),
          ),
        );
        break;
      case CustomTextFieldType.datePicker:
        inputChild = DateTimePickerTextField(
          hint: hintText,
          controller: controller ?? TextEditingController(),
          firstDate: firstDate ?? DateTime(2000),
          lastDate: lastDate ?? DateTime.now(),
          onDateSelected: onDateSelected,
          enabled: enabled,
          backgroundColor: enabled
              ? backgroundColor ?? AppThemeColors.background100
              : AppThemeColors.background300,
        );
        break;
      case CustomTextFieldType.yearPicker:
        inputChild = YearPickerTextField(
          controller: controller ?? TextEditingController(),
          startYear: startYear ?? 2000,
          endYear: endYear ?? DateTime.now().year,
          onYearSelected: onYearSelected,
          enabled: enabled,
          backgroundColor: enabled
              ? backgroundColor ?? AppThemeColors.background100
              : AppThemeColors.background300,
        );
        break;
      case CustomTextFieldType.textArea:
        inputChild = _buildTextAreaField();
        break;
    }

    if (leading != null) {
      inputChild = Row(
        children: [
          leading!,
          const SizedBox(width: 8),
          Expanded(child: inputChild),
        ],
      );
    }

    Widget decorated = Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppThemeColors.background100,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: inputChild,
    );

    decorated = IgnorePointer(
      ignoring: !enabled,
      child: decorated,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          TextSpanWidget(
              size: 14,
              fontWeight1: FontWeight.w600,
              fontWeight2: FontWeight.w600,
              textColor1: labelColor ?? AppThemeColors.text,
              textColor2: AppColors.red,
              text1: label.orNA(),
              text2: isRequired ? "*" : ""),
          const SizedBox(height: 6),
        ],
        decorated,
      ],
    );
  }

  Widget _buildTextField() {
    InputBorder buildBorder(Color color) => !enableBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: AppColors.transparent,
              width: 0,
            ),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: color, width: borderWidth),
          );

    return TextField(
      focusNode: focusNode,
      scrollPadding: scrollPadding ?? EdgeInsets.zero,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmit,
      style: TextStyle(
        color: textColor ?? AppThemeColors.text100,
        fontSize: textSize ?? 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: enabled
            ? backgroundColor ?? AppThemeColors.background100
            : AppThemeColors.background300,
        hintText: hintText,
        hintStyle: TextStyle(
            color: hintColor ?? AppColors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        prefixIcon: prefixIcon,
        errorText: errorText,
        enabledBorder: buildBorder(borderColor),
        focusedBorder: buildBorder(focusedBorderColor),
        disabledBorder: buildBorder(disabledBorderColor),
        errorBorder: buildBorder(errorBorderColor),
        focusedErrorBorder: buildBorder(errorBorderColor),
        contentPadding: EdgeInsets.symmetric(
          vertical: height != null ? (height! - 24) / 2 : 12,
          horizontal: 12,
        ),
        suffixIcon: suffixIcon ??
            ((enabled && hasClear)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => controller?.clear(),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppThemeColors.text300.withValues(alpha: .5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 12,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink()),
      ),
    );
  }

  Widget _buildTextAreaField() {
    InputBorder buildBorder(Color color) => !enableBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                const BorderSide(color: AppColors.transparent, width: 0),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: color, width: borderWidth),
          );

    return TextField(
      controller: controller,
      scrollPadding: scrollPadding ?? EdgeInsets.zero,
      keyboardType: TextInputType.multiline,
      maxLines: maxLines > 1 ? maxLines : 5, // mặc định textarea = 5 dòng
      minLines: minLines > 1 ? minLines : 3, // mặc định min 3 dòng
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmit,
      style: TextStyle(
        color: textColor ?? AppColors.text700,
        fontSize: textSize ?? 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: enabled
            ? backgroundColor ?? AppThemeColors.background100
            : AppThemeColors.background300,
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor ?? AppColors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
        enabledBorder: buildBorder(borderColor),
        focusedBorder: buildBorder(focusedBorderColor),
        disabledBorder: buildBorder(disabledBorderColor),
        errorBorder: buildBorder(errorBorderColor),
        focusedErrorBorder: buildBorder(errorBorderColor),
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }

  Widget _buildMoneyField() {
    InputBorder buildBorder(Color color) => !enableBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: color, width: borderWidth),
          );
    return TextField(
      focusNode: focusNode,
      controller: controller,
      scrollPadding: scrollPadding ?? EdgeInsets.zero,
      keyboardType:
          const TextInputType.numberWithOptions(decimal: false, signed: false),
      textInputAction: TextInputAction.done,
      inputFormatters: [
        TextInputFormatter.withFunction(
          (oldValue, newValue) {
            if (newValue.text.isEmpty) {
              return const TextEditingValue(
                text: '0',
                selection: TextSelection.collapsed(offset: 1),
              );
            }

            final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
            final numericValue = int.tryParse(digits) ?? 0;

            if (numericValue > 999999999999) {
              return oldValue;
            }

            final formatted =
                NumberFormat("#,###", "vi_VN").format(numericValue);

            // Tính toán lại offset để caret không luôn nhảy về cuối
            final diff = formatted.length - newValue.text.length;
            final newOffset =
                (newValue.selection.end + diff).clamp(0, formatted.length);

            return TextEditingValue(
              text: formatted,
              selection: TextSelection.collapsed(offset: newOffset),
            );
          },
        )
      ],
      style: TextStyle(
        color: textColor ?? AppThemeColors.text100,
        fontSize: textSize ?? 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: enabled
            ? backgroundColor ?? AppThemeColors.background100
            : AppThemeColors.background300,
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor ?? Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            suffixIcon ??
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: Center(
                    child: Text(
                      "VND",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
            if (enabled)
              GestureDetector(
                onTap: () => controller?.clear(),
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 5,
                    right: 10,
                  ),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppThemeColors.text300.withValues(alpha: .5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 12,
                    color: AppColors.white,
                  ),
                ),
              )
          ],
        ),
        errorText: errorText,
        enabledBorder: buildBorder(borderColor),
        focusedBorder: buildBorder(focusedBorderColor),
        disabledBorder: buildBorder(disabledBorderColor),
        errorBorder: buildBorder(errorBorderColor),
        focusedErrorBorder: buildBorder(errorBorderColor),
        contentPadding: EdgeInsets.symmetric(
          vertical: height != null ? (height! - 24) / 2 : 12,
          horizontal: 12,
        ),
      ),
    );
  }
}
