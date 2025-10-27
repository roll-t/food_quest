import 'package:food_quest/core/local_storage/app_get_storage.dart';
import 'package:food_quest/core/lang/translation_service.dart';

Future<void> languageConfigs() async {
  // Lấy ngôn ngữ mặc định, mặc định là tiếng Anh
  String language = AppGetStorage.getLanguage();
  // Thiết lập ngôn ngữ sử dụng dịch vụ localization của bạn
  LocalizationService.changeLocale(language == 'English' ? 'en' : 'vi');
}
