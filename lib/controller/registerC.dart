import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/api.dart';
import '../utils/api_url.dart';
import '../view/login.dart';
import '../widgets/toast.dart';

class RegisterC extends GetxController{
  final emailC = TextEditingController();
  final mobileC = TextEditingController();
  final fNameC = TextEditingController();
  final lNameC = TextEditingController();
  final passC = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;

  Future<void> register() async {
    var email = emailC.text.trim();
    var fname = fNameC.text.trim();
    var lname = lNameC.text.trim();
    var pass = passC.text.trim();
    var mobile = mobileC.text.trim();
    try {
      isLoading.value = true;


      final data = {
        "firstName": fname,
        "lastName": lname,
        "email": email,
        "password": pass,
        "referenceWebsite": "6968869bd31f93ad3cd05004",
        "mobile": mobile,
        "address": "",
        "role": "user"
      };
      final response = await Apiservices().postRequest(
        ApiUrl.signup,
        data: data,
      );
      print('Sending Data : $data');
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        final data = response.data;
        //print('Saved Token : ${data['accessToken']}');
        //save token
        //LocalStorage.set('token', data['accessToken']);
        //save userId
        // LocalStorage.set('userId', model.user?.id);
        // //save name
        // LocalStorage.set('name', model.user?.name);
        // //save email
        // LocalStorage.set('email', model.user?.email);
        Get.offAll(() => Login());

      } else {
        isLoading.value = false;

        showSnackBar(title: "Failed", message: response.data["msg"], context: Get.context!, error: 'error');
      }
    } catch (e) {
      isLoading.value = false;

      showSnackBar(title: "Failed", message: 'Something went wrong', context: Get.context!, error: 'error');
    }

  }
  void validate(){
    final email = emailC.text.trim();
    final password = passC.text.trim();

    if(emailC.text.isEmpty || mobileC.text.isEmpty || fNameC.text.isEmpty || lNameC.text.isEmpty || passC.text.isEmpty ){
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
    register();
  }
}