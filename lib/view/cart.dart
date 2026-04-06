import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/constants/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controller/cartC.dart';
import '../widgets/button.dart';
import '../widgets/customAppBar.dart';
import '../widgets/textfield.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final _controller = Get.put(CartC());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "My Cart",
        showMenu: false,
        showWishlist: false,
      ),


        body: Obx(() {


          if(_controller.cartItems.isEmpty){
            return Center(child: _emptyCart());
          }



        return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          /// 🛒 CART ITEMS
          ..._controller.cartItems
              .asMap()
              .entries
              .map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: cartItem(item: item, index: index),
            );
          }),

          const SizedBox(height: 100),

          /// 💰 SUMMARY
          _buildRow(
            text: 'Sub-total',
            price: 'Rs ${_controller.subTotal}',
          ),
          _buildRow(
            text: 'GST (%)',
            price: 'Rs ${_controller.gst}',
          ),
          _buildRow(
            text: 'Shipping fee',
            price: 'Rs ${_controller.shippingFee}',
          ),
          const Divider(),
          _buildRow(
            text: 'Total',
            price: 'Rs ${_controller.total}',
          ),

          const SizedBox(height: 24),

          /// ✅ BUTTON (NOW SCROLLS & SHOWS)
          AppButton(
            title: 'Go To Checkout',
            bgColor: AppColors.secondary,
            isIconShow: true,
            onTap: () {},
          ),

          const SizedBox(height: 100), // bottom spacing
        ],
      );
    }),
    );
  }
  Widget cartItem({
    required CartItemModel item,
    required int index,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              item.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

          /// DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE + DELETE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Text(
                            'Size ${item.size}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),

                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _controller.removeItem(index),
                    ),
                  ],
                ),

                SizedBox(height: 16,),

                /// PRICE + QTY
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rs. ${item.price}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff808080),
                      ),
                    ),
                    Obx(() => Row(
                      children: [
                        _qtyButton(
                          icon: CupertinoIcons.minus,
                          onTap: () =>
                              _controller.decreaseQty(index),
                        ),
                        const SizedBox(width: 12),
                        Text(item.qty.value.toString()),
                        const SizedBox(width: 12),
                        _qtyButton(
                          icon: Icons.add,
                          onTap: () =>
                              _controller.increaseQty(index),
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _emptyCart() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppImage.emptyCart, height: 55),
        const SizedBox(height: 12),
        const Text(
          "Cart is empty!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Start shopping and add items \nto your cart",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _qtyButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  Widget _buildRow(
      {
        required String text,
        required String price,
      }
      ){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style: AppTextStyles.alexandria16w300,),
          Text(price,style: AppTextStyles.alexandria16w300Black,),
          
        ],
      ),
    );
  }
}
