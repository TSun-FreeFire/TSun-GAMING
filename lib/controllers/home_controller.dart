import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/services/file_service.dart';
import '../core/services/app_launcher_service.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/app_typography.dart';
import '../core/theme/design_tokens.dart';
import '../core/widgets/glassmorphic_card.dart';
import '../core/constants/app_strings.dart';

class HomeController extends GetxController {
  final FileService _fileService = FileService();
  final AppLauncherService _appLauncherService = AppLauncherService();
  
  final TextEditingController uidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  final RxInt currentSliderIndex = 0.obs;
  final RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Removed auto-load of credentials - fields will be empty on app open
  }
  
  Future<void> injectCredentials() async {
    if (uidController.text.isEmpty || passwordController.text.isEmpty) {
      _showToast(AppStrings.fillFields, isError: true);
      return;
    }
    
    isLoading.value = true;
    final success = await _fileService.injectCredentials(
      uidController.text,
      passwordController.text,
    );
    isLoading.value = false;
    
    if (success) {
      _showToast(AppStrings.injectionSuccess);
    } else {
      _showToast(AppStrings.injectionError, isError: true);
    }
  }
  
  Future<void> launchGame() async {
    final installedGames = await _appLauncherService.getInstalledGames();
    
    if (installedGames.isEmpty) {
      _showToast(AppStrings.noGameInstalled, isError: true);
      return;
    }
    
    if (installedGames.length == 1) {
      await _appLauncherService.launchApp(installedGames[0]);
    } else {
      _showGameChooser(installedGames);
    }
  }
  
  void _showGameChooser(List<String> games) {
    Get.bottomSheet(
      GlassmorphicCard(
        margin: EdgeInsets.zero,
        borderRadius: DesignTokens.radiusXLarge,
        padding: const EdgeInsets.all(DesignTokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => AppTheme.fireGradient.createShader(bounds),
              child: Text(
                AppStrings.selectGame,
                style: AppTypography.h3,
              ),
            ),
            const SizedBox(height: DesignTokens.space20),
            ...games.map((game) => GlassmorphicCard(
              margin: const EdgeInsets.only(bottom: DesignTokens.space8),
              padding: EdgeInsets.zero,
              onTap: () {
                Get.back();
                _appLauncherService.launchApp(game);
              },
              child: ListTile(
                title: Text(
                  game == AppStrings.freeFirePackage ? 'Free Fire' : 'Free Fire Max',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: AppTheme.primary,
                  size: DesignTokens.iconLarge,
                ),
              ),
            )),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
  
  Future<void> clearData() async {
    final success = await _fileService.clearData();
    if (success) {
      uidController.clear();
      passwordController.clear();
      _showToast(AppStrings.dataCleared);
    }
  }
  
  Future<void> openTutorial() async {
    await _appLauncherService.openUrl(AppStrings.tutorialUrl);
  }
  
  Future<void> openSocialLink(String url) async {
    await _appLauncherService.openUrl(url);
  }
  
  void _showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? AppTheme.error : AppTheme.success,
      textColor: AppTheme.textMain,
      fontSize: 14.0,
    );
  }
  
  @override
  void onClose() {
    uidController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}