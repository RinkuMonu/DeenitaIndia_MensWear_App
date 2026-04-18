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
  Future<void> sendOtp({String? mobileNumber}) async {
    // ✅ Use passed mobileNumber (resend case) or fall back to text field (login case)
    final mobile = (mobileNumber != null && mobileNumber.isNotEmpty)
        ? mobileNumber
        : mobileC.text.trim();

    // ✅ Single validation block
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

      final data = {"mobile": mobile};
      print("Data Payload :: $data");

      final response = await Apiservices().postRequest(
        ApiUrl.sendOtp,
        data: data,
      );

      print("Data response :: $response");

      if (response != null && response.data['success'] == true) {
        showSnackBar(
          title: '',
          message: response.data['message'] ?? 'OTP sent successfully',
        );

        // ✅ Only navigate if called from login screen (no mobileNumber passed)
        if (mobileNumber == null) {
          Get.to(() => OtpVerifyView(mobileNumber: mobile));
        }

      } else {
        showSnackBar(
          title: '',
          message: response?.data['message'] ?? 'Something went wrong',
        );
      }

    } catch (e) {
      showSnackBar(
        title: '',
        message: 'Error: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
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
    super.onClose();
  }
}