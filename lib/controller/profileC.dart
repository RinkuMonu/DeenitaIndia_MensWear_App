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
  RxBool isEditable = false.obs;
  RxBool isEditableMobile = true.obs;
  RxBool isEditableName = true.obs;
  RxBool isEditableEmail = true.obs;
  RxBool isEditableAddress = true.obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getProfile();
  }

  Future<void> makeEditable() async{
    isEditable.value = true;
    isEditableMobile.value = false;
    isEditableEmail.value = false;
    isEditableName.value = false;
    isEditableAddress.value = false;


  }

}