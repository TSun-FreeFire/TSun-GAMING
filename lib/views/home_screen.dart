import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/home_controller.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/app_typography.dart';
import '../core/theme/design_tokens.dart';
import '../core/theme/app_animations.dart';
import '../core/widgets/mesh_background.dart';
import '../core/widgets/glassmorphic_card.dart';
import '../core/widgets/cyberpunk_button.dart';
import '../core/widgets/neon_input.dart';
import '../core/constants/app_strings.dart';
import '../widgets/menu_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    
    return Scaffold(
      drawer: const MenuDrawer(),
      body: MeshBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header with centered branding
              _buildHeader(),
              
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.space20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: DesignTokens.space24),
                      
                      // Image Slider
                      _buildImageSlider(controller),
                      
                      const SizedBox(height: DesignTokens.space32),
                      
                      // Input Card
                      GlassmorphicCard(
                        padding: const EdgeInsets.all(DesignTokens.space24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Section Title
                            Text(
                              'ACCOUNT DETAILS',
                              style: AppTypography.label.copyWith(
                                color: AppTheme.primary,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: DesignTokens.space20),
                            
                            // Guest UID Input
                            NeonInput(
                              controller: controller.uidController,
                              label: AppStrings.guestUid,
                              icon: Icons.person_outline,
                              keyboardType: TextInputType.number,
                              hintText: 'Enter your guest UID',
                            ),
                            
                            const SizedBox(height: DesignTokens.space16),
                            
                            // Password Input
                            NeonInput(
                              controller: controller.passwordController,
                              label: AppStrings.password,
                              icon: Icons.lock_outline,
                              obscureText: true,
                              hintText: 'Enter your password',
                            ),
                          ],
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
                            curve: AppAnimations.smoothEase,
                          ),
                      
                      const SizedBox(height: DesignTokens.space32),
                      
                      // Action Buttons
                      Obx(() => CyberpunkButton(
                        label: AppStrings.injectButton,
                        icon: Icons.upload_outlined,
                        gradient: AppTheme.fireGradient,
                        glowShadows: AppTheme.fireGlow(),
                        onPressed: controller.injectCredentials,
                        isLoading: controller.isLoading.value,
                      )),
                      
                      const SizedBox(height: DesignTokens.space16),
                      
                      CyberpunkButton(
                        label: AppStrings.launchGame,
                        icon: Icons.sports_esports_outlined,
                        gradient: AppTheme.cyanGradient,
                        glowShadows: AppTheme.cyanGlow(),
                        onPressed: controller.launchGame,
                      ),
                      
                      const SizedBox(height: DesignTokens.space16),
                      
                      CyberpunkButton(
                        label: AppStrings.watchTutorial,
                        icon: Icons.play_circle_outline,
                        isOutline: true,
                        outlineColor: AppTheme.primary,
                        onPressed: controller.openTutorial,
                      ),
                      
                      const SizedBox(height: DesignTokens.space40),
                      
                      // Credits
                      Text(
                        AppStrings.credits,
                        textAlign: TextAlign.center,
                        style: AppTypography.caption.copyWith(
                          color: AppTheme.textMuted.withOpacity(0.6),
                        ),
                      )
                          .animate()
                          .fadeIn(
                            delay: AppAnimations.verySlow,
                            duration: AppAnimations.slow,
                          ),
                      
                      const SizedBox(height: DesignTokens.space24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return GlassmorphicCard(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.space20,
        vertical: DesignTokens.space16,
      ),
      borderRadius: DesignTokens.radiusLarge,
      child: Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: AppTheme.textMain,
                size: DesignTokens.iconLarge,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          const SizedBox(width: DesignTokens.space12),
          Expanded(
            child: ShaderMask(
              shaderCallback: (bounds) => AppTheme.fireGradient.createShader(bounds),
              child: Text(
                AppStrings.appName,
                style: AppTypography.h3,
              ),
            ),
          ),
          // Version Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.space12,
              vertical: DesignTokens.space4,
            ),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              border: Border.all(
                color: AppTheme.primary.withOpacity(0.3),
                width: DesignTokens.borderThin,
              ),
              borderRadius: BorderRadius.circular(DesignTokens.radiusSmall),
            ),
            child: Text(
              'v2.0.5',
              style: AppTypography.caption.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: AppAnimations.slow)
        .slideY(
          begin: -0.5,
          end: 0,
          curve: AppAnimations.smoothEase,
        );
  }
  
  Widget _buildImageSlider(HomeController controller) {
    final List<String> sliderImages = [
      'assets/images/slider1.jpg',
      'assets/images/slider2.jpg',
      'assets/images/slider3.jpg',
    ];
    
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 10),
        enlargeCenterPage: true,
        viewportFraction: 0.92,
        onPageChanged: (index, reason) {
          controller.currentSliderIndex.value = index;
        },
      ),
      items: sliderImages.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(
                horizontal: DesignTokens.space8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
                border: Border.all(
                  color: AppTheme.borderLight,
                  width: DesignTokens.borderThin,
                ),
                boxShadow: AppTheme.fireGlow(intensity: 0.2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppTheme.bgSurface,
                          child: const Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: DesignTokens.iconHero,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        );
                      },
                    ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppTheme.bgCore.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    )
        .animate()
        .fadeIn(
          delay: AppAnimations.fast,
          duration: AppAnimations.slow,
        )
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          curve: AppAnimations.smoothEase,
        );
  }
}