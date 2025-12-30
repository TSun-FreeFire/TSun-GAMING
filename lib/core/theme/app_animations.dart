import 'package:flutter/animation.dart';

/// Animation Configurations - Professional easing and durations
class AppAnimations {
  // ==================== CURVES ====================
  
  /// Smooth professional easing - cubic-bezier(0.645, 0.045, 0.355, 1)
  static const Curve smoothEase = Cubic(0.645, 0.045, 0.355, 1.0);
  
  /// Ease out for exits
  static const Curve easeOut = Curves.easeOut;
  
  /// Ease in for entries
  static const Curve easeIn = Curves.easeIn;
  
  /// Elastic for playful interactions
  static const Curve elastic = Curves.elasticOut;
  
  /// Spring for natural motion
  static const Curve spring = Curves.easeOutBack;
  
  // ==================== DURATIONS ====================
  
  /// Ultra fast - 150ms - for immediate feedback
  static const Duration ultraFast = Duration(milliseconds: 150);
  
  /// Fast - 250ms - for quick transitions
  static const Duration fast = Duration(milliseconds: 250);
  
  /// Normal - 400ms - for standard animations
  static const Duration normal = Duration(milliseconds: 400);
  
  /// Slow - 600ms - for emphasis
  static const Duration slow = Duration(milliseconds: 600);
  
  /// Very slow - 800ms - for hero animations
  static const Duration verySlow = Duration(milliseconds: 800);
  
  // ==================== DELAYS ====================
  
  /// Stagger delay for sequential animations
  static const Duration staggerShort = Duration(milliseconds: 50);
  static const Duration staggerMedium = Duration(milliseconds: 100);
  static const Duration staggerLong = Duration(milliseconds: 150);
  
  // ==================== ANIMATION CONFIGS ====================
  
  /// Fade in from bottom
  static const Offset slideUpStart = Offset(0, 0.3);
  static const Offset slideUpEnd = Offset(0, 0);
  
  /// Fade in from left
  static const Offset slideLeftStart = Offset(-0.2, 0);
  static const Offset slideLeftEnd = Offset(0, 0);
  
  /// Fade in from right
  static const Offset slideRightStart = Offset(0.2, 0);
  static const Offset slideRightEnd = Offset(0, 0);
  
  /// Scale entry
  static const double scaleStart = 0.8;
  static const double scaleEnd = 1.0;
  
  /// Rotation for loading spinners (in radians)
  static const double rotationFull = 6.28319; // 2π
}