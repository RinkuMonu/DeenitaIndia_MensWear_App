import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/api.dart';
import '../service/local_storage.dart';
import '../utils/api_url.dart';
import '../view/bottomBar.dart';
import '../view/hello_card.dart';
import '../view/home.dart';
import '../view/login.dart';
import '../widgets/toast.dart';

class LoginC extends GetxController{
  final emailC = TextEditingController();
  final mobileC = TextEditingController();
  final nameC = TextEditingController();
  final passC = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> loginWithPassword() async {
    var email = emailC.text.trim();
    var pass = passC.text.trim();
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
      print('Sending Data : $data');
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        final data = response.data;
        print('Saved Token : ${data['accessToken']}');
        //save token
        LocalStorage.set('token', data['accessToken']);
        //save userId
        // LocalStorage.set('userId', model.user?.id);
        // //save name
        // LocalStorage.set('name', model.user?.name);
        // //save email
        // LocalStorage.set('email', model.user?.email);

        if(data['accessToken'] != null ){
          print(data['accessToken']);
          Get.offAll(() => HelloCard());
        }
      } else {
        isLoading.value = false;

        showSnackBar(title: "Failed", message: response.data["msg"] ?? "Something went wrong", context: Get.context!, error: 'error');
      }
    } catch (e) {
      isLoading.value = false;

      showSnackBar(title: "Failed", message: 'Something went wrong', context: Get.context!, error: 'error');
    }

  }

  RxBool isPasswordHidden = true.obs;

  void validate(){
    final email = emailC.text.trim();
    final password = passC.text.trim();

    if(emailC.text.isEmpty || passC.text.isEmpty ){
      print('object');
      showSnackBar(title: '', message: 'All Field is required', context: Get.context!, error: 'error');
      return;
    }
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(email)) {
      showSnackBar(
        title: '',
        message: 'Enter a valid email address',
        context: Get.context!,
        error: 'error',
      );
      return;
    }

    final passRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    );

    if (!passRegex.hasMatch(password)) {
      showSnackBar(
        title: '',
        message: 'Password must be at least 8 chars, include upper, lower, number & special char',
        context: Get.context!,
        error: 'error',
      );
      return;
    }
    loginWithPassword();
  }
}