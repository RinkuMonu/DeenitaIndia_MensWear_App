import 'package:deenitaindia/view/auth/otpVerify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/apiService.dart';
import '../service/local_storage.dart';
import '../utils/api_url.dart';
import '../widgets/toast.dart';

class LoginC extends GetxController {

  /// Controllers
  final emailC = TextEditingController();
  final mobileC = TextEditingController();
  final passC = TextEditingController();
  final otpC = TextEditingController();

  /// States
  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;

  RxBool isMobileSelected = true.obs;
  RxBool isMobilePasswordSelected = false.obs;

  void selectMobile() => isMobileSelected.value = true;

  void selectMobilePassword() => isMobilePasswordSelected.toggle();

  void selectEmail() {
    isMobileSelected.value = false;
    isMobilePasswordSelected.value = false;
  }

  /// ─────────────────────────────────────
  /// SEND OTP (FIXED)
  /// ─────────────────────────────────────
  Future<void> sendOtp() async {
    final mobile = mobileC.text.trim();

    // ✅ validation first
    if (mobile.isEmpty) {
      showSnackBar(title: '', message: 'Mobile number is required');
      return;
    }

    final mobileRegex = RegExp(r'^[6-9]\d{9}$');
    if (!mobileRegex.hasMatch(mobile)) {
      showSnackBar(title: '', message: 'Enter valid mobile number');
      return;
    }

    try {
      isLoading.value = true;

      final data = {
        "mobile": mobile,
      };

      final response = await Apiservices().postRequest(
        ApiUrl.sendOtp,
        data: data, // ✅ FIX: pass data
      );

      isLoading.value = false;

      if (response != null && response.data['status'] == true) {

        showSnackBar(
          title: '',
          message: response.data['message'] ?? 'OTP sent successfully',
        );

        /// Navigate
        Get.to(() => OtpVerifyView());

      } else {
        showSnackBar(
          title: '',
          message: response.data['message'] ?? 'Something went wrong',
        );
      }

    } catch (e) {
      isLoading.value = false;

      showSnackBar(
        title: '',
        message: 'Error: ${e.toString()}',
      );
    }
  }

  /// ─────────────────────────────────────
  /// CLEANUP
  /// ─────────────────────────────────────
  @override
  void onClose() {
    emailC.dispose();
    mobileC.dispose();
    passC.dispose();
    otpC.dispose();
    super.onClose();
  }
}