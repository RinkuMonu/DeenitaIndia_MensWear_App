import 'package:carousel_slider/carousel_slider.dart';
import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/constants/textstyle.dart';
import 'package:deenitaindia/view/notificationScreen.dart';
import 'package:deenitaindia/view/productDetailScreen.dart';
import 'package:deenitaindia/view/search.dart';
import 'package:deenitaindia/view/setting.dart';
import 'package:deenitaindia/view/wishlistScreen.dart';
import 'package:deenitaindia/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../constants/size.dart';
import '../controller/bottomNavC.dart';
import '../controller/homeC.dart';
import '../model/bannerM.dart';
import '../utils/api_url.dart';
import '../widgets/completeProfilePopup.dart';
import '../widgets/container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = Get.put(HomeC());

  List textList = ['All', 'Tshirts', 'Jeans', 'Shirts', 'Jackect'];


  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCompleteProfilePopup(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenSize.height * .06),
            Row(
              children: [
                Text(
                  'Style, Your Way',
                  style: AppTextStyles.alexandria32Secondary,
                ),
                Spacer(),
                topIcons(icon: AppImage.fav, onIconTap: () {
                  Get.to(() => WishlistScreen());
                }),
                SizedBox(width: 16),
                topIcons(icon: 'assets/icons/bell.svg', onIconTap: () {
                  Get.to(() => NotificationScreen());
                }),
              ],
            ),
            SizedBox(height: ScreenSize.height * .01),
            CommonTextField2(
              controller: _controller.searchController,
              readOnly: true,
              showCursor: false,
              onTap: (){
                Get.find<BottomNavC>().change(1);
              },
              hint: 'Search for clothes...',
              preffix: SvgPicture.asset(
                AppImage.search,
                height: 28,
                width: 28,
              ),
            ),

            SizedBox(height: ScreenSize.height * .01),
            Image.asset(AppImage.homeBanner, height: 160,fit: BoxFit.cover,width: double.maxFinite,),

            SizedBox(height: ScreenSize.height * .022),

            SizedBox(
              height: ScreenSize.height * .04,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: textList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Obx(() {
                    final isSelected = _controller.selectedIndex.value == index;
                    return InkWell(
                      onTap: () {
                        _controller.selectedIndex.value = index;
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.secondary
                              : Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.2),
                          //     blurRadius: 8,
                          //     spreadRadius: 2,
                          //     offset: const Offset(0, 8), // downward shadow
                          //   ),
                          // ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 4,
                          ),
                          child: Text(
                            textList[index],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Alexandria',
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            GridView.builder(
              itemCount: 6,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.70,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      final isSelected = _controller.selectedFav.value == index;
                      return InkWell(
                        onTap: (){
                          Get.to(() => ProductDetailScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Image.asset(AppImage.shirt),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: InkWell(
                                  onTap: () {
                                    _controller.selectedFav.value = isSelected
                                        ? -1
                                        : index;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: isSelected
                                        ? Icon(
                                            CupertinoIcons.heart_fill,
                                            color: Colors.pinkAccent,
                                          )
                                        : Icon(CupertinoIcons.heart),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    Text(
                      'Beige Oversized T-Shirt',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      spacing: 4,
                      children: [
                        Text(
                          'Rs. 1,190',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        if (index == 1)
                          Text(
                            '50%OFF',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),

                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15,
                            ),

                            Text(
                              "4.5k",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 100),

          ],
        ),
      ),
    );
  }

  Widget topIcons({required String icon, required VoidCallback onIconTap}) {
    return GestureDetector(onTap: onIconTap, child: SvgPicture.asset(icon));
  }

  Widget _bannerSection(
    RxList<BannersData> banners,
    double height,
    BoxFit fit,
  ) {
    return SizedBox(
      height: height + 80, // 🔥 tall like poster banner
      child: Obx(() {
        // if (banners.isEmpty) {
        //   return _staticBanner(height: height);
        // }

        final currentPage = _controller.bannerPage.value;

        return CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (context, index, realIndex) {
            final banner = banners[index];

            double value = index - currentPage;
            value = value.clamp(-1.0, 1.0);

            // 🔥 subtle floating (NO shrinking)
            final double translateY = value.abs() * 8;
            final double rotateZ = value * 0.004;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6,
                    offset: Offset(0, 1),
                  ),
                ],

                /// 🔥 IMAGE AS BACKGROUND
                // image: DecorationImage(
                //   image: NetworkImage(
                //     "${ApiUrl.bannerBaseUrl}${banner.images!.first}",
                //   ),
                //   fit: BoxFit.contain,
                // ),
                image: DecorationImage(
                  image: NetworkImage(
                    "${ApiUrl.bannerBaseUrl}${banner.images!.first}",
                  ),
                  fit: fit,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: height + 120,
            viewportFraction: 1, // 🔥 edge-to-edge feel
            enlargeCenterPage: false,
            enableInfiniteScroll: banners.length > 1,
            autoPlay: banners.length > 1,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 900),
            autoPlayCurve: Curves.easeOutCubic,
            scrollPhysics: const BouncingScrollPhysics(),
            onPageChanged: (index, reason) {
              _controller.bannerPage.value = index.toDouble();
            },
          ),
        );
      }),
    );
  }
}
