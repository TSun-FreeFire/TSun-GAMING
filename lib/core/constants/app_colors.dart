import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Legacy AppColors - Redirects to new AppTheme for backward compatibility
/// @deprecated Use AppTheme instead
class AppColors {
  // Primary Colors (redirected to AppTheme)
  static const Color primary = AppTheme.primary;
  static const Color secondary = AppTheme.accentCyan;
  static const Color accent = AppTheme.accentPurple;
  
  // Background Colors
  static const Color background = AppTheme.bgCore;
  static const Color surface = AppTheme.bgSurface;
  
  // Text Colors
  static const Color textPrimary = AppTheme.textMain;
  static const Color textSecondary = AppTheme.textMuted;
  
  // Status Colors
  static const Color error = AppTheme.error;
  static const Color success = AppTheme.success;
  
  // Gradient Colors
  static const LinearGradient primaryGradient = AppTheme.fireGradient;
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [AppTheme.bgCore, AppTheme.bgSurface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}