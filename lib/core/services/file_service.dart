import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants/app_strings.dart';

class FileService {
  Future<bool> requestPermissions() async {
    if (await Permission.storage.isGranted) {
      return true;
    }
    
    if (await Permission.manageExternalStorage.isGranted) {
      return true;
    }
    
    // Request storage permission
    var status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    }
    
    // For Android 11+, request manage external storage
    status = await Permission.manageExternalStorage.request();
    return status.isGranted;
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
      debugPrint('Error injecting credentials: $e');
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
      debugPrint('Error clearing data: $e');
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
      debugPrint('Error reading credentials: $e');
      return null;
    }
  }
}