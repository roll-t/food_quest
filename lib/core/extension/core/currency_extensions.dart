import 'package:food_quest/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:intl/intl.dart';

extension StringCurrencyExtension on String? {
  String toCurrency({bool withSymbol = false}) {
    if (this == null || this!.trim().isEmpty) return '';

    final raw = this!.trim();

    final normalized = raw.replaceAll(',', '.');

    final value = num.tryParse(normalized);
    if (value == null) return this!;

    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: withSymbol ? ' VND' : '',
      decimalDigits: 0,
    );

    return formatter.format(value).trim();
  }

  num toCurrencyNum() {
    if (this == null || this!.trim().isEmpty) return 0;

    var cleaned = this!.replaceAll(RegExp(r'[^0-9,]'), '');

    if (cleaned.contains(',')) {
      var parts = cleaned.split(',');
      cleaned = '${parts[0]}.${parts[1]}';
      return double.tryParse(cleaned) ?? 0;
    }
    return int.tryParse(cleaned) ?? 0;
  }
}

extension CurrencyFormatter on String {
  String toCurrencyWithUnit(BottomSheetController currencyUnitController) {
    if (trim().isEmpty) return "0";

    final value = double.tryParse(this) ?? 0;

    final String unitId = currencyUnitController.itemSelected.value.id ?? "";
    final String unitTitle =
        currencyUnitController.itemSelected.value.title ?? "";

    double convertedValue = value;
    switch (unitId) {
      case "million":
        convertedValue = value / 1000000;
        break;
      case "billion":
        convertedValue = value / 1000000000;
        break;
      case "vnd":
      default:
        convertedValue = value;
    }

    // Nếu là triệu hoặc tỷ -> có 2 số thập phân
    final formatter = (unitId == "million" || unitId == "billion")
        ? NumberFormat('#,##0.00', 'vi_VN')
        : NumberFormat('#,###', 'vi_VN');

    String formatted = formatter.format(convertedValue);

    // Đổi dấu phân cách nghìn thành khoảng trắng
    if (formatted.contains(',')) {
      final parts = formatted.split(',');
      formatted =
          '${parts[0].replaceAll('.', '.')}${unitId == "million" || unitId == "billion" ? ',${parts[1]}' : ''}';
    } else {
      formatted = formatted.replaceAll('.', '.');
    }

    return "$formatted $unitTitle";
  }
}
