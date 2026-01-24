import 'dart:async';

import 'package:deenitaindia/view/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/local_storage.dart';
import '../view/onboarding.dart';

class SplashC extends GetxController{

  RxString token = ''.obs;
  RxDouble scale = 0.6.obs;
  RxDouble opacity = 0.0.obs;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _checkUserData();
    // start animation
    Future.delayed(const Duration(milliseconds: 300), () {
      scale.value = 1.0;
      opacity.value = 1.0;
    });
  }


  Future<void> _checkUserData() async {
    await Future.delayed(const Duration(seconds: 2));

    token.value = await LocalStorage.get("token") ?? "";
    // role.value = await LocalStorage.get("role") ?? "";
    // userId.value = await LocalStorage.get("userId") ?? "";

    print('Token ::  ${token.value}');
    // print('Role ::  ${role.value}');
    // print('UserId ::  ${userId.value}');

    //If not logged in → go to login
    if (token.value.isEmpty) {
      Get.offAll(() =>  Onboarding());
      return;
    }
    else{
      Get.offAll(() =>  BottomBar());
    }

  }
}