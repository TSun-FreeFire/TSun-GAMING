import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';

/// Typography System - Premium fonts with professional hierarchy
/// Uses Outfit for bold headings, Inter for UI, JetBrains Mono for data
class AppTypography {
  // ==================== HEADINGS (Outfit) ====================
  
  /// Extra large heading - App name, hero text
  static TextStyle get h1 => GoogleFonts.outfit(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppTheme.textMain,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  /// Large heading - Section titles
  static TextStyle get h2 => GoogleFonts.outfit(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppTheme.textMain,
    height: 1.3,
    letterSpacing: -0.3,
  );
  
  /// Medium heading - Card titles
  static TextStyle get h3 => GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppTheme.textMain,
    height: 1.3,
  );
  
  /// Small heading - Subsection titles
  static TextStyle get h4 => GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppTheme.textMain,
    height: 1.4,
  );
  
  // ==================== UI TEXT (Inter) ====================
  
  /// Large body text
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppTheme.textMain,
    height: 1.5,
  );
  
  /// Regular body text
  static TextStyle get body => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppTheme.textMain,
    height: 1.5,
  );
  
  /// Small body text
  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppTheme.textMuted,
    height: 1.4,
  );
  
  /// Button text - uppercase, bold, letter-spaced
  static TextStyle get button => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppTheme.textMain,
    height: 1.0,
    letterSpacing: 1.2,
  );
  
  /// Large button text
  static TextStyle get buttonLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppTheme.textMain,
    height: 1.0,
    letterSpacing: 1.2,
  );
  
  /// Label text
  static TextStyle get label => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppTheme.textMuted,
    height: 1.3,
    letterSpacing: 0.5,
  );
  
  /// Caption text
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppTheme.textMuted,
    height: 1.3,
  );
  
  // ==================== DATA/CODE (JetBrains Mono) ====================
  
  /// Monospace for data display - UID, passwords, technical info
  static TextStyle get mono => GoogleFonts.jetBrainsMono(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppTheme.textMain,
    height: 1.5,
    letterSpacing: 0.5,
  );
  
  /// Large monospace
  static TextStyle get monoLarge => GoogleFonts.jetBrainsMono(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppTheme.textMain,
    height: 1.5,
    letterSpacing: 0.5,
  );
  
  /// Small monospace
  static TextStyle get monoSmall => GoogleFonts.jetBrainsMono(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppTheme.textMuted,
    height: 1.4,
    letterSpacing: 0.3,
  );
  
  // ==================== UTILITIES ====================
  
  /// Add color to any text style
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }
  
  /// Add weight to any text style
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
}