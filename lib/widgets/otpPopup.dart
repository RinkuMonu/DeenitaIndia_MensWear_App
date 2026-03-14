import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:pinput/pinput.dart';

import '../constants/colors.dart';
import '../constants/image.dart';
import 'button.dart';

void showMobileOtpPopup({
  required VoidCallback onNext,
  required TextEditingController controller
}) {

  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300),
    ),
  );

  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    barrierColor: Colors.black54,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "OTP Verification",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),


              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "OTP send on your given mobile number",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Pinput(
                length: 6,
                controller: controller,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: 25),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Resend OTP", style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 13
                  ),),


                  Text("00:30", style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 13
                  ),),

                ],
              ),


              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: AppButton(
                  title: "Verify OTP",
                  bgColor: AppColors.primary,
                  onTap: () {

                    if (controller.text.length != 6) {
                      Get.snackbar(
                        "Error",
                        "Please enter valid 6 digit OTP",
                        backgroundColor: Colors.red.shade100,
                      );
                      return;
                    }
                    Get.back(); // close popup

                    /// OTP success simulation
                    controller.clear();


                    onNext();  // mark mobile verified
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}




void showSuccessDialog({
  required String image,
  String? title,
  String? subtitle,
  required VoidCallback onNext,
}) {
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    barrierColor: Colors.black54,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// Image
              Image.asset(image, height: 60),

              const SizedBox(height: 20),

              /// Title
              if (title != null && title.isNotEmpty)
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              if (title != null && title.isNotEmpty)
                const SizedBox(height: 10),

              /// Subtitle
              if (subtitle != null && subtitle.isNotEmpty)
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),

              const SizedBox(height: 25),

              /// Next Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: AppButton(
                  title: "Next",
                  textColor: Colors.black,
                  bgColor: AppColors.yellow_shade,
                  onTap: () {
                    Get.back();      // Close dialog
                    onNext();        // Execute callback
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
