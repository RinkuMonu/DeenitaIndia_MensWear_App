import 'package:carousel_slider/carousel_slider.dart';
import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/constants/textstyle.dart';
import 'package:deenitaindia/service/locationServices.dart';
import 'package:deenitaindia/view/notificationScreen.dart';
import 'package:deenitaindia/view/productDetailScreen.dart';
import 'package:deenitaindia/view/wishlistScreen.dart';
import 'package:deenitaindia/widgets/button.dart';
import 'package:deenitaindia/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/size.dart';
import '../controller/bottomNavC.dart';
import '../controller/homeC.dart';
import '../widgets/completeProfilePopup.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = Get.put(HomeC());
  final List<String> textList = ['All', 'Tshirts', 'Jeans', 'Shirts', 'Jacket'];
  final locationController = Get.find<LocationServices>();

  @override
  void initState() {
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

            // ── Header ─────────────────────────────────────
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Style, Your Way', style: AppTextStyles.alexandria32Secondary),
                    Obx(() {
                      final address = locationController.address.value;

                      if (locationController.isLoading.value) {
                        return Text(
                          "Fetching location...",
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                        );
                      }

                      if (address.isEmpty) {
                        return Text(
                          "Location not available",
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                        );
                      }

                      return SizedBox(
                        width: ScreenSize.width * 0.6,
                        child: Text(
                          address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      );
                    }),

                  ],
                ),
                const Spacer(),
                topIcons(icon: AppImage.fav, onIconTap: () => Get.to(() => WishlistScreen())),
                const SizedBox(width: 16),
                topIcons(icon: 'assets/icons/bell.svg', onIconTap: () => Get.to(() => NotificationScreen())),
              ],
            ),
            SizedBox(height: ScreenSize.height * .01),

            // ── Search ─────────────────────────────────────
            // ✅ No Obx here — SearchController is not .obs
            CommonTextField2(
              controller: _controller.searchController,
              readOnly: true,
              showCursor: false,
              suffix: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.mic_none, color: Colors.grey),
              ),
              onTap: () => Get.find<BottomNavC>().change(1),
              hint: 'Search for clothes...',
              preffix: SvgPicture.asset(AppImage.search, height: 28, width: 28),
            ),
            // ── Top Banner Slider ───────────────────────────
            _topBannerSection(),

            // ── Brands ─────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Browsing these top brands",
                    style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400)),
                GestureDetector(
                  onTap: () {},
                  child: Text("View All",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.onboardTextColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.onboardTextColor,
                      )),
                ),
              ],
            ),

            // ✅ Obx with forced read to avoid empty-list GetX error
            Obx(() {
              final brands = _controller.brands;
              return GridView.builder(
                itemCount: brands.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final data = brands[index];
                  return brandLogoSection(image: data.image, offer: data.offer, onTap: () {});
                },
              );
            }),
            SizedBox(height: ScreenSize.height * .03),

            // ── Categories ─────────────────────────────────
            Text("Categories for you",
                style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 16)),
            SizedBox(height: ScreenSize.height * .02),

            // ✅ Obx with forced read
          Obx(() {
            final categories = _controller.category;

            if (categories.isEmpty) {
              return const SizedBox.shrink();
            }

            return SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final data = categories[index];

                  return SizedBox(
                    width: 180, // ✅ VERY IMPORTANT
                    child: categorySection(
                      image: data.image,
                      category: data.offer,
                      onTap: () {},
                    ),
                  );
                },
              ),
            );
          }),
            const SizedBox(height: 20),

            // ── Today Special ───────────────────────────────
            Container(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
              height: ScreenSize.height * 0.35,
              decoration: BoxDecoration(color: AppColors.yellow_shade),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left text + button
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today\nSpecial",
                        style: GoogleFonts.calistoga(fontSize: 22, fontWeight: FontWeight.w400, height: 1.2),
                      ),
                      Text(
                        "     Offers",
                        style: GoogleFonts.bilboSwashCaps(fontSize: 22, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: AppButton(title: "View All", bgColor: AppColors.secondary, onTap: () {}),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  // Right horizontal product list
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) => todaySpecialProducts(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── Full Banner Slider with Dots ────────────────
            // ✅ Obx wraps both carousel and dots together
            Obx(() {
            final banners = _controller.bannerImages;
            final currentIndex = _controller.currentBannerIndex.value;

            return Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: ScreenSize.height * 0.4,
                      child: CarouselSlider.builder(
                        itemCount: banners.length,
                        itemBuilder: (context, index, _) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(banners[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: ScreenSize.height * 0.5,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                          const Duration(milliseconds: 600),
                          autoPlayCurve: Curves.easeInOut,
                          onPageChanged: (index, reason) {
                            _controller.currentBannerIndex.value = index;
                          },
                        ),
                      ),
                    ),

                    /// 🔥 TIMER BADGE (Only if timer exists for this banner)
                    if (_controller.bannerTimers.containsKey(currentIndex))
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  AppImage.limitedTimer,
                                  fit: BoxFit.cover,
                                  height: 40,
                                  width: 80,
                                ),
                              ),
                              const SizedBox(width: 8),

                              /// 🔥 Banner specific timer
                              Text(
                                _controller.bannerTimers[currentIndex] ??
                                    "00 : 00 : 00",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 12),

                /// Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(banners.length, (index) {
                    final isActive = currentIndex == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.secondary
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ],
            );
          }),
            const SizedBox(height: 20),
            
            Image.asset(AppImage.offerMen, height: 160,width: double.maxFinite,),
            const SizedBox(height: 20),

            Text("Occasion- Fits", style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16
            ),),

            Obx(() {
              final categories = _controller.ocassionfit; // ✅ forces tracking

              if (categories.isEmpty) return const SizedBox.shrink(); // ✅ safe empty state

              return GridView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.70,
                  mainAxisSpacing: 12
                ),
                itemBuilder: (context, index) {
                  final data = categories[index];
                  return categorySection(
                    image: data.image,
                    category: data.offer,
                    onTap: () {},
                  );
                },
              );
            }),
            
            Image.asset(AppImage.newArrival, height: 200,fit: BoxFit.cover,),
            const SizedBox(height: 20),

            // ── Category Filter Tabs ────────────────────────
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
                      onTap: () => _controller.selectedIndex.value = index,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.secondary : Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
                    );
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            // ── Products Grid ───────────────────────────────
            GridView.builder(
              itemCount: 6,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) => categoryWiseProduct(onTap: ()=> Get.to(()=> ProductDetailScreen())),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // ── Top Banner (small) ──────────────────────────────────
  Widget _topBannerSection() {
    return Obx(() {
      final banners = _controller.topBanner; // ✅ from controller, not local RxList
      return SizedBox(
        height: 160,
        child: banners.isEmpty
            ? _staticBanner(height: 160)
            : CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (context, index, _) {
            return GestureDetector(
              onTap: () {},
              child: ClipRRect(
                child: Image.asset(banners[index], fit: BoxFit.contain, width: double.infinity),
              ),
            );
          },
          options: CarouselOptions(
            height: 160,
            viewportFraction: 0.90,
            enableInfiniteScroll: banners.length > 1,
            autoPlay: banners.length > 1 && (ModalRoute.of(context)?.isCurrent ?? false),
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 600),
            autoPlayCurve: Curves.easeOut,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        ),
      );
    });
  }

  Widget _staticBanner({required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(AppImage.homeBanner, height: height, fit: BoxFit.cover, width: double.infinity),
    );
  }

  // ── Product Card (grid) ─────────────────────────────────
  Widget categoryWiseProduct({
    required VoidCallback onTap
}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: AppColors.white_shade,
          border: Border.all(color: Colors.grey.shade200, width: 1),
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
                    Image.asset(AppImage.shirt, width: double.infinity, height: 180, fit: BoxFit.cover),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: _colorRatingPill(),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 6, 10, 0),
              child: Text('Polo', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
              child: Text('Brown T-Shirt', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
              child: Row(
                children: [
                  const Text('Rs.1,100',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.red)),
                  const SizedBox(width: 6),
                  Text('Rs.1,500',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 2))],
                      ),
                      child: const Icon(CupertinoIcons.heart, size: 18, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Today Special Product Card ──────────────────────────
  Widget todaySpecialProducts() {
    return Container(
      width: 190,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  Image.asset(AppImage.shirt, height: 150, width: double.infinity, fit: BoxFit.cover),
                  Positioned(bottom: 8, left: 8, child: _colorRatingPill(small: true)),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 4, 10, 0),
            child: Text('Polo', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
            child: Text('Brown T-Shirt', style: TextStyle(fontSize: 11, color: Colors.grey)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
            child: Row(
              children: [
                const Text('Rs.1,100',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.red)),
                const SizedBox(width: 4),
                Text('1,500',
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Reusable color swatches + rating pill ───────────────
  Widget _colorRatingPill({bool small = false}) {
    final size = small ? 10.0 : 12.0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: small ? 6 : 8, vertical: small ? 3 : 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.88),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6)],
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
          Text("+3", style: TextStyle(fontSize: small ? 10 : 11, fontWeight: FontWeight.w500, color: Colors.black54)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text("|", style: TextStyle(color: Colors.black26, fontSize: small ? 11 : 13)),
          ),
          Icon(Icons.star_rounded, color: Colors.amber, size: small ? 12 : 14),
          const SizedBox(width: 2),
          Text("4.5", style: TextStyle(fontSize: small ? 10 : 11, fontWeight: FontWeight.w500, color: Colors.black54)),
        ],
      ),
    );
  }

  // ── Category card ───────────────────────────────────────
  Widget categorySection({
    required String image,
    required String category,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded( // ✅ IMPORTANT
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                category,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
  // ── Brand logo ──────────────────────────────────────────
  Widget brandLogoSection({required String image, required String offer, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(AppImage.brandCategoryBg), fit: BoxFit.contain),
            ),
            child: Image.asset(image, fit: BoxFit.contain, height: 40),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
              child: Text(offer, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
            ),
          ),
        ],
      ),
    );
  }

  // ── Top icon ────────────────────────────────────────────
  Widget topIcons({required String icon, required VoidCallback onIconTap}) {
    return GestureDetector(onTap: onIconTap, child: SvgPicture.asset(icon));
  }
}