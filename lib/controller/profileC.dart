import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/profileM.dart';
import '../service/api.dart';
import '../utils/api_url.dart';
import '../widgets/toast.dart';

class ProfileC extends GetxController{
  final mobile = TextEditingController();
  final email = TextEditingController();
  final firstName = TextEditingController();
  final address = TextEditingController();
  final lastName = TextEditingController();
  var isLoading = false.obs;
  var isLoadingUpdate = false.obs;
  final Rx<ProfileModel> model = ProfileModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }

  Future<ProfileModel?> getProfile() async {

    try {
      isLoading.value = true;


      final response = await Apiservices().getRequest(
        ApiUrl.userInfo,
      );
      log('status Code : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Response after success : ${response.data}');
        isLoading.value = false;
        model.value = ProfileModel.fromJson(response.data);
        mobile.text = model.value.user!.mobile.toString();
        email.text = model.value.user!.email.toString();
        firstName.text = '${model.value.user!.firstName}';
        lastName.text = '${model.value.user!.lastName}';
        address.text = model.value.user!.address.toString();

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

  Future<void> updateProfile() async {
    var m = mobile.text.trim();
    var e = email.text.trim();
    var add = address.text.trim();
    var first = firstName.text.trim();
    var last = lastName.text.trim();
    try {
      isLoadingUpdate.value = true;


      final data = {
        "firstName": first,
        "lastName": last,
        "email": e,
        "mobile": m,
        "address": add
      };
      final response = await Apiservices().postRequest(
        ApiUrl.update,
        data: data,
      );
      print('Sending Data : $data');
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoadingUpdate.value = false;
        final data = response.data;
        Get.back();
      } else {
        isLoadingUpdate.value = false;

        showSnackBar(title: "Failed", message: response.data["msg"] ?? "Something went wrong", context: Get.context!, error: 'error');
      }
    } catch (e) {
      isLoadingUpdate.value = false;

      showSnackBar(title: "Failed", message: 'Something went wrong', context: Get.context!, error: 'error');
    }

  }
}