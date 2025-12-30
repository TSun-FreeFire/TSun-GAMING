import 'package:flutter/material.dart';

/// Premium Cyberpunk Theme - Dark Mode First Design System
/// Inspired by high-tech aesthetics with fire/energy accents
class AppTheme {
  // ==================== CORE COLORS ====================
  
  /// Deep black foundation - #050505
  static const Color bgCore = Color(0xFF050505);
  
  /// Rich black surface - #0f0f0f
  static const Color bgSurface = Color(0xFF0F0F0F);
  
  /// Glassmorphic card background - rgba(20, 20, 20, 0.7)
  static const Color cardBackground = Color(0xB3141414);
  
  /// Fire orange primary - #FF4500
  static const Color primary = Color(0xFFFF4500);
  
  /// Bright fire orange variant for intense accents
  static const Color primaryBright = Color(0xFFFF6B35);
  
  /// Cyan glow accent - #00f2ff
  static const Color accentCyan = Color(0xFF00F2FF);
  
  /// Purple glow accent - #bd00ff
  static const Color accentPurple = Color(0xFFBD00FF);
  
  /// Pure white text - #ffffff
  static const Color textMain = Color(0xFFFFFFFF);
  
  /// Soft gray muted text - #a0a0a0
  static const Color textMuted = Color(0xFFA0A0A0);
  
  /// Subtle border - rgba(255, 255, 255, 0.1)
  static const Color borderLight = Color(0x1AFFFFFF);
  
  /// Hover border - rgba(255, 255, 255, 0.2)
  static const Color borderHover = Color(0x33FFFFFF);
  
  /// Success/confirmation color
  static const Color success = Color(0xFF06FFA5);
  
  /// Error/danger color
  static const Color error = Color(0xFFF72585);
  
  // ==================== GRADIENTS ====================
  
  /// Fire gradient for primary actions
  static const LinearGradient fireGradient = LinearGradient(
    colors: [Color(0xFFFF4500), Color(0xFFFF6B35)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Cyan energy gradient
  static const LinearGradient cyanGradient = LinearGradient(
    colors: [Color(0xFF00F2FF), Color(0xFF00D4E6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Purple energy gradient
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFFBD00FF), Color(0xFF9500CC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Success gradient
  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF06FFA5), Color(0xFF1B998B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Mesh background gradient with radial circles
  static const RadialGradient meshGradientOrange = RadialGradient(
    colors: [
      Color(0x33FF4500), // 20% opacity fire orange
      Color(0x00FF4500), // transparent
    ],
    stops: [0.0, 1.0],
    radius: 1.5,
  );
  
  static const RadialGradient meshGradientPurple = RadialGradient(
    colors: [
      Color(0x33BD00FF), // 20% opacity purple
      Color(0x00BD00FF), // transparent
    ],
    stops: [0.0, 1.0],
    radius: 1.2,
  );
  
  // ==================== SHADOWS & GLOWS ====================
  
  /// Fire glow shadow for primary elements
  static List<BoxShadow> fireGlow({double intensity = 0.4}) => [
    BoxShadow(
      color: primary.withOpacity(intensity),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    ),
  ];
  
  /// Cyan glow shadow
  static List<BoxShadow> cyanGlow({double intensity = 0.3}) => [
    BoxShadow(
      color: accentCyan.withOpacity(intensity),
      blurRadius: 16,
      spreadRadius: 0,
      offset: const Offset(0, 6),
    ),
  ];
  
  /// Purple glow shadow
  static List<BoxShadow> purpleGlow({double intensity = 0.3}) => [
    BoxShadow(
      color: accentPurple.withOpacity(intensity),
      blurRadius: 16,
      spreadRadius: 0,
      offset: const Offset(0, 6),
    ),
  ];
  
  /// Subtle card elevation
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 12,
      spreadRadius: 0,
      offset: const Offset(0, 4),
    ),
  ];
  
  /// Focus glow for inputs
  static BoxShadow focusGlow({Color? color}) => BoxShadow(
    color: (color ?? primary).withOpacity(0.3),
    blurRadius: 0,
    spreadRadius: 4,
    offset: Offset.zero,
  );
  
  // ==================== THEME DATA ====================
  
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgCore,
    primaryColor: primary,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: accentCyan,
      tertiary: accentPurple,
      surface: bgSurface,
      error: error,
      onPrimary: textMain,
      onSecondary: textMain,
      onSurface: textMain,
      onError: textMain,
    ),
  );
}