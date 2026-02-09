import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/view/search.dart';
import 'package:deenitaindia/view/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/bottomNavC.dart';
import 'cart.dart';
import 'home.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  final BottomNavC controller = Get.put(BottomNavC());

  final List<Widget> pages = const [
    Home(),
    Search(),
    Center(child: Text('Category')),
    CartView(),
    Setting(),
  ];

  final List<String> labels = [
    'Home',
    'Search',
    'Category',
    'Cart',
    'Account',
  ];

  final List<String> icons = [
    AppImage.home,
    AppImage.search,
    AppImage.more,
    AppImage.cart,
    AppImage.user,
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        extendBody: true,
        // backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: pages[controller.index.value],
        ),

        bottomNavigationBar: Container(
          color: Colors.grey.shade50,
          child: CurvedNavigationBar(
            index: controller.index.value,
            height: 65,
            // backgroundColor: Colors.blueGrey.shade50,
            color: Colors.white,
            animationDuration: const Duration(milliseconds: 300),
            items: List.generate(icons.length, (i) {
              final bool isSelected = controller.index.value == i;
              return CurvedNavigationBarItem(
                child: SvgPicture.asset(
                  icons[i],
                  height: 22,
                  colorFilter: ColorFilter.mode(
                    isSelected ? Colors.black : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: labels[i],
                labelStyle: TextStyle(
                  fontSize: 11,
                  fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.black : Colors.grey,
                ),
              );
            }),

            onTap: controller.change,
          ),
        ),
      );
    });
  }
}