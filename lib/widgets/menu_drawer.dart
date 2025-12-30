import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo/app_logo.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.appName,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Social Links
            _buildMenuItem(
              icon: Icons.code,
              title: AppStrings.github,
              onTap: () => controller.openSocialLink(AppStrings.githubUrl),
            ),
            _buildMenuItem(
              icon: Icons.photo_camera,
              title: AppStrings.instagram,
              onTap: () => controller.openSocialLink(AppStrings.instagramUrl),
            ),
            _buildMenuItem(
              icon: Icons.video_library,
              title: AppStrings.tiktok,
              onTap: () => controller.openSocialLink(AppStrings.tiktokUrl),
            ),
            _buildMenuItem(
              icon: Icons.send,
              title: AppStrings.telegram,
              onTap: () => controller.openSocialLink(AppStrings.telegramUrl),
            ),
            
            const Divider(color: AppColors.textSecondary, height: 30),
            
            // Actions
            _buildMenuItem(
              icon: Icons.delete_outline,
              title: AppStrings.clearData,
              onTap: () {
                Get.back();
                controller.clearData();
              },
            ),
            _buildMenuItem(
              icon: Icons.system_update_outlined,
              title: 'Update',
              onTap: () => controller.openSocialLink('https://github.com/TSun-FreeFire/TSun-GAMING/releases'),
            ),
            _buildMenuItem(
              icon: Icons.info_outline,
              title: AppStrings.about,
              onTap: () {
                Get.back();
                _showAboutDialog(context);
              },
            ),
            
            const Spacer(),
            
            // Version Info
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Version 2.0.5',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: GoogleFonts.roboto(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
  
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'About ${AppStrings.appName}',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TSun Gaming is a guest account manager for Free Fire and Free Fire Max games.',
              style: GoogleFonts.roboto(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Version 2.0.5',
              style: GoogleFonts.roboto(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Features:',
              style: GoogleFonts.poppins(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            _buildFeature('• Inject guest credentials'),
            _buildFeature('• Auto-detect installed games'),
            _buildFeature('• Smart game launcher'),
            _buildFeature('• Tutorial support'),
            const SizedBox(height: 20),
            Center(
              child: Text(
                AppStrings.credits,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'CLOSE',
              style: GoogleFonts.poppins(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
      ),
    );
  }
}