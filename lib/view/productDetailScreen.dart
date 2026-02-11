import 'package:deenitaindia/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../constants/image.dart';
import '../controller/productDetailController.dart';
import '../widgets/customAppBar.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

      return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "Details",
        showWishlist: false,
        showNotification: true,
        showMenu: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= MAIN IMAGE =================
            Stack(
              children: [
                Obx(
                      () => Image.network(
                    controller.images[controller.selectedImageIndex.value],
                    width: double.infinity,
                    height: size.height * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),

                // Wishlist
                Positioned(
                  top: 12,
                  right: 12,
                  child: Obx(
                        () => _iconButton(
                      icon: controller.isSelected.value
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: controller.isSelected.value
                          ? Colors.pinkAccent
                          : Colors.black,
                      onTap: controller.isSelected.toggle,
                    ),
                  ),
                ),

                // Cart
                Positioned(
                  top: 70,
                  right: 12,
                  child: _iconButton(
                    icon: CupertinoIcons.cart,
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ================= THUMBNAILS =================
            SizedBox(
              height: 90,
              child:  ListView.builder(
                scrollDirection: Axis.horizontal,
                // padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: controller.images.length,
                itemBuilder: (context, index) {

                  return Obx(
                      (){
                        final isSelected =
                            controller.selectedImageIndex.value == index;

                        return GestureDetector(
                          onTap: () => controller.changeImage(index),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.grey.shade300,
                                width: isSelected ? 1 : 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                controller.images[index],
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );

                      }
                  );
                },
              )
            ),

            const SizedBox(height: 16),
            
            Text("Lionies Gija Cotton Slim Fit Self-Design Off Pink Party Shirt",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black
            ),),

            const SizedBox(height: 16),
            
            
            Text("Choose Size",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black
            ),),

            SizedBox(height: 8,),

            SizedBox(
              height: 40,
                child:  ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: controller.sizes.length,
                  itemBuilder: (context, index) {

                    return Obx(
                            (){
                          final isSelected =
                              controller.selectedsizeIndex.value == index;

                          return GestureDetector(
                            onTap: () => controller.changeImage(index),
                            child: Container(
                              alignment: Alignment.center,
                              width: 50,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: isSelected ? AppColors.yellow_shade : Colors.white,
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.grey.shade300,
                                  width: isSelected ? 1 : 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Text(controller.sizes[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16

                                ),)
                              ),
                            ),
                          );

                        }
                    );
                  },
                )
            ),

            SizedBox(height: 16,),
            
            Text("Quantity",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black
              ),),

            SizedBox(height: 12,),


            Obx(() => Row(
              children: [
                _qtyButton(
                  icon: CupertinoIcons.minus,
                  onTap: () =>
                      controller.decreaseQty(controller.count.value),
                ),
                const SizedBox(width: 12),
                Text(controller.count.value.toString()),
                const SizedBox(width: 12),
                _qtyButton(
                  icon: Icons.add,
                  onTap: () =>
                      controller.increaseQty(controller.count.value),
                ),
              ],
            )),


            // 🔽 other product details here
          ],
        ),
      ),
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

  Widget _iconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}