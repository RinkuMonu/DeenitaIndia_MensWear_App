import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProductDetailController extends GetxController {
  // List of product images (network)
  final images = <String>[
    'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=800',
    'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=800',
    'https://images.unsplash.com/photo-1503602642458-232111445657?w=800',
    'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?w=800',
  ].obs;

  RxInt count = 1.obs;


  final sizes = <String>[
    "XS", "S", "M", "L","XL", "2XL", "3XL"
  ];
  // Selected image index
  final selectedImageIndex = 0.obs;
  final selectedsizeIndex = 0.obs;


  void increaseQty(int index) {
    count.value++;
  }

  /// ➖ Decrease qty
  void decreaseQty(int index) {
    if (    count.value > 1) {
      count.value--;

    }
  }
  // Wishlist
  final isSelected = false.obs;

  void changeImage(int index) {
    selectedImageIndex.value = index;
  }


  void changeSize(int index) {
    selectedsizeIndex.value = index;
  }
}