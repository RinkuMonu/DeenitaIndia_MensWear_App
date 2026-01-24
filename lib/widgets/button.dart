import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color bgColor;

  final Color textColor;
  final bool isPressed;
  final double radius;
  final bool isOutlined; // ✅ Added flag

  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.radius = 12,
    this.bgColor = AppColors.primary,
    // this.bgColor = AppColors.secondaryColor,
    this.textColor = Colors.grey,
    this.isPressed = false,
    this.isOutlined = false, // ✅ Default false
    SizedBox? child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: isOutlined ? Colors.transparent : bgColor,
            borderRadius: BorderRadius.circular(radius),
            border: isOutlined
                ? Border.all(color: (title.contains('Send OTP') || title.contains('Cancel') || title.contains('Clear All') ) ? Colors.transparent : bgColor, width: 1)
                : null,
            boxShadow: isOutlined
                ? []
                : [
              BoxShadow(
                color: bgColor.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),

          /// 🔥 ONLY THIS PART CHANGED
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// BUTTON TEXT (UNCHANGED)
              Text(
                title,
                style: TextStyle(

                  color: isOutlined ? bgColor : title.contains('Verify Otp ') || title.contains('Verify Pan') || title.contains('Verify Bank') || title.contains('Submit KYC') ? Colors.black : Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),

              /// 🎅 RUNNING SANTA (CHRISTMAS THEME)
              // Positioned(
              //   right: 5,
              //   child: SizedBox(
              //     height: 60,
              //     width: 60,
              //     child: Lottie.asset(
              //       'assets/json/Merry Christmas.json',
              //       repeat: true,
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}