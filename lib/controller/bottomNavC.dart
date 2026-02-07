import 'package:get/get.dart';

class BottomNavC extends GetxController {
  var index = 0.obs;

  void change(int i) {
    index.value = i;
  }
}