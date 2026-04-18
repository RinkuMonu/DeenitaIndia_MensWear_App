import 'dart:async';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/controller/loginC.dart';
import 'package:deenitaindia/view/bottomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../service/apiService.dart';
import '../service/local_storage.dart';
import '../utils/api_url.dart';
import '../widgets/otpPopup.dart';
import '../widgets/toast.dart';

class OtpVerifyController extends GetxController {
  final otpC = TextEditingController();

  RxBool isLoading = false.obs;

  RxInt secondsRemaining = 30.obs;
  RxBool canResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    canResend.value = false;
    secondsRemaining.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        canResend.value = true;
        _timer?.cancel();
      }
    });
  }

  void resendOtp(String mobile) {
    if (canResend.value) {
      otpC.clear();
      Get.find<LoginC>().sendOtp(mobileNumber: mobile);
      startTimer();
    }
  }

  String get timerText {
    int minutes = secondsRemaining.value ~/ 60;
    int seconds = secondsRemaining.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }



  Future<void> verifyOtp({String? mobileNumber}) async {
    if (otpC.text.trim().isEmpty || otpC.text.trim().length < 6) {
      showSnackBar(title: '', message: 'Please enter valid OTP');
      return;
    }

    try {
      isLoading.value = true;

      final data = {
        "mobile": mobileNumber,
        "otp": otpC.text.trim(),
      };
      print("Data Payload :: $data");

      final response = await Apiservices().postRequest(
        ApiUrl.verifyOtp,
        data: data,
      );

      print("Data response :: $response");

      if (response != null && response.data['success'] == true) {
        final token = response.data['token'];
        final user = response.data['user'];

        // ✅ Save token
        await LocalStorage.set('token', token);

        // ✅ Save user fields
        await LocalStorage.set('userId', user['_id'] ?? '');
        await LocalStorage.set('userName', user['name'] ?? '');
        await LocalStorage.set('userMobile', user['mobile'].toString());
        await LocalStorage.set('userAvatar', user['avatar'] ?? '');
        await LocalStorage.set('userRole', user['role'] ?? '');
        await LocalStorage.set('platformId', user['platformId'] ?? '');
        await LocalStorage.setBool('isVerified', user['isVerified'] ?? false);
        await LocalStorage.setBool('isActive', user['isActive'] ?? true);

        // ✅ Update in-memory token so API calls work immediately
        Apiservices.updateCachedToken(token);

        showSuccessDialog(
          image: AppImage.statusSuccess,
          title: "All Done!",
          subtitle: "Your account has been created successfully.",
          onNext: () {
            Get.offAll(() => BottomBar());
          },
        );





      } else {
        showSuccessDialog(
          image: AppImage.statusfail,
          title: "Oops",
          subtitle: response.data['message'],
          onNext: () {
           Get.back();
          },
        );
      }

    } catch (e) {
      showSuccessDialog(
        image: AppImage.statusfail,
        title: "Oops",
        subtitle: e.toString(),
        onNext: () {
          Get.back();
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpC.dispose();
    super.onClose();
  }
}