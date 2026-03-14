import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../constants/image.dart';
import '../view/auth/login.dart';


class OnBoardingModel {
  final String image;
  final String subtitle;
  final String title;

  OnBoardingModel({
    required this.image,
    required this.subtitle,
    required this.title,

  });
}

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();

  RxInt currentIndex = 0.obs;

  final pages = [
    OnBoardingModel(
      image: "assets/image/ob1.png",
      title: "Redefine Your\nEveryday Style",
      subtitle:
      "Premium menswear designed for comfort, confidence, and class.",
    ),
    OnBoardingModel(
      image: "assets/image/ob2.png",
      title: "Define boldness in your own way.",
      subtitle: "Premium menswear with attention to every detail.Designed for the modern gentleman.",
    ),OnBoardingModel(
      image: "assets/image/ob3.png",
      title: "Find Your Fit Faster",
      subtitle: "Clothing that defines strength, style, and confidence.Wear your attitude.",
    ),
    OnBoardingModel(
      image: "assets/image/ob4.png",
      title: "Royal Looks for Special Days",
      subtitle: "Traditional wear designed for unforgettable occasions.Where culture meets timeless style.",
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
    }
  }
}