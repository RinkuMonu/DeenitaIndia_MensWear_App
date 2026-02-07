import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      body: Center(
        child: _emptyNotification(),
      )


    );
  }


  Widget _emptyNotification() {
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
