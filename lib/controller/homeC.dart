import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/bannerM.dart';
import '../model/profileM.dart';
import '../service/api.dart';
import '../utils/api_url.dart';
import '../widgets/toast.dart';

class HomeC extends GetxController{
  final mobile = TextEditingController();
  final email = TextEditingController();
  final firstName = TextEditingController();
  final address = TextEditingController();
  final lastName = TextEditingController();
  var isLoading = false.obs;
  var isLoadingUpdate = false.obs;
  final searchController = SearchController();

  RxInt selectedIndex = 0.obs;
  RxInt selectedFav = 0.obs;
  late ScrollController bannerScrollController;
  Rx<BannerModel> model = BannerModel().obs;
  final Rx<ProfileModel> profileModel = ProfileModel().obs;
  RxList<BannersData> topBanners = <BannersData>[].obs;
  RxDouble bannerPage = 0.0.obs;
  var name = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   // getBanner();
    //getProfile();
  }

  Future<BannerModel?> getBanner() async {

    try {
      isLoading.value = true;


      final response = await Apiservices().getRequest(
        '${ApiUrl.banner}?referenceWebsite=6968869bd31f93ad3cd05004&position=homepage-top',
      );
      log('status Code : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Response after success : ${response.data}');
        isLoading.value = false;
        final bannerResponse = BannerModel.fromJson(response.data);

        model.value = bannerResponse;
        topBanners.assignAll(bannerResponse.banners ?? []);
        //topBanners.assignAll();
      } else {
        isLoading.value = false;
        showSnackBar(title: "Failed", message: response.data['message'] ?? 'Something went wrong', context: Get.context!, error: 'error');

      }
    } catch (e,stackTrace) {
      isLoading.value = false;
      log("❌ API Error: $e");
      log("📄 StackTrace: $stackTrace");
      showSnackBar(title: "Failed", message: e.toString(), context: Get.context!, error: 'error');

    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }



}