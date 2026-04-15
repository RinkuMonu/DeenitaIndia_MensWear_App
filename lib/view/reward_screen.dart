import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/reward_controller.dart';
import '../widgets/customAppBar.dart';
import '../widgets/scratch_card_dialog.dart';

class RewardScreen extends StatefulWidget {
  RewardScreen({Key? key}) : super(key: key);

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  final RewardController controller = Get.put(RewardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "MyRewards",
        showWishlist: false,
        showNotification: true,
        showMenu: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCoinSection(),
            const SizedBox(height: 24),
            _buildScratchCardSection(),
            const SizedBox(height: 24),
            _buildCouponSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _scratchSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader("Scratch & Claim Your Rewards"),
          const SizedBox(height: 12),
          Obx(() {


            return SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.scratchCards.length,
                itemBuilder: (_, index) {
                  final card = controller.scratchCards[index];
                  return _scratchCard(
                      "1", "10");
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _scratchCard(String id, String amount) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (_) =>
            ScratchCardDialog(cardId: id, amount: amount),
      ),
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: AssetImage("assets/new_images/scratchCard.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // ── AppBar ──────────────────────────────
  Widget _buildCoinSection() {
    return Container(
      width: double.infinity,
      color: AppColors.yellow_shade, // ✅ exact light yellow
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Coin Earn',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5), // light grey card
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Image.asset(AppImage.coin, height: 30, width: 30,),
                const SizedBox(width: 10),
                Obx(() => Text(
                  '${controller.totalCoins.value}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Scratch Card Section ─────────────────
  Widget _buildScratchCardSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Scratch Card',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
                () => Row(
              children: List.generate(controller.scratchCards.length, (index) {
                final card = controller.scratchCards[index];
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index < controller.scratchCards.length - 1 ? 8 : 0,
                    ),
                    child: _buildScratchCard(card, index),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScratchCard(ScratchCard card, int index) {
    return GestureDetector(
      onTap: () => Get.dialog(ScratchCardDialog(cardId: '12', amount: '122',),barrierDismissible: true),
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Gift box icon
                Image.asset(
                  AppImage.scratchCard, // Replace with your asset path
                 fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.card_giftcard,
                    size: 50,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Expired on\n${card.expiredOn}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSparkles() {
    return [
      Positioned(
        top: 8,
        left: 12,
        child: _sparkle(Colors.yellow, 6),
      ),
      Positioned(
        top: 16,
        right: 14,
        child: _sparkle(Colors.white, 5),
      ),
      Positioned(
        bottom: 20,
        left: 16,
        child: _sparkle(Colors.white, 4),
      ),
      Positioned(
        bottom: 14,
        right: 10,
        child: _sparkle(Colors.yellow, 5),
      ),
    ];
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _sparkle(Color color, double size) {
    return Icon(Icons.star, color: color, size: size);
  }

  // ── Coupon Section ───────────────────────
  Widget _buildCouponSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Coupons',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
                () => Column(
              children: controller.coupons
                  .map((coupon) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildCouponCard(coupon),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard(Coupon coupon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [

          /// 🎀 LEFT RIBBON
          Container(
            width: 70,
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Image.asset(
              AppImage.verticalRibbon, // 👈 use ribbon image
              fit: BoxFit.cover,
            ),
          ),

          /// CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Text(
                        coupon.discount,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          coupon.condition,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Use Code : ${coupon.code}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Valid till ${coupon.validTill}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}