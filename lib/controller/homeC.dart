import 'dart:async';
import 'dart:developer';

import 'package:deenitaindia/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/api.dart';
import '../utils/api_url.dart';
import '../widgets/toast.dart';

class BrandsCategory {
  final String image;
  final String offer;

  BrandsCategory({required this.image, required this.offer});
}



class HomeC extends GetxController {
  var isLoading = false.obs;
  var isLoadingUpdate = false.obs;
  final searchController = SearchController();

  RxInt selectedIndex = 0.obs;
  RxInt selectedFav = 0.obs;
  late ScrollController bannerScrollController;
  RxDouble bannerPage = 0.0.obs;
  var name = ''.obs;
  RxList<BrandsCategory> brands = <BrandsCategory>[].obs;
  RxList<BrandsCategory> category = <BrandsCategory>[].obs; //
  RxList<BrandsCategory> ocassionfit = <BrandsCategory>[].obs; //
  RxList<String> topBanner = <String>[].obs; //


  RxMap<int, int> bannerRemainingSeconds = <int, int>{}.obs;
  RxMap<int, String> bannerTimers = <int, String>{}.obs;

  Timer? _timer;
  // In your controller (HomeC):
  RxInt currentBannerIndex = 0.obs;
  RxList<String> bannerImages = <String>[
    AppImage.homeLargeImage,
    AppImage.homeLargeImage,
    AppImage.homeLargeImage,
  ].obs;

  RxString countdownTimer = '24 : 15 : 10'.obs;
  @override
  void onInit() {
    super.onInit();
    bannerRemainingSeconds[0] = 24 * 3600;
    bannerRemainingSeconds[1] = 10 * 60;
    bannerRemainingSeconds[2] = 5 * 60;
    _startBannerTimer();

    topBanner.addAll([
      AppImage.homeBanner,
      AppImage.homeBanner,
      AppImage.homeBanner
    ]);

    category.addAll([
      BrandsCategory(image: AppImage.shirt, offer: "Shirt"),
      BrandsCategory(image: AppImage.tshirt, offer: "T-Shirt"),
      BrandsCategory(image: AppImage.shirt, offer: "Shirt"),
      BrandsCategory(image: AppImage.tshirt, offer: "T-Shirt"),
      BrandsCategory(image: AppImage.shirt, offer: "Shirt"),
      BrandsCategory(image: AppImage.tshirt, offer: "T-Shirt"),


    ]);


    ocassionfit.addAll([
      BrandsCategory(image: AppImage.ocssionFit1, offer: "Weeding Wear"),
      BrandsCategory(image: AppImage.ocssionFit2, offer: "Workwear"),
      BrandsCategory(image: AppImage.ocssionFit2, offer: "Workwear"),
      BrandsCategory(image: AppImage.ocssionFit3, offer: "Weeding Wear"),
    ]);

    brands.addAll([
      BrandsCategory(image: AppImage.ironWolf, offer: "50%OFF"),
      BrandsCategory(image: AppImage.urbanClad, offer: "50%OFF"),
      BrandsCategory(image: AppImage.vanture, offer: "50%OFF"),
      BrandsCategory(image: AppImage.vanture, offer: "50%OFF"),
      BrandsCategory(image: AppImage.vanture, offer: "50%OFF"),
      BrandsCategory(image: AppImage.vanture, offer: "50%OFF"),
      BrandsCategory(image: AppImage.vanture, offer: "50%OFF"),
      BrandsCategory(image: AppImage.vanture, offer: "50%OFF"),
    ]);


  }


  void _startBannerTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      bannerRemainingSeconds.forEach((index, seconds) {
        if (seconds > 0) {
          bannerRemainingSeconds[index] = seconds - 1;

          final h = bannerRemainingSeconds[index]! ~/ 3600;
          final m = (bannerRemainingSeconds[index]! % 3600) ~/ 60;
          final s = bannerRemainingSeconds[index]! % 60;

          bannerTimers[index] =
          '${h.toString().padLeft(2, '0')} : '
              '${m.toString().padLeft(2, '0')} : '
              '${s.toString().padLeft(2, '0')}';
        }
      });
    });
  }
  @override
  void onClose() {
    searchController.clear();
    _timer?.cancel();
    searchController.dispose();
    super.onClose();
  }
}