import 'package:deenitaindia/view/auth/otpVerify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/api.dart';
import '../service/local_storage.dart';
import '../utils/api_url.dart';
import '../view/hello_card.dart';
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

  /// 🔥 Toggle between Mobile & Email
  RxBool isMobileSelected = true.obs;
  RxBool isMobilePasswordSelected = false.obs;

  void selectMobile() {
    isMobileSelected.value = true;
  }

  void selectMobilePassword() {
    isMobilePasswordSelected.toggle();
  }

  void selectEmail() {
    isMobileSelected.value = false;
    isMobilePasswordSelected.value = false;
  }

  /// ─────────────────────────────────────
  /// EMAIL + PASSWORD LOGIN
  /// ─────────────────────────────────────
  Future<void> loginWithPassword() async {
    final email = emailC.text.trim();
    final pass = passC.text.trim();

    if (email.isEmpty || pass.isEmpty) {
      showSnackBar(
        title: '',
        message: 'Email & Password required',
        context: Get.context!,
        error: 'error',
      );
      return;
    }

    try {
      isLoading.value = true;

      final data = {
        "email": email,
        "password": pass,
        "referenceWebsite": '6968869bd31f93ad3cd05004'
      };

      final response = await Apiservices().postRequest(
        ApiUrl.login,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final resData = response.data;

        LocalStorage.set('token', resData['accessToken']);

        Get.offAll(() => HelloCard());
      } else {
        showSnackBar(
          title: "Failed",
          message: response.data["msg"] ?? "Something went wrong",
          context: Get.context!,
          error: 'error',
        );
      }
    } catch (e) {
      showSnackBar(
        title: "Failed",
        message: "Something went wrong",
        context: Get.context!,
        error: 'error',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ─────────────────────────────────────
  /// MOBILE VALIDATION
  /// ─────────────────────────────────────
  void validateMobile() {
    final mobile = mobileC.text.trim();

    if (mobile.isEmpty) {
      showSnackBar(
        title: '',
        message: 'Mobile number is required',
        context: Get.context!,
        error: 'error',
      );

      return;
    }

    final mobileRegex = RegExp(r'^[6-9]\d{9}$');

    if (!mobileRegex.hasMatch(mobile)) {
      showSnackBar(
        title: '',
        message: 'Enter valid mobile number',
        context: Get.context!,
        error: 'error',
      );
      return;
    }

    /// Navigate to OTP screen
    Get.to(()=> OtpVerifyView());
  }

  @override
  void onClose() {
    emailC.clear();
    mobileC.clear();
    passC.clear();
    otpC.clear();
    emailC.dispose();
    mobileC.dispose();
    passC.dispose();
    otpC.dispose();

    super.onClose();
  }
}