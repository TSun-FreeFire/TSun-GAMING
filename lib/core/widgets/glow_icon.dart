import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/design_tokens.dart';

/// Glow Icon - Icon with optional glow effect
/// Features: Fire/cyan/purple glow variants
enum GlowType {
  none,
  fire,
  cyan,
  purple,
}

class GlowIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;
  final GlowType glowType;
  
  const GlowIcon({
    super.key,
    required this.icon,
    this.size = DesignTokens.iconLarge,
    this.color,
    this.glowType = GlowType.none,
  });
  
  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? AppTheme.textMain;
    
    if (glowType == GlowType.none) {
      return Icon(
        icon,
        size: size,
        color: iconColor,
      );
    }
    
    Color glowColor;
    switch (glowType) {
      case GlowType.fire:
        glowColor = AppTheme.primary;
        break;
      case GlowType.cyan:
        glowColor = AppTheme.accentCyan;
        break;
      case GlowType.purple:
        glowColor = AppTheme.accentPurple;
        break;
      case GlowType.none:
        glowColor = Colors.transparent;
    }
    
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(
        icon,
        size: size,
        color: iconColor,
      ),
    );
  }
}