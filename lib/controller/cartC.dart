import 'package:get/get.dart';

class CartC extends GetxController{

  RxInt item = 1.obs;

  void increase() => item.value++;

  void decrease() {
    if (item.value > 1) {
      item.value--;
    }
  }
}