import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/services/file_service.dart';
import '../core/services/app_launcher_service.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_colors.dart';

class HomeController extends GetxController {
  final FileService _fileService = FileService();
  final AppLauncherService _appLauncherService = AppLauncherService();
  
  final TextEditingController uidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  final RxInt currentSliderIndex = 0.obs;
  final RxBool isLoading = false.obs;
  
  
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
      Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.selectGame,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...games.map((game) => ListTile(
              title: Text(
                game == AppStrings.freeFirePackage ? 'Free Fire' : 'Free Fire Max',
                style: const TextStyle(color: AppColors.textPrimary),
              ),
              trailing: const Icon(Icons.chevron_right, color: AppColors.primary),
              onTap: () {
                Get.back();
                _appLauncherService.launchApp(game);
              },
            )),
          ],
        ),
      ),
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
      backgroundColor: isError ? AppColors.error : AppColors.success,
      textColor: AppColors.textPrimary,
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