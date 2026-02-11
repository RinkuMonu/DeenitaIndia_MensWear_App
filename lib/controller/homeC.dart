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
    super.onInit();

  }


  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }



}