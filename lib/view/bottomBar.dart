import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/view/profile.dart';
import 'package:deenitaindia/view/setting.dart';
import 'package:deenitaindia/view/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/bottomNavC.dart';
import '../widgets/painter.dart';
import 'cart.dart';
import 'home.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final controller = Get.put(BottomNavC());
  int _currentIndex = 0;

  final labels = ['Home', 'Search', 'Category', 'Cart', 'Account'];
  final icons = [
    SvgPicture.asset(AppImage.home),
    SvgPicture.asset(AppImage.search),
    SvgPicture.asset(AppImage.more),
    SvgPicture.asset(AppImage.cart),
    SvgPicture.asset(AppImage.user),
  ];
  final  _pages = const [
    Home(),
    Wishlist(),
    Center(child: Text('Search')),
    CartView(),
    Setting(),
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: _pages[_currentIndex],
        bottomNavigationBar: Obx(() {
          final itemWidth = width / icons.length;
          final centerX = itemWidth * controller.index.value + itemWidth / 2;

          return SizedBox(
            height: 95,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomPaint(
                  size: Size(width, 70),
                  painter: NavPainter(centerX),
                ),

                // Floating Active Icon
                Positioned(
                  bottom: 40,
                  left: centerX - 30,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: icons[controller.index.value],
                  ),
                ),

                // Nav Items
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: List.generate(icons.length, (i) {
                      final active = controller.index.value == i;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => controller.change(i),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: active ? 40 : 0),
                              icons[controller.index.value],
                              const SizedBox(height: 4),
                              Text(
                                labels[i],
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                  active ? Colors.black : Colors.grey,
                                  fontWeight: active
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        })
    );
  }
}
