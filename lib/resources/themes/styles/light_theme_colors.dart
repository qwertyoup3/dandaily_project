import 'package:flutter/material.dart';
import '/resources/themes/styles/color_styles.dart';

/* Light Theme Colors
|-------------------------------------------------------------------------- */

class LightThemeColors implements ColorStyles {
  // general
  @override
  Color get background => const Color.fromARGB(255, 255, 255, 255);

  @override
  Color get content => const Color(0xFF000000);
  @override
  Color get primaryAccent => const Color.fromARGB(255, 129, 184, 154);

  @override
  Color get surfaceBackground => const Color.fromARGB(255, 255, 255, 255);
  @override
  Color get surfaceContent => Colors.black;

  // app bar
  @override
  Color get appBarBackground => Colors.white;
  @override
  Color get appBarPrimaryContent => Colors.black;

  // buttons
  @override
  Color get buttonBackground => const Color.fromARGB(255, 129, 184, 154);
  @override
  Color get buttonContent => Colors.white;

  @override
  Color get buttonSecondaryBackground => const Color(0xff151925);
  @override
  Color get buttonSecondaryContent =>
      Colors.white.withAlpha((255.0 * 0.9).round());

  // bottom tab bar
  @override
  Color get bottomTabBarBackground => Colors.white;

  // bottom tab bar - icons
  @override
  Color get bottomTabBarIconSelected =>
      const Color.fromARGB(255, 129, 184, 154);
  @override
  Color get bottomTabBarIconUnselected => const Color.fromARGB(255, 55, 89, 75);

  // bottom tab bar - label
  @override
  Color get bottomTabBarLabelUnselected =>
      const Color.fromARGB(255, 129, 184, 154);
  @override
  Color get bottomTabBarLabelSelected => const Color.fromARGB(255, 55, 89, 75);

  // toast notification
  @override
  Color get toastNotificationBackground =>
      const Color.fromARGB(255, 255, 255, 255);
}
