import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OrderDetailController extends GetxController {
  final rating = 0.obs;

  // "packing" | "picked" | "in_transit" | "delivered"
  final orderStatus = "in_transit".obs;

  bool get isDelivered => orderStatus.value == "in_transit";

  int get currentStep {
    switch (orderStatus.value) {
      case "packing":    return 0;
      case "picked":     return 1;
      case "in_transit": return 2;
      case "delivered":  return 3;
      default:           return 0;
    }
  }
}