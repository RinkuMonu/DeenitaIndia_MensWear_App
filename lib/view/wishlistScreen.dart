import 'package:deenitaindia/view/productDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../constants/colors.dart';
import '../constants/image.dart';
import '../widgets/customAppBar.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "WishList",
        showMenu: false,
        appBarBgColor: Colors.white,
        showWishlist: false,
      ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Image.asset(AppImage.adBanner, fit: BoxFit.cover),
              const SizedBox(height: 20),

              Expanded( // ✅ IMPORTANT
                child: wishListItem(),
              ),
            ],
          ),
        )

    );
  }



  Widget wishListItem() {
    return GridView.builder(
      itemCount: 6,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(), // ✅ smooth scroll
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.60,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (_, __) =>
          categoryWiseProduct(onTap: () => Get.to(() => ProductDetailScreen())),
    );
  }


  Widget categoryWiseProduct({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: AppColors.white_shade,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.asset(AppImage.shirt,
                        width: double.infinity, height: 180, fit: BoxFit.cover),
                    Positioned(
                        bottom: 8, left: 8, child: _colorRatingPill()),
                  ],
                ),
              ),
            ),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 6, 10, 0),
                      child: Text('Polo',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87)),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
                      child: Text('Brown T-Shirt',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
                      child: Row(
                        children: [
                          const Text('Rs.1,100',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(width: 4),
                          Text('Rs.1,500',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.grey)),


                        ],
                      ),
                    ),

                  ],
                ),

                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2))
                          ],
                        ),
                        child: const Icon(CupertinoIcons.heart_fill,
                            size: 18, color: Colors.pink),
                      ),
                    ),
                  ],
                )
              ],
            ),

          ],
        ),
      ),
    );
  }


  Widget _colorRatingPill({bool small = false}) {
    final size = small ? 10.0 : 12.0;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: small ? 6 : 8, vertical: small ? 3 : 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.88),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06), blurRadius: 6)
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...[Colors.red, Colors.blueGrey, Colors.blue].map((c) => Container(
            margin: const EdgeInsets.only(right: 4),
            height: size,
            width: size,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          )),
          Text("+3",
              style: TextStyle(
                  fontSize: small ? 10 : 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text("|",
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: small ? 11 : 13)),
          ),
          Icon(Icons.star_rounded,
              color: Colors.amber, size: small ? 12 : 14),
          const SizedBox(width: 2),
          Text("4.5",
              style: TextStyle(
                  fontSize: small ? 10 : 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _emptyWishlist() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppImage.emptyWishList, height: 55),
        const SizedBox(height: 12),
        const Text(
          "Wishlist is empty!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Add items you love to your \nwishlist",
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

}
