import 'package:flutter/material.dart';

class AppTextStyle {
  // Headings
  static TextStyle get h1 => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      );

  static TextStyle get h2 => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      );

  static TextStyle get h3 => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      );

  // Body text
  static TextStyle get bodyLarge => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      );

  // Buttons
  static TextStyle get buttonLarge => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  static TextStyle get buttonMedium => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  // Labels and captions
  static TextStyle get label => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      );

  // Hymn-specific styles
  static TextStyle get hymnTitle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      );

  static TextStyle get hymnNumber => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      );

  static TextStyle get hymnVerse => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
        height: 1.5,
      );
}

// Extension for easy color changes
extension TextStyleExtension on TextStyle {
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }
}