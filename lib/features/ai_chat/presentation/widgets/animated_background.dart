import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackground extends StatelessWidget {
  final AnimationController controller;

  const AnimatedBackground({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // الخلفية الأساسية مع التدرج
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF667eea),
                Color(0xFF764ba2),
                Color(0xFF6B73FF),
                Color(0xFF000DFF),
              ],
              stops: [0.0, 0.3, 0.7, 1.0],
            ),
          ),
        ),
        
        // طبقة التأثيرات المتحركة
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return CustomPaint(
              painter: BackgroundPainter(
                animation: controller.value,
              ),
              size: Size.infinite,
            );
          },
        ),
        
        // طبقة الجسيمات المتحركة
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return CustomPaint(
              painter: ParticlesPainter(
                animation: controller.value,
              ),
              size: Size.infinite,
            );
          },
        ),
        
        // طبقة شفافة للتأثير النهائي
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.1),
                Colors.transparent,
                Colors.black.withOpacity(0.2),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animation;

  BackgroundPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // رسم الموجات المتحركة
    _drawWaves(canvas, size, paint);
    
    // رسم الدوائر المتحركة
    _drawCircles(canvas, size, paint);
  }

  void _drawWaves(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final waveHeight = size.height * 0.1;
    final waveLength = size.width / 2;
    
    for (int i = 0; i < 3; i++) {
      path.reset();
      
      final yOffset = size.height * (0.2 + i * 0.3) + 
                     math.sin(animation * 2 * math.pi + i) * 20;
      
      path.moveTo(0, yOffset);
      
      for (double x = 0; x <= size.width; x += 10) {
        final y = yOffset + 
                 math.sin((x / waveLength + animation + i * 0.5) * 2 * math.pi) * 
                 waveHeight;
        path.lineTo(x, y);
      }
      
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      
      paint.color = [
        Colors.purple.withOpacity(0.1),
        Colors.blue.withOpacity(0.1),
        Colors.cyan.withOpacity(0.1),
      ][i];
      
      canvas.drawPath(path, paint);
    }
  }

  void _drawCircles(Canvas canvas, Size size, Paint paint) {
    final circles = [
      {'x': 0.2, 'y': 0.3, 'radius': 0.15, 'color': Colors.purple.withOpacity(0.1)},
      {'x': 0.8, 'y': 0.2, 'radius': 0.12, 'color': Colors.blue.withOpacity(0.1)},
      {'x': 0.1, 'y': 0.7, 'radius': 0.1, 'color': Colors.cyan.withOpacity(0.1)},
      {'x': 0.9, 'y': 0.8, 'radius': 0.08, 'color': Colors.indigo.withOpacity(0.1)},
    ];

    for (int i = 0; i < circles.length; i++) {
      final circle = circles[i];
      final animatedRadius = (circle['radius'] as double) * size.width * 
                           (1 + math.sin(animation * 2 * math.pi + i) * 0.3);
      
      final animatedX = (circle['x'] as double) * size.width + 
                       math.cos(animation * 2 * math.pi + i * 0.7) * 30;
      
      final animatedY = (circle['y'] as double) * size.height + 
                       math.sin(animation * 2 * math.pi + i * 0.5) * 20;

      paint.color = circle['color'] as Color;
      canvas.drawCircle(
        Offset(animatedX, animatedY),
        animatedRadius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ParticlesPainter extends CustomPainter {
  final double animation;

  ParticlesPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // رسم الجسيمات المتحركة
    for (int i = 0; i < 50; i++) {
      final x = (i * 37.0 % size.width) + 
               math.sin(animation * 2 * math.pi + i * 0.1) * 50;
      final y = (i * 23.0 % size.height) + 
               math.cos(animation * 2 * math.pi + i * 0.15) * 30;
      
      final opacity = (math.sin(animation * 2 * math.pi + i * 0.2) + 1) * 0.5;
      final radius = 1 + math.sin(animation * 4 * math.pi + i * 0.3) * 2;
      
      paint.color = Colors.white.withOpacity(opacity * 0.3);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
    
    // رسم خطوط متحركة
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    
    for (int i = 0; i < 10; i++) {
      final startX = (i * 100.0 % size.width);
      final startY = math.sin(animation * 2 * math.pi + i * 0.5) * size.height * 0.5 + 
                    size.height * 0.5;
      
      final endX = startX + 100;
      final endY = startY + math.cos(animation * 2 * math.pi + i * 0.3) * 50;
      
      final opacity = (math.sin(animation * 2 * math.pi + i * 0.4) + 1) * 0.5;
      paint.color = Colors.white.withOpacity(opacity * 0.1);
      
      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}