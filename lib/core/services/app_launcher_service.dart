import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_strings.dart';

class AppLauncherService {
  Future<List<String>> getInstalledGames() async {
    List<String> installedGames = [];
    
    // Check for Free Fire by trying to launch
    try {
      final intent = AndroidIntent(
        action: 'android.intent.action.VIEW',
        package: AppStrings.freeFirePackage,
      );
      final canResolve = await intent.canResolveActivity();
      if (canResolve == true) {
        installedGames.add(AppStrings.freeFirePackage);
      }
    } catch (e) {
      debugPrint('Free Fire not installed');
    }
    
    // Check for Free Fire Max
    try {
      final intent = AndroidIntent(
        action: 'android.intent.action.VIEW',
        package: AppStrings.freeFireMaxPackage,
      );
      final canResolve = await intent.canResolveActivity();
      if (canResolve == true) {
        installedGames.add(AppStrings.freeFireMaxPackage);
      }
    } catch (e) {
      debugPrint('Free Fire Max not installed');
    }
    
    return installedGames;
  }
  
  Future<void> launchApp(String packageName) async {
    try {
      final intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: packageName,
        category: 'android.intent.category.LAUNCHER',
      );
      await intent.launch();
    } catch (e) {
      debugPrint('Error launching app: $e');
    }
  }
  
  Future<void> openUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error opening URL: $e');
    }
  }
}