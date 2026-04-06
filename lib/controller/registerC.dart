import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../constants/colors.dart';
import '../view/bottomBar.dart';
import '../widgets/button.dart';
import '../widgets/otpPopup.dart';

class RegisterC extends GetxController {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();
  final otpController = TextEditingController();

  /// Form validation
  RxBool isFormValid = false.obs;

  /// Email verification states
  RxBool isEmailVerifying = false.obs;
  RxBool isEmailVerified = false.obs;

  /// Mobile verification states
  RxBool isMobileVerifying = false.obs;
  RxBool isMobileVerified = false.obs;

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(validateForm);
    passController.addListener(validateForm);
    passConfirmController.addListener(validateForm);

    /// Reset email verification if user edits
    emailController.addListener(() {
      isEmailVerified.value = false;
      validateForm();
    });

    /// Reset mobile verification if user edits
    mobileController.addListener(() {
      isMobileVerified.value = false;
      validateForm();
    });

    /// Revalidate when verification state changes
    ever(isEmailVerified, (_) => validateForm());
    ever(isMobileVerified, (_) => validateForm());
  }

  void validateForm() {
    isFormValid.value =
        nameController.text.trim().isNotEmpty &&
            emailController.text.trim().isNotEmpty &&
            mobileController.text.trim().isNotEmpty &&
            passController.text.trim().isNotEmpty &&
            passConfirmController.text.trim().isNotEmpty &&
            isEmailVerified.value &&
            isMobileVerified.value;
  }

  /// 🔥 Simulated Email Verification
  Future<void> verifyEmail() async {
    if (emailController.text.isEmpty) return;

    isEmailVerifying.value = true;

    await Future.delayed(const Duration(seconds: 2)); // simulate API

    isEmailVerifying.value = false;
    isEmailVerified.value = true;

    validateForm();
  }

  /// 🔥 Simulated Mobile Verification
  Future<void> verifyMobile() async {
    if (mobileController.text.isEmpty) return;

    isMobileVerifying.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isMobileVerifying.value = false;

    /// DO NOT mark verified yet
    showMobileOtpPopup(onNext: () {
      isMobileVerified.value = true;
      validateForm();
    }, controller: otpController);
  }








}