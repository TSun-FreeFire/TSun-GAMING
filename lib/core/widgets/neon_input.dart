import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../theme/design_tokens.dart';

/// Neon Input - Input field with focus glow effect
/// Features: Monospace font, border glow on focus, glassmorphic background
class NeonInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String? hintText;
  
  const NeonInput({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.inputFormatters,
    this.maxLength,
    this.hintText,
  });
  
  @override
  State<NeonInput> createState() => _NeonInputState();
}

class _NeonInputState extends State<NeonInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }
  
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppTheme.bgSurface,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
        border: Border.all(
          color: _isFocused ? AppTheme.primary : AppTheme.borderLight,
          width: _isFocused ? DesignTokens.borderMedium : DesignTokens.borderThin,
        ),
        boxShadow: _isFocused ? [AppTheme.focusGlow()] : null,
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        inputFormatters: widget.inputFormatters,
        maxLength: widget.maxLength,
        style: AppTypography.mono.copyWith(color: AppTheme.textMain),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: AppTypography.label,
          hintText: widget.hintText,
          hintStyle: AppTypography.mono.copyWith(
            color: AppTheme.textMuted.withOpacity(0.5),
          ),
          prefixIcon: widget.icon != null
              ? Icon(
                  widget.icon,
                  color: _isFocused ? AppTheme.primary : AppTheme.textMuted,
                  size: DesignTokens.iconLarge,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: widget.icon != null ? DesignTokens.space12 : DesignTokens.space20,
            vertical: DesignTokens.space16,
          ),
          counterText: '',
        ),
      ),
    );
  }
}