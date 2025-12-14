import 'package:flutter/material.dart';

class AppColors {
  // Primary Gradient Colors
  static const Color primaryBlue = Color(0xFF4A00E0);
  static const Color primaryViolet = Color(0xFF8E2DE2);
  
  // Secondary / Accent
  static const Color accentCyan = Color(0xFF00D2FF);
  static const Color accentPink = Color(0xFFFF4081);

  // Backgrounds
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color backgroundDark = Color(0xFF1A1A2E);
  static const Color cardDark = Color(0xFF16213E);
  static const Color cardLight = Colors.white;

  // Text
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textLight = Color(0xFFE94560); // Used sparingly or for accents
  static const Color textWhite = Colors.white;
  static const Color textGrey = Colors.grey;

  // Status
  static const Color success = Color(0xFF00C851);
  static const Color error = Color(0xFFFF4444);
  static const Color warning = Color(0xFFFFBB33);

  // Gradients
  static const LinearGradient mainGradient = LinearGradient(
    colors: [primaryViolet, primaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF233329), Color(0xFF63D471)], // Example placeholder
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
