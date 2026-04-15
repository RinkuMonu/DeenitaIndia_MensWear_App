import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ScratchCard {
  final String expiredOn;
  final bool isScratched;

  ScratchCard({required this.expiredOn, this.isScratched = false});
}

class Coupon {
  final String discount;
  final String condition;
  final String code;
  final String validTill;

  Coupon({
    required this.discount,
    required this.condition,
    required this.code,
    required this.validTill,
  });
}

// ─────────────────────────────────────────
// CONTROLLER
// ─────────────────────────────────────────

class RewardController extends GetxController {
  final RxInt totalCoins = 1000.obs;

  final RxList<ScratchCard> scratchCards = <ScratchCard>[
    ScratchCard(expiredOn: '26/02/26'),
    ScratchCard(expiredOn: '26/02/26'),
    ScratchCard(expiredOn: '26/02/26'),
  ].obs;

  final RxList<Coupon> coupons = <Coupon>[
    Coupon(
      discount: '50% OFF',
      condition: 'on order above Rs.1299',
      code: 'CLOTH123',
      validTill: '29/02/26',
    ),
    Coupon(
      discount: '50% OFF',
      condition: 'on order above Rs.1299',
      code: 'CLOTH123',
      validTill: '29/02/26',
    ),
  ].obs;

  void onScratchCardTap(int index) {
    // Handle scratch card interaction
    Get.snackbar(
      'Scratch Card',
      'Scratching card ${index + 1}...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
    );
  }

  void onCopyCoupon(String code) {
    // Copy coupon code to clipboard logic here
    Get.snackbar(
      'Coupon Copied!',
      'Code "$code" copied to clipboard.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }
}