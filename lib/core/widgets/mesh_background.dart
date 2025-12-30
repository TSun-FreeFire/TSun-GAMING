import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Mesh Background - Animated mesh gradient with grid overlay
/// Features: Fixed radial circles (orange + purple), subtle grid, fade mask
class MeshBackground extends StatelessWidget {
  final Widget child;
  final bool showGrid;
  
  const MeshBackground({
    super.key,
    required this.child,
    this.showGrid = true,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.bgCore,
      ),
      child: Stack(
        children: [
          // Mesh gradient circles
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                gradient: AppTheme.meshGradientOrange,
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: const BoxDecoration(
                gradient: AppTheme.meshGradientPurple,
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 50,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                gradient: AppTheme.meshGradientOrange,
              ),
            ),
          ),
          
          // Grid overlay (optional)
          if (showGrid)
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPainter(),
              ),
            ),
          
          // Content
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.borderLight.withOpacity(0.05)
      ..strokeWidth = 0.5;
    
    const gridSize = 40.0;
    
    // Draw vertical lines
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    // Draw horizontal lines
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}