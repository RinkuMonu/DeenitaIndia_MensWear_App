import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color bgColor;

  final Color textColor;
  final bool isPressed;
  final bool isIconShow;
  final double radius;
  final bool isOutlined; // ✅ Added flag

  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.radius = 12,
    this.isIconShow = false,
    this.bgColor = AppColors.primary,
    // this.bgColor = AppColors.secondaryColor,
    this.textColor = Colors.white,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// BUTTON TEXT (UNCHANGED)
              Text(
                title,
                style: TextStyle(
                  color:  textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 10,),

              if(isIconShow)
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,

                )

             ],
          ),
        ),
      ),
    );
  }
}