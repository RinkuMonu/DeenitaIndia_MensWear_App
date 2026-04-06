import 'package:get/get.dart';


class CartItemModel {
  final String name;
  final String image;
  final String size;
  final int price;
  RxInt qty;

  CartItemModel({
    required this.name,
    required this.image,
    required this.size,
    required this.price,
    required int qty,
  }) : qty = qty.obs;
}
class CartC extends GetxController {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCartItems();
  }

  void _loadCartItems() {
    cartItems.assignAll([
      CartItemModel(
        name: 'T-Shirt',
        image: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
        size: 'L',
        price: 1100,
        qty: 1,
      ),
      CartItemModel(
        name: 'Off Pink Party Shirt',
        image: 'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=400',
        size: 'L',
        price: 1100,
        qty: 1,
      ),
      CartItemModel(
        name: 'Off Pink Party Shirt',
        image: 'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=400',
        size: 'L',
        price: 1100,
        qty: 1,
      ),
      CartItemModel(
        name: 'Off Pink Party Shirt',
        image: 'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=400',
        size: 'L',
        price: 1100,
        qty: 1,
      ),
    ]);
  }

  /// ➕ Increase qty
  void increaseQty(int index) {
    cartItems[index].qty.value++;
  }

  /// ➖ Decrease qty
  void decreaseQty(int index) {
    if (cartItems[index].qty.value > 1) {
      cartItems[index].qty.value--;
    }
  }

  /// 🗑 Remove item
  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  /// 💰 Subtotal
  int get subTotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.qty.value));

  /// 💰 GST (example 2%)
  int get gst => (subTotal * 0.02).round();

  /// 🚚 Shipping
  int get shippingFee => 50;

  /// 💰 Total
  int get total => subTotal + gst + shippingFee;
}