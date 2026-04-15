import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/apiService.dart';
import '../utils/api_url.dart';
import '../view/auth/forgotPassword.dart';
import '../view/home.dart';
import '../view/auth/login.dart';
import '../widgets/toast.dart';

class ForgotPasswordC extends GetxController{
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final newPasswordC = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isPasswordLoading = false.obs;
  var resetToken = ''.obs;
  RxBool isPasswordHidden = true.obs;
  RxBool isPasswordHidden2 = true.obs;
  Future<void> verifyEmail() async {
    var email = emailC.text.trim();

    try {
      isLoading.value = true;


      final data = {
        "email": email,
        "referenceWebsite": "6968869bd31f93ad3cd05004"
      };
      final response = await Apiservices().postRequest(
        "ApiUrl.verifyEmail",
        data: data,
      );
      print('Sending Data : $data');
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        final data = response.data;
        resetToken.value = data["resetToken"];


        Get.to(()=> ForgotPassword());
      } else {
        isLoading.value = false;

        showSnackBar(title: "Failed", message: response.data["msg"], );
      }
    } catch (e) {
      isLoading.value = false;

      showSnackBar(title: "Failed", message: 'Something went wrong', );
    }

  }
  Future<void> resetPassword() async {
    var pass = passwordC.text.trim();
    var newPass = newPasswordC.text.trim();
    var reset = resetToken.value;
    try {
      isPasswordLoading.value = true;


      final data = {
        "resetToken": reset,
        "newPassword": newPass
      };
      final response = await Apiservices().postRequest(
        "ApiUrl.resetPassword",
        data: data,
      );
      print('Sending Data : $data');
      if (response.statusCode == 200 || response.statusCode == 201) {
        isPasswordLoading.value = false;
        final data = response.data;

        Get.offAll(()=> Login());
      } else {
        isPasswordLoading.value = false;

        showSnackBar(title: "Failed", message: response.data["msg"], );
      }
    } catch (e) {
      isPasswordLoading.value = false;

      showSnackBar(title: "Failed", message: 'Something went wrong',);
    }

  }

  void validate(){
    final email = emailC.text.trim();
    if(emailC.text.isEmpty ){
      print('object');
      showSnackBar(title: '', message: 'Email Field is required', );
      return;
    }
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(email)) {
      showSnackBar(
        title: '',
        message: 'Enter a valid email address',

      );
      return;
    }
    verifyEmail();
  }

  void validatePassword(){

    final password = newPasswordC.text.trim();
    if(passwordC.text.isEmpty || newPasswordC.text.isEmpty ){
      print('object');
      showSnackBar(title: '', message: 'All Field is required', );
      return;
    }
    final passRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    );

    if (!passRegex.hasMatch(password)) {
      showSnackBar(
        title: '',
        message: 'Password must be at least 8 chars, include upper, lower, number & special char',

      );
      return;
    }
    resetPassword();
  }
}