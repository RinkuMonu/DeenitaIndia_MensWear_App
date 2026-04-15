import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/widgets/button.dart';
import 'package:flutter/material.dart';

class AppPopUp extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final String buttonText;

  const AppPopUp({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// 🔹 IMAGE
              Image.asset(
                image,
                height: 100,
              ),

              SizedBox(height: 16),

              /// 🔹 TITLE
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 8),

              /// 🔹 SUBTITLE
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 20),

              /// 🔹 BUTTON
              SizedBox(
                  width: double.infinity,
                  child: AppButton(title: buttonText, onTap: onTap, bgColor: AppColors.yellow_shade, textColor: Colors.black,)
              ),
            ],
          ),
        ),
      ),
    );
  }
}