import 'package:deenitaindia/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../constants/image.dart';
import 'button.dart';

void logoutPopup() {
  Get.dialog(
    Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,  // 👈 Important: shrink to content
            children: [

              Image.asset(
                AppImage.statusfail,
                height: 100,
              ),

              SizedBox(height: 16),

              Text(
                "Are you sure you want to logout?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: AppButton(
                  title: "Yes, cancel",
                  onTap: () {
                    Get.back();
                    },
                  bgColor: AppColors.yellow_shade,
                  textColor: Colors.black,
                ),
              ),

              SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  Get.back();
                  },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}