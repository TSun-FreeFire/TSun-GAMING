import 'dart:io';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import '../constants/app_strings.dart';

class FileService {
  /// Check if storage permission is already granted
  Future<bool> checkPermission() async {
    // Check for Android 11+ permission first
    if (await Permission.manageExternalStorage.isGranted) {
      return true;
    }
    
    // Fallback to legacy storage permission for older Android versions
    if (await Permission.storage.isGranted) {
      return true;
    }
    
    return false;
  }
  
  /// Request storage permissions from the user
  Future<bool> requestPermissions() async {
    // Check if already granted
    if (await checkPermission()) {
      return true;
    }
    
    // Try to request manage external storage permission (Android 11+)
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      return true;
    }
    
    // If denied, try legacy storage permission
    status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    }
    
    return false;
  }
  
  Future<bool> injectCredentials(String uid, String password) async {
    try {
      // Request permissions first
      if (!await requestPermissions()) {
        return false;
      }
      
      // Create directory if it doesn't exist
      final directory = Directory(AppStrings.dataFolderPath);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      
      // Create file path
      final filePath = '${AppStrings.dataFolderPath}/${AppStrings.dataFileName}';
      final file = File(filePath);
      
      // Create JSON data
      final data = {
        'guest_account_info': {
          'com.garena.msdk.guest_uid': uid,
          'com.garena.msdk.guest_password': password,
        }
      };
      
      // Write to file
      await file.writeAsString(jsonEncode(data));
      return true;
    } catch (e) {
      print('Error injecting credentials: $e');
      return false;
    }
  }
  
  Future<bool> clearData() async {
    try {
      final filePath = '${AppStrings.dataFolderPath}/${AppStrings.dataFileName}';
      final file = File(filePath);
      
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return true;
    } catch (e) {
      print('Error clearing data: $e');
      return false;
    }
  }
  
  Future<Map<String, String>?> readCredentials() async {
    try {
      final filePath = '${AppStrings.dataFolderPath}/${AppStrings.dataFileName}';
      final file = File(filePath);
      
      if (await file.exists()) {
        final content = await file.readAsString();
        final data = jsonDecode(content);
        final guestInfo = data['guest_account_info'];
        return {
          'uid': guestInfo['com.garena.msdk.guest_uid'],
          'password': guestInfo['com.garena.msdk.guest_password'],
        };
      }
      return null;
    } catch (e) {
      print('Error reading credentials: $e');
      return null;
    }
  }
}