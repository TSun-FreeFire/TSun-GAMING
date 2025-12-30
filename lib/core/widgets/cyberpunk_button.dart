import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../theme/design_tokens.dart';
import '../theme/app_animations.dart';

/// Cyberpunk Button - Action button with gradient and glow
/// Features: Fire/cyan gradient, glow shadow, hover lift, press animation
class CyberpunkButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final List<BoxShadow>? glowShadows;
  final double height;
  final double? width;
  final bool isOutline;
  final Color? outlineColor;
  final bool isLoading;
  
  const CyberpunkButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.gradient,
    this.glowShadows,
    this.height = DesignTokens.buttonLarge,
    this.width,
    this.isOutline = false,
    this.outlineColor,
    this.isLoading = false,
  });
  
  @override
  State<CyberpunkButton> createState() => _CyberpunkButtonState();
}

class _CyberpunkButtonState extends State<CyberpunkButton> {
  bool _isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    final gradient = widget.gradient ?? AppTheme.fireGradient;
    final glowShadows = widget.glowShadows ?? AppTheme.fireGlow();
    
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        curve: AppAnimations.smoothEase,
        width: widget.width ?? double.infinity,
        height: widget.height,
        transform: Matrix4.translationValues(
          0,
          _isPressed ? DesignTokens.pressSink : 0,
          0,
        ),
        decoration: BoxDecoration(
          gradient: widget.isOutline ? null : gradient,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
          border: widget.isOutline
              ? Border.all(
                  color: widget.outlineColor ?? AppTheme.primary,
                  width: DesignTokens.borderMedium,
                )
              : null,
          boxShadow: widget.isOutline ? null : (_isPressed ? null : glowShadows),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isLoading ? null : widget.onPressed,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
            child: Container(
              alignment: Alignment.center,
              child: widget.isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.isOutline
                              ? (widget.outlineColor ?? AppTheme.primary)
                              : AppTheme.textMain,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            color: widget.isOutline
                                ? (widget.outlineColor ?? AppTheme.primary)
                                : AppTheme.textMain,
                            size: DesignTokens.iconLarge,
                          ),
                          const SizedBox(width: DesignTokens.space12),
                        ],
                        Text(
                          widget.label.toUpperCase(),
                          style: AppTypography.button.copyWith(
                            color: widget.isOutline
                                ? (widget.outlineColor ?? AppTheme.primary)
                                : AppTheme.textMain,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: AppAnimations.slow)
        .scale(
          begin: const Offset(AppAnimations.scaleStart, AppAnimations.scaleStart),
          end: const Offset(AppAnimations.scaleEnd, AppAnimations.scaleEnd),
          curve: AppAnimations.spring,
        );
  }
}