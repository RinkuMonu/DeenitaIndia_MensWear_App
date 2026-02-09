import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../constants/image.dart';
import '../view/login.dart';


class OnBoardingModel {
  final String image;
 // final String subtitle;

  OnBoardingModel({
    required this.image,
  //  required this.subtitle,
  });
}

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();

  RxInt currentIndex = 0.obs;

  final List<OnBoardingModel> pages = [
    OnBoardingModel(
      image: AppImage.onboard1,
      //subtitle: "Instant cash withdrawal, balance enquiry & mini statements",
    ),
    OnBoardingModel(
      image: AppImage.onboard2,
      //subtitle: "Send money securely to any bank account, anytime",
    ),
    OnBoardingModel(
      image: AppImage.onboard3,
      //subtitle: "Accept card payments using your phone as a mini ATM",
    ),
  ];


  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.off(()=> Login());
    }
  }

  void skip() {
    Get.off(()=> Login());
  }
}
