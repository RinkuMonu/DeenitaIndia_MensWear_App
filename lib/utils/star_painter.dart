import 'dart:math' as math;
import 'package:flutter/material.dart';

/// ================= CONFETTI =================
class ConfettiParticle {
  final Color color;
  final double x;
  final double y;
  final double size;
  final double angle;

  ConfettiParticle({
    required this.color,
    required this.x,
    required this.y,
    required this.size,
    required this.angle,
  });
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double progress;

  ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final paint = Paint()
        ..color = p.color.withOpacity(1 - progress);

      canvas.save();
      canvas.translate(
        size.width * p.x,
        size.height * (p.y + progress),
      );
      canvas.rotate(p.angle + progress * math.pi);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: p.size,
          height: p.size * 1.8,
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) =>
      progress != oldDelegate.progress;
}

/// ================= STARS =================
class StarPainter extends CustomPainter {
  final double progress;

  StarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.6);

    for (int i = 0; i < 6; i++) {
      final x = size.width * (0.2 + i * 0.12);
      final y = size.height * (0.4 +
          math.sin(progress * math.pi * 2 + i) * 0.03);

      canvas.drawCircle(Offset(x, y), 2.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) =>
      progress != oldDelegate.progress;
}

/// ================= SCRATCH OVERLAY =================
class ScratchOverlayPainter extends CustomPainter {
  final double progress;

  ScratchOverlayPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.grey.shade800,
          Colors.grey.shade600,
          Colors.grey.shade800,
        ],
        stops: const [0, 0.5, 1],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, paint);

    // shimmer lines
    final shimmer = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1;

    for (double i = -size.height; i < size.width; i += 18) {
      canvas.drawLine(
        Offset(i + progress * 60, 0),
        Offset(i + size.height + progress * 60, size.height),
        shimmer,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ScratchOverlayPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
