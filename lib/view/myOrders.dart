import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/image.dart';
import '../controller/myOrderController.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  final controller = Get.put(MyOrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "My Orders",
        showMenu: false,
        showNotification: true,
        showWishlist: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Obx(
                    () => Row(
                  children: [
                    _segmentButton(
                      title: 'Ongoing',
                      index: 0,
                      isSelected: controller.selectedIndex.value == 0,
                    ),
                    _segmentButton(
                      title: 'Completed',
                      index: 1,
                      isSelected: controller.selectedIndex.value == 1,
                    ),
                  ],
                ),
              ),
            ),


            SizedBox(height: 20,),

            Obx(
              () {
                final isOngoing = controller.selectedIndex.value == 0;


                if(!isOngoing){
                  return Column(
                    children: [
                      SizedBox(height: 200,),

                      Center(child: _emptyCart()),
                    ],
                  );
                }

                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index){
                      return  orderItem(
                          image: 'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=400',
                          title: 'Off Pink Party Shirt',
                          size: 'L',
                          qty: '10',
                          rate: '1100',
                          deliveryTime: 'Delivered by 15/02/26',
                          color: isOngoing ? Colors.green : Colors.blueAccent
                      );

                    });
              }
            )


          ],
        ),
      ),
    );
  }


  Widget _emptyCart() {
    final isOngoing = controller.selectedIndex.value == 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppImage.emptyOrders, height: 55),
        const SizedBox(height: 12),
        Text(
           isOngoing ? "No Orders in Progress!" :" No Completed Orders Found!",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12),
         Text(
          isOngoing ? "You currently have no orders in progress." : "You don’t have any completed orders at the moment.",
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



  Widget orderItem({
    required String image,
    required String title,
    required String size,
    required String qty,
    required String rate,
    required String deliveryTime,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- Image ----------------
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              image,
              height: 90,
              width: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 90,
                width: 90,
                color: Colors.grey.shade100,
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // ---------------- Content ----------------
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 4),

                // Size & Qty
                Text(
                  'Size $size | Qty $qty',
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 24),

                // Price & Delivery
                Row(
                  children: [
                    Text(
                      'Rs. $rate',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),

                    const Spacer(),

                    Row(
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          deliveryTime,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _segmentButton({
    required String title,
    required int index,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
