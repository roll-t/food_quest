import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final double height;
  final Function(DateTime)? onDateSelected;
  final bool enabled;
  final Color? backgroundColor;
  final String ? hint;

  const DateTimePickerTextField({
    super.key,
    required this.controller,
    this.height = 45,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.hint,
    this.onDateSelected,
    this.enabled = true,
    this.backgroundColor,
  });

  @override
  State<DateTimePickerTextField> createState() =>
      _DateTimePickerTextFieldState();
}

class _DateTimePickerTextFieldState extends State<DateTimePickerTextField> {
  void _showDatePicker() async {
    if (!widget.enabled) return;
    KeyboardUtils.hiddenKeyboard();
    DateTime initial = widget.initialDate ?? DateTime.now();
    DateTime first = widget.firstDate ?? DateTime(2000);
    DateTime last = widget.lastDate ?? DateTime(2100);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
      locale: const Locale('vi', 'VN'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: const DialogThemeData(
              backgroundColor: AppColors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formatted = DateFormat("dd/MM/yyyy").format(pickedDate);
      widget.controller.text = formatted;
      widget.onDateSelected?.call(pickedDate);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.enabled
        ? widget.backgroundColor ?? Colors.white
        : AppColors.palette5;

    return GestureDetector(
      onTap: widget.enabled ? _showDatePicker : null,
      child: AbsorbPointer(
        child: CustomTextField(
          controller: widget.controller,
          hintText: widget.hint ??'Chọn ngày',
          suffixIcon: Icon(
            Icons.calendar_today,
            size: 15,
            color: widget.enabled
                ? AppColors.neutralColor2
                : AppColors.neutralColor1,
          ),
          backgroundColor: bgColor,
          height: widget.height,
          enabled: widget.enabled,
        ),
      ),
    );
  }
}
