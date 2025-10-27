import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:flutter/material.dart';

class YearPickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final int startYear;
  final int endYear;
  final double height;
  final Function(int)? onYearSelected;
  final bool enabled;
  final Color? backgroundColor;

  const YearPickerTextField({
    super.key,
    required this.controller,
    this.startYear = 1990,
    this.endYear = 2030,
    this.height = 45,
    this.onYearSelected,
    this.enabled = true,
    this.backgroundColor,
  });

  @override
  State<YearPickerTextField> createState() => _YearPickerTextFieldState();
}

class _YearPickerTextFieldState extends State<YearPickerTextField> {
  void _showYearPicker() async {
    if (!widget.enabled) return;
    KeyboardUtils.hiddenKeyboard();

    int? picked = await showDialog<int>(
      context: context,
      builder: (context) {
        int selectedYear = DateTime.now().year;

        return AlertDialog(
          title: const Text('Chọn năm'),
          content: SizedBox(
            height: 250,
            width: 300,
            child: YearPicker(
              firstDate: DateTime(widget.startYear),
              lastDate: DateTime(widget.endYear),
              selectedDate: DateTime(selectedYear),
              onChanged: (dateTime) {
                Navigator.pop(context, dateTime.year);
              },
            ),
          ),
        );
      },
    );

    if (picked != null) {
      widget.controller.text = picked.toString();
      widget.onYearSelected?.call(picked);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.enabled
        ? widget.backgroundColor ?? Colors.white
        : AppColors.palette5;

    return GestureDetector(
      onTap: widget.enabled ? _showYearPicker : null,
      child: AbsorbPointer(
        child: CustomTextField(
          controller: widget.controller,
          hintText: 'Chọn năm',
          suffixIcon: Icon(
            Icons.arrow_drop_down,
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
