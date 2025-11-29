import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors (Refined for Premium Feel)
  static const Color primaryBlue = Color(
    0xFF007AFF,
  ); // iOS-like Blue, more vibrant
  static const Color primaryGreen = Color(0xFF34C759); // Vibrant Green
  static const Color primaryYellow = Color(0xFFFFCC00); // Warm Yellow
  static const Color primaryOrange = Color(
    0xFFFF9500,
  ); // Added Orange for "Hungry" vibe

  // Light Theme Colors
  static const Color backgroundLight = Color(
    0xFFF2F2F7,
  ); // Light Gray (iOS style)
  static const Color surfaceLight = Colors.white;
  static const Color textPrimaryLight = Color(0xFF000000);
  static const Color textSecondaryLight = Color(
    0xFF3C3C43,
  ); // 60% opacity equivalent
  static const Color inputBackgroundLight = Color(0xFFE5E5EA);
  static const Color borderLight = Color(0xFFC6C6C8);

  // Dark Theme Colors
  static const Color backgroundDark = Color(0xFF000000); // Pure Black for OLED
  static const Color surfaceDark = Color(0xFF1C1C1E); // Dark Gray
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Color(
    0xFFEBEBF5,
  ); // 60% opacity equivalent
  static const Color inputBackgroundDark = Color(0xFF2C2C2E);
  static const Color borderDark = Color(0xFF38383A);

  // Functional Colors
  static const Color error = Color(0xFFFF3B30);
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFFCC00);

  // Backward Compatibility (Aliases for existing code)
  static const Color surface = surfaceLight;
  static const Color background = backgroundLight;
  static const Color textPrimary = textPrimaryLight;
  static const Color textSecondary = textSecondaryLight;
  static const Color inputBackground = inputBackgroundLight;
  static const Color inputBorder = borderLight;
  static const Color textLight = Colors.white;
}
