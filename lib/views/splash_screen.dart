import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/app_typography.dart';
import '../core/theme/design_tokens.dart';
import '../core/theme/app_animations.dart';
import '../core/widgets/mesh_background.dart';
import '../core/constants/app_strings.dart';
import '../core/services/file_service.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FileService _fileService = FileService();
  
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }
  
  Future<void> _initializeApp() async {
    // Wait for splash animation
    await Future.delayed(const Duration(seconds: 2));
    
    // Request storage permissions
    final hasPermission = await _fileService.checkPermission();
    
    if (!hasPermission) {
      // Request permission
      final granted = await _fileService.requestPermissions();
      
      if (granted) {
        _showToast(AppStrings.permissionGranted, isError: false);
      } else {
        _showToast(AppStrings.permissionDenied, isError: true);
      }
    }
    
    // Navigate to home screen
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      Get.off(() => const HomeScreen(), transition: Transition.fadeIn);
    }
  }
  
  void _showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? AppTheme.error : AppTheme.success,
      textColor: AppTheme.textMain,
      fontSize: 14.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MeshBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo with glow
              Container(
                decoration: BoxDecoration(
                  boxShadow: AppTheme.fireGlow(intensity: 0.6),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/logo/app_logo.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              )
                  .animate()
                  .scale(
                    duration: AppAnimations.verySlow,
                    curve: AppAnimations.elastic,
                  )
                  .fadeIn(duration: AppAnimations.slow),
              
              const SizedBox(height: DesignTokens.space32),
              
              // App Name
              ShaderMask(
                shaderCallback: (bounds) => AppTheme.fireGradient.createShader(bounds),
                child: Text(
                  AppStrings.appName,
                  style: AppTypography.h1,
                ),
              )
                  .animate()
                  .fadeIn(
                    delay: AppAnimations.normal,
                    duration: AppAnimations.slow,
                  )
                  .slideY(
                    begin: AppAnimations.slideUpStart.dy,
                    end: AppAnimations.slideUpEnd.dy,
                    duration: AppAnimations.slow,
                    curve: AppAnimations.smoothEase,
                  ),
              
              const SizedBox(height: DesignTokens.space12),
              
              // Tagline
              Text(
                'Guest Account Manager',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppTheme.textMuted,
                  fontWeight: FontWeight.w300,
                ),
              )
                  .animate()
                  .fadeIn(
                    delay: AppAnimations.slow,
                    duration: AppAnimations.slow,
                  )
                  .slideY(
                    begin: AppAnimations.slideUpStart.dy,
                    end: AppAnimations.slideUpEnd.dy,
                    duration: AppAnimations.slow,
                    curve: AppAnimations.smoothEase,
                  ),
              
              const SizedBox(height: DesignTokens.space64),
              
              // Loading Spinner with dual borders
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    // Outer ring
                    CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.primary.withOpacity(0.3),
                      ),
                    ),
                    // Inner ring
                    Center(
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppTheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .fadeIn(
                    delay: AppAnimations.verySlow,
                    duration: AppAnimations.slow,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}