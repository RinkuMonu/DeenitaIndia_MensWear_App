import 'dart:async';
import 'dart:developer';

import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/models/subCategory_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ApiRepo/GetApis.dart';
import '../models/brand_list_model.dart';
import '../service/apiService.dart';
import '../utils/api_url.dart';
import '../utils/logger.dart';
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

  RxInt currentPageBrands = 1.obs;
  RxInt totalPagesBrands = 1.obs;
  final int limitBrands = 10;

  RxInt currentPageCategory = 1.obs;
  RxInt totalPagesCategory = 1.obs;
  final int limitCategory = 10;
  RxInt selectedIndex = 0.obs;
  RxInt selectedMainCategory = 0.obs;
  RxInt selectedFav = 0.obs;

  final selectedKidsTab = 0.obs;
  late ScrollController bannerScrollController;
  RxDouble bannerPage = 0.0.obs;
  var name = ''.obs;
  RxList<SubCategory> category = <SubCategory>[].obs; //
  RxList<BrandsCategory> ocassionfit = <BrandsCategory>[].obs; //
  RxList<String> topBanner = <String>[].obs; //
   RxList<Brand> brandsLists = <Brand>[].obs; //


  RxMap<int, int> bannerRemainingSeconds = <int, int>{}.obs;
  RxMap<int, String> bannerTimers = <int, String>{}.obs;

  Timer? _timer;
  // In your controller (HomeC):
  RxInt currentBannerIndex = 0.obs;
  RxList<String> bannerImages = <String>[
    AppImage.homeLargeImage,
    AppImage.bannerModel,
    AppImage.homeLargeImage,
    AppImage.bannerModel,
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
      AppImage.homeBanner2,
      AppImage.homeBanner,
      AppImage.homeBanner2,
    ]);



    ocassionfit.addAll([
      BrandsCategory(image: AppImage.ocssionFit1, offer: "Weeding Wear"),
      BrandsCategory(image: AppImage.ocssionFit2, offer: "Workwear"),
      BrandsCategory(image: AppImage.ocssionFit2, offer: "Workwear"),
      BrandsCategory(image: AppImage.ocssionFit3, offer: "Weeding Wear"),
    ]);

    fetchBrand();
    fetchCategory();


  }



  Future<void> fetchBrand({bool loadMore = false}) async {
    try {
      if (loadMore) {
        // Stop if already reached the last page
        if (currentPageBrands.value >= totalPagesBrands.value) return;
        currentPageBrands.value++;
      } else {
        // Reset for first load
        currentPageBrands.value = 1;

      }

      isLoading.value = true;

      final response = await GetApiRepo().fetchBrands(
        page: currentPageBrands.value,
        limit: limitBrands,
      );

      if (response != null) {
        // Append or replace data
        if (loadMore) {
          brandsLists .addAll(response.brands ?? []);
        } else {
          brandsLists .value = response.brands ?? [];
        }

        totalPagesBrands.value = response.total ?? 1;


      } else {
        showSnackBar(title: "Error", message: "Failed to fetch loan reports");
      }
    } catch (e) {
      logError("❌ Unexpected Error: $e");
      showSnackBar(title: "Error", message: "Unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategory({bool loadMore = false}) async {
    try {
      if (loadMore) {
        // Stop if already reached the last page
        if (currentPageCategory.value >= totalPagesCategory.value) return;
        currentPageCategory.value++;
      } else {
        // Reset for first load
        currentPageCategory.value = 1;

      }

      isLoading.value = true;

      final response = await GetApiRepo().fetchSubCategory(
        page: currentPageCategory.value,
        limit: limitCategory,
      );

      if (response != null) {
        // Append or replace data
        if (loadMore) {
          category .addAll(response.categories ?? []);
        } else {
          category .value = response.categories ?? [];
        }

        totalPagesCategory.value = response.total ?? 1;


      } else {
        showSnackBar(title: "Error", message: "Failed to fetch loan reports");
      }
    } catch (e) {
      logError("❌ Unexpected Error: $e");
      showSnackBar(title: "Error", message: "Unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
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