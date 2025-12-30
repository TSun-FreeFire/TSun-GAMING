import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/app_typography.dart';
import '../core/theme/design_tokens.dart';
import '../core/widgets/glassmorphic_card.dart';
import '../core/widgets/glow_icon.dart';
import '../core/constants/app_strings.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: AppTheme.bgCore,
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SafeArea(
              child: Column(
                children: [
                  // Drawer Header with glassmorphic effect
                  GlassmorphicCard(
                    margin: const EdgeInsets.all(DesignTokens.space16),
                    padding: const EdgeInsets.all(DesignTokens.space24),
                    borderRadius: DesignTokens.radiusXLarge,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: AppTheme.fireGlow(intensity: 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/logo/app_logo.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: DesignTokens.space16),
                        ShaderMask(
                          shaderCallback: (bounds) => 
                              AppTheme.fireGradient.createShader(bounds),
                          child: Text(
                            AppStrings.appName,
                            style: AppTypography.h3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Menu Items
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.space16,
                      ),
                      children: [
                        // Social Section
                        _buildSectionHeader('SOCIAL'),
                        const SizedBox(height: DesignTokens.space8),
                        
                        _buildMenuItem(
                          icon: Icons.code_rounded,
                          title: AppStrings.github,
                          glowType: GlowType.fire,
                          onTap: () => controller.openSocialLink(AppStrings.githubUrl),
                        ),
                        _buildMenuItem(
                          icon: Icons.photo_camera_rounded,
                          title: AppStrings.instagram,
                          glowType: GlowType.purple,
                          onTap: () => controller.openSocialLink(AppStrings.instagramUrl),
                        ),
                        _buildMenuItem(
                          icon: Icons.video_library_rounded,
                          title: AppStrings.tiktok,
                          glowType: GlowType.cyan,
                          onTap: () => controller.openSocialLink(AppStrings.tiktokUrl),
                        ),
                        _buildMenuItem(
                          icon: Icons.send_rounded,
                          title: AppStrings.telegram,
                          glowType: GlowType.cyan,
                          onTap: () => controller.openSocialLink(AppStrings.telegramUrl),
                        ),
                        
                        const SizedBox(height: DesignTokens.space16),
                        
                        // Actions Section
                        _buildSectionHeader('ACTIONS'),
                        const SizedBox(height: DesignTokens.space8),
                        
                        _buildMenuItem(
                          icon: Icons.delete_outline_rounded,
                          title: AppStrings.clearData,
                          glowType: GlowType.fire,
                          onTap: () {
                            Get.back();
                            controller.clearData();
                          },
                        ),
                        _buildMenuItem(
                          icon: Icons.system_update_outlined,
                          title: 'Update',
                          glowType: GlowType.purple,
                          onTap: () => controller.openSocialLink(
                            'https://github.com/TSun-FreeFire/TSun-GAMING/releases',
                          ),
                        ),
                        _buildMenuItem(
                          icon: Icons.info_outline_rounded,
                          title: AppStrings.about,
                          glowType: GlowType.cyan,
                          onTap: () {
                            Get.back();
                            _showAboutDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  // Version Info
                  Padding(
                    padding: const EdgeInsets.all(DesignTokens.space20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.space16,
                        vertical: DesignTokens.space8,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.bgSurface.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusSmall,
                        ),
                        border: Border.all(
                          color: AppTheme.borderLight,
                          width: DesignTokens.borderThin,
                        ),
                      ),
                      child: Text(
                        'Version 2.0.5',
                        style: AppTypography.monoSmall.copyWith(
                          color: AppTheme.textMuted,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: DesignTokens.space8,
        bottom: DesignTokens.space4,
      ),
      child: Text(
        title,
        style: AppTypography.label.copyWith(
          color: AppTheme.primary,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
  
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    GlowType glowType = GlowType.none,
  }) {
    return GlassmorphicCard(
      margin: const EdgeInsets.only(bottom: DesignTokens.space8),
      padding: EdgeInsets.zero,
      borderRadius: DesignTokens.radiusMedium,
      onTap: onTap,
      child: ListTile(
        leading: GlowIcon(
          icon: icon,
          size: DesignTokens.iconLarge,
          color: AppTheme.textMain,
          glowType: glowType,
        ),
        title: Text(
          title,
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: AppTheme.textMuted,
          size: DesignTokens.iconLarge,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.space16,
          vertical: DesignTokens.space4,
        ),
      ),
    );
  }
  
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassmorphicCard(
          padding: const EdgeInsets.all(DesignTokens.space24),
          borderRadius: DesignTokens.radiusXLarge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => 
                    AppTheme.fireGradient.createShader(bounds),
                child: Text(
                  'About ${AppStrings.appName}',
                  style: AppTypography.h3,
                ),
              ),
              const SizedBox(height: DesignTokens.space16),
              Text(
                'TSun Gaming is a guest account manager for Free Fire and Free Fire Max games.',
                style: AppTypography.body.copyWith(
                  color: AppTheme.textMuted,
                ),
              ),
              const SizedBox(height: DesignTokens.space12),
              Text(
                'Version 2.0.5',
                style: AppTypography.monoSmall.copyWith(
                  color: AppTheme.textMuted,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: DesignTokens.space24),
              Text(
                'FEATURES',
                style: AppTypography.label.copyWith(
                  color: AppTheme.primary,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: DesignTokens.space12),
              _buildFeature('• Inject guest credentials'),
              _buildFeature('• Auto-detect installed games'),
              _buildFeature('• Smart game launcher'),
              _buildFeature('• Tutorial support'),
              const SizedBox(height: DesignTokens.space24),
              Center(
                child: Text(
                  AppStrings.credits,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.space24),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: AppTheme.primary.withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(
                      vertical: DesignTokens.space12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMedium,
                      ),
                      side: BorderSide(
                        color: AppTheme.primary.withOpacity(0.3),
                        width: DesignTokens.borderThin,
                      ),
                    ),
                  ),
                  child: Text(
                    'CLOSE',
                    style: AppTypography.button.copyWith(
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.space8),
      child: Text(
        text,
        style: AppTypography.body.copyWith(
          color: AppTheme.textMuted,
        ),
      ),
    );
  }
}