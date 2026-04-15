import 'dart:math' as math;
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/controller/scratch_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scratcher/scratcher.dart';
import '../constants/colors.dart';
import '../utils/star_painter.dart';
class ScratchCardDialog extends StatefulWidget {
  final String cardId;
  final String amount;
  final String couponCode;
  final String minOrder;
  final String validTill;

  const ScratchCardDialog({
    super.key,
    required this.cardId,
    required this.amount,
    this.couponCode = 'CLOTH123',
    this.minOrder = 'Rs.1299',
    this.validTill = '29/02/26',
  });

  @override
  State<ScratchCardDialog> createState() => _ScratchCardDialogState();
}

class _ScratchCardDialogState extends State<ScratchCardDialog>
    with TickerProviderStateMixin {
  // Don't use Get.put inside a widget — use find or lazyPut in binding
  final controller = Get.put(ScratchCardController());
  final scratchKey = GlobalKey<ScratcherState>();

  late AnimationController _confettiController;
  late AnimationController _starController;
  late AnimationController _overlayController;

  final List<ConfettiParticle> _confetti = [];

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
        vsync: this, duration: const Duration(seconds: 2));
    _starController =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
    _overlayController =
    AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat();
    _generateConfetti();
  }

  void _generateConfetti() {
    final rnd = math.Random();
    for (int i = 0; i < 60; i++) {
      _confetti.add(ConfettiParticle(
        color: Colors.primaries[rnd.nextInt(Colors.primaries.length)],
        x: rnd.nextDouble(),
        y: -rnd.nextDouble(),
        size: 6 + rnd.nextDouble() * 4,
        angle: rnd.nextDouble() * math.pi,
      ));
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _starController.dispose();
    _overlayController.dispose();
    super.dispose();
  }

  void _onReveal() {
    _confettiController.forward(from: 0);
    scratchKey.currentState?.reveal(duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      // ✅ Fix #3: Use insetPadding + constrain height so Column doesn't overflow
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ✅ Fix #2: Confetti — use AnimatedBuilder directly, no Obx needed
          // since _confettiController is a plain AnimationController
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _confettiController,
              builder: (_, __) => CustomPaint(
                painter: ConfettiPainter(
                  particles: _confetti,
                  progress: _confettiController.value,
                ),
              ),
            ),
          ),

          // 🧾 Main Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🪙 Scratch Card
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Scratcher(
                    key: scratchKey,
                    brushSize: 70,
                    threshold: 25,
                    color: Colors.grey.shade400,
                    onThreshold: _onReveal,
                    // ✅ Fix #1: Make sure this path exists in pubspec.yaml assets
                    image: Image.asset(
                      AppImage.scratchCard,
                      fit: BoxFit.cover,
                    ),
                    child: _rewardCard(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton(
      onPressed: () => Get.back(),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        "Claim Reward",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _rewardCard() {
    return Stack(
      clipBehavior: Clip.none, // allows ribbon to overflow the card edges
      children: [
        Container(
          height: 340,
          width: 240,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: const Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.amount}% OFF',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              // Subtext
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
                  children: [
                    const TextSpan(text: 'on order above ', style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),),
                    TextSpan(
                      text: widget.minOrder,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Coupon code box
              Text(
                'Use Code : ${widget.couponCode}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 50),

              // Validity
              Text(
                'Valid till ${widget.validTill}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],

          ),
        ),

        // 🎀 Ribbon at top-left
        Positioned(
          top: 10,
          left: 5,
          child :Image.asset(
            AppImage.horizontalRibbon,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}


