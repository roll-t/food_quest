import 'dart:ui';

import 'package:food_quest/core/config/theme/app_colors.dart';

class AppColorScheme {
  final Color primary;
  final Color secondary;
  final Color error;

  final Color background300;
  final Color background200;
  final Color background100;
  final Color surface;
  final Color card;
  final Color appBar;

  final Color text;
  final Color text100;
  final Color text200;
  final Color text300;
  final Color textDark;
  final Color textLight;

  final Color textSecondary;
  final Color textDisabled;

  final Color icon;
  final Color iconInactive;
  final Color iconActive;

  final Color divider;
  final Color border;
  final Color light300;
  final Color light200;
  final Color light100;
  final Color dark700;
  final Color dark500;
  final Color dark300;

  const AppColorScheme({
    required this.primary,
    required this.secondary,
    required this.error,
    required this.background300,
    required this.background200,
    required this.background100,
    required this.surface,
    required this.card,
    required this.appBar,
    required this.text,
    required this.text100,
    required this.text200,
    required this.text300,
    required this.textDark,
    required this.textLight,
    required this.textSecondary,
    required this.textDisabled,
    required this.icon,
    required this.iconInactive,
    required this.iconActive,
    required this.divider,
    required this.border,
    required this.light300,
    required this.light200,
    required this.light100,
    required this.dark700,
    required this.dark500,
    required this.dark300,
  });
}

enum AppColorTheme { theme1, theme2 }

class AppColorThemeScheme {
  static AppColorScheme getColorSchemeLight(AppColorTheme theme) {
    switch (theme) {
      case AppColorTheme.theme1:
        return const AppColorScheme(
          primary: AppColors.primary2,
          secondary: AppColors.secondary500,
          error: AppColors.red,
          background300: AppColors.light200,
          background200: AppColors.light300,
          background100: AppColors.light100,
          surface: AppColors.neutralColor6,
          card: AppColors.neutralColor5,
          appBar: AppColors.primary500,
          text: AppColors.text700,
          text100: AppColors.text600,
          text200: AppColors.text500,
          text300: AppColors.text400,
          textDark: AppColors.text700,
          textLight: AppColors.text200,
          textSecondary: AppColors.text500,
          textDisabled: AppColors.text400,
          icon: AppColors.text500,
          iconActive: AppColors.primary2,
          iconInactive: AppColors.text400,
          divider: AppColors.neutralColor2,
          border: AppColors.neutralColor2,
          light300: AppColors.light300,
          light200: AppColors.light200,
          light100: AppColors.light100,
          dark700: AppColors.dark700,
          dark500: AppColors.dark500,
          dark300: AppColors.dark300,
        );

      case AppColorTheme.theme2:
        return const AppColorScheme(
          primary: AppColors.primary1,
          secondary: AppColors.secondary500,
          appBar: AppColors.primary1,
          error: AppColors.red,
          background300: AppColors.light200,
          background200: AppColors.light300,
          background100: AppColors.light100,
          surface: AppColors.neutralColor2,
          card: AppColors.neutralColor3,
          text: AppColors.text700,
          text100: AppColors.text600,
          text200: AppColors.text500,
          text300: AppColors.text400,
          textDark: AppColors.text700,
          textLight: AppColors.text200,
          textSecondary: AppColors.neutralColor5,
          textDisabled: AppColors.neutralColor4,
          icon: AppColors.neutralColor5,
          iconActive: AppColors.primary1,
          iconInactive: AppColors.text400,
          divider: AppColors.neutralColor4,
          border: AppColors.neutralColor4,
          light300: AppColors.light300,
          light200: AppColors.light200,
          light100: AppColors.light100,
          dark700: AppColors.dark700,
          dark500: AppColors.dark500,
          dark300: AppColors.dark300,
        );
    }
  }

  static AppColorScheme getColorSchemeDark(AppColorTheme theme) {
    switch (theme) {
      case AppColorTheme.theme1:
        return const AppColorScheme(
          primary: AppColors.primary2,
          secondary: AppColors.secondary500,
          error: AppColors.red,
          background300: AppColors.dark700,
          background200: AppColors.dark500,
          background100: AppColors.dark300,
          surface: AppColors.neutralColor6,
          card: AppColors.neutralColor5,
          appBar: AppColors.primary500,
          text: AppColors.light100,
          text100: AppColors.light200,
          text200: AppColors.light300,
          text300: AppColors.light300,
          textDark: AppColors.light100,
          textLight: AppColors.text100,
          textSecondary: AppColors.light200,
          textDisabled: AppColors.text300,
          icon: AppColors.text200,
          iconActive: AppColors.primary2,
          iconInactive: AppColors.text200,
          divider: AppColors.neutralColor5,
          border: AppColors.neutralColor5,
          light300: AppColors.light300,
          light200: AppColors.light200,
          light100: AppColors.light100,
          dark700: AppColors.dark700,
          dark500: AppColors.dark500,
          dark300: AppColors.dark300,
        );

      case AppColorTheme.theme2:
        return const AppColorScheme(
          primary: AppColors.primary1,
          secondary: AppColors.secondary500,
          appBar: AppColors.primary1,
          error: AppColors.red,
          background300: AppColors.dark700,
          background200: AppColors.dark500,
          background100: AppColors.dark300,
          surface: AppColors.neutralColor6,
          card: AppColors.neutralColor5,
          text: AppColors.light100,
          text100: AppColors.light200,
          text200: AppColors.light300,
          text300: AppColors.light300,
          textDark: AppColors.light300,
          textLight: AppColors.text100,
          textSecondary: AppColors.light200,
          textDisabled: AppColors.text300,
          icon: AppColors.text200,
          iconActive: AppColors.primary1,
          iconInactive: AppColors.text200,
          divider: AppColors.neutralColor5,
          border: AppColors.neutralColor5,
          light300: AppColors.light300,
          light200: AppColors.light200,
          light100: AppColors.light100,
          dark700: AppColors.dark700,
          dark500: AppColors.dark500,
          dark300: AppColors.dark300,
        );
    }
  }
}
