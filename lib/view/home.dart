import 'package:carousel_slider/carousel_slider.dart';
import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/constants/textstyle.dart';
import 'package:deenitaindia/models/subCategory_model.dart';
import 'package:deenitaindia/service/locationServices.dart';
import 'package:deenitaindia/utils/api_url.dart';
import 'package:deenitaindia/view/allBrandsPage.dart';
import 'package:deenitaindia/view/notificationScreen.dart';
import 'package:deenitaindia/view/productDetailScreen.dart';
import 'package:deenitaindia/view/product_list_page.dart';
import 'package:deenitaindia/view/wishlistScreen.dart';
import 'package:deenitaindia/widgets/button.dart';
import 'package:deenitaindia/widgets/ribbonClipper.dart';
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
  // ── Controllers & Data ───────────────────────────────────
  final _controller        = Get.put(HomeC());
  final locationController = Get.find<LocationServices>();

  final List<String> textList     = ['All', 'Tshirts', 'Jeans', 'Shirts', 'Jacket'];
  final List<String> categoryTabs = ['All', 'Men', 'Women', 'Kids'];
  final List<String> kidsSubTabs  = ['Girl', 'Boy', 'Infant'];

  static const List<Map<String, Color>> kidsTabColors = [
    {
      'bg':             Color(0xFFFFD5F1),
      'text':           Color(0xFFD63A7A),
      'unselectedBg':   Color(0xFFE0E0E0),
      'unselectedText': Color(0xFFD63A7A),
    },
    {
      'bg':             Color(0xFFD5EDFF),
      'text':           Color(0xFF1A73C7),
      'unselectedBg':   Color(0xFFE0E0E0),
      'unselectedText': Color(0xFF1A73C7),
    },
    {
      'bg':             Color(0xFFFFFCD5),
      'text':           Color(0xFFE65100),
      'unselectedBg':   Color(0xFFE0E0E0),
      'unselectedText': Color(0xFFE65100),
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCompleteProfilePopup(context);
    });
  }

  // ── Helpers ──────────────────────────────────────────────

  /// Returns effectiveIndex based on main category + kids sub-tab
  int get _effectiveIndex {
    final main = _controller.selectedMainCategory.value;
    if (main != 3) return main;
    final kids = _controller.selectedKidsTab.value;
    if (kids == 0) return 2; // Girl  → girlBand
    if (kids == 1) return 1; // Boy   → boyBand
    return 3;                // Infant → infantBand
  }

  String _backgroundImage(int ei) => ei == 1
      ? AppImage.boyBand
      : ei == 2 ? AppImage.girlBand : AppImage.infantBand;

  String _priceBgImage(int ei) => ei == 1
      ? AppImage.boysSectionPrice
      : ei == 2 ? AppImage.girlsSectionPrice : AppImage.infantsSectionPrice;

  Color _textColor(int ei) => ei == 1
      ? AppColors.boysSectionblueColor
      : ei == 2
      ? AppColors.girlsSectionblueColor
      : AppColors.infantsSectionblueColor;

  // ── Static mock data ─────────────────────────────────────
  static const List<String> _priceList = [
    "Under\n99", "Under\n199", "Under\n99", "Under\n199",
  ];

  static const List<Map<String, String>> _products = [
    {"image": AppImage.ocssionFit1, "price": "99", "brand": "RARE RABBIT"},
    {"image": AppImage.ocssionFit1, "price": "99", "brand": "RARE RABBIT"},
    {"image": AppImage.ocssionFit1, "price": "99", "brand": "RARE RABBIT"},
    {"image": AppImage.ocssionFit1, "price": "99", "brand": "RARE RABBIT"},
    {"image": AppImage.ocssionFit1, "price": "99", "brand": "RARE RABBIT"},
  ];

  // ════════════════════════════════════════════════════════
  // BUILD
  // ════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Stack(
          children: [

            /// ✅ MAIN UI (unchanged)
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenSize.height * .06),

                  _header(),
                  SizedBox(height: ScreenSize.height * .01),

                  _searchBar(),
                  mainCategoryTab(),
                  SizedBox(height: ScreenSize.height * .01),

                  _kidsSubTab(),
                  SizedBox(height: ScreenSize.height * .02),

                  _roundCategoryList(),
                  _topBannerSection(),

                  SizedBox(height: ScreenSize.height * .02),
                  _bankOffer(),

                  SizedBox(height: ScreenSize.height * .02),
                  _brandsSection(),

                  SizedBox(height: ScreenSize.height * .03),
                  _categoriesSection(),

                  SizedBox(height: ScreenSize.height * .02),
                  _offerImageSection(),

                  SizedBox(height: ScreenSize.height * .02),
                  _mainBannerSlider(),

                  SizedBox(height: ScreenSize.height * .02),
                  _todaySpecialSection(),

                  SizedBox(height: ScreenSize.height * .02),
                  _brandsInSpotlight(),

                  SizedBox(height: ScreenSize.height * .02),
                  _categoryBannerSlider(),

                  SizedBox(height: ScreenSize.height * .02),
                  _occasionFitSection(),

                  _trendingSection(),

                  SizedBox(height: ScreenSize.height * .02),
                  _bottomOfferImage(),

                  SizedBox(height: ScreenSize.height * .02),
                  _newArrivalImage(),

                  SizedBox(height: ScreenSize.height * .02),
                  _categoryFilterTabs(),

                  SizedBox(height: ScreenSize.height * .02),
                  _productsGrid(),

                  const SizedBox(height: 100),
                ],
              ),
            ),

            /// ✅ LOADER OVERLAY (BEST PRACTICE)
            if (_controller.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      }),
    );
  }

  // ════════════════════════════════════════════════════════
  // SECTION BUILDERS
  // ════════════════════════════════════════════════════════

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Style, Your Way', style: AppTextStyles.alexandria32Secondary),
              Obx(() {
                if (locationController.isLoading.value) {
                  return Text("Fetching location...",
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade400));
                }
                final address = locationController.address.value;
                if (address.isEmpty) {
                  return Text("Location not available",
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade400));
                }
                return SizedBox(
                  width: ScreenSize.width * 0.6,
                  child: Text(
                    address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                  ),
                );
              }),
            ],
          ),
          const Spacer(),
          topIcons(icon: AppImage.fav, onIconTap: () => Get.to(() => WishlistScreen())),
          const SizedBox(width: 16),
          topIcons(
              icon: 'assets/icons/bell.svg',
              onIconTap: () => Get.to(() => NotificationScreen())),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: CommonTextField2(
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
    );
  }

  Widget _roundCategoryList() {
    return Obx(() {
      final categories = _controller.category;
      if (categories.isEmpty) return const SizedBox.shrink();
      return SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.only(right: 12),
            child: roundCategory(
              images: "${ApiUrl.bannerBaseUrl}${categories[index].smallImage }"?? AppImage.shirt,
              text: categories[index].name ?? "N/A",
            ),
          ),
        ),
      );
    });
  }

  Widget _bankOffer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Image.asset(AppImage.bankOffer, fit: BoxFit.cover),
    );
  }

  Widget _brandsSection() {
    return Obx(() {
      if (_controller.selectedMainCategory.value != 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text("Featured Brands",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16)),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _controller.brandsLists.length,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (_, index){
                  final data = _controller.brandsLists[index];
                  return SizedBox(
                    width: 160,
                    child: categoryWiseCatalog(
                      image: "${ApiUrl.bannerBaseUrl}${data.banner }" ?? AppImage.shirt,
                      brandName: data.name ?? "N/A",
                      offer: "Min. 20% Off",
                      onTap: (){
                        Get.to(() => ProductListPage());
                      },
                    ),
                  );
                }
              ),
            ),
          ],
        );
      }

      final brands = _controller.brandsLists;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Browsing these top brands",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w400)),
                GestureDetector(
                  onTap: () => Get.to(()=> AllBrandsPage()),
                  child: Text("View All",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.onboardTextColor,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenSize.height * .01),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: AppColors.yellow_shade,
            child: GridView.builder(
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
              itemBuilder: (_, index) => brandLogoSection(
                image: "${ApiUrl.bannerBaseUrl}${brands[index].logo }"?? AppImage.ironWolf,
                offer: "50%OFF",
                onTap: () {
                  Get.to(() => ProductListPage());
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _categoriesSection() {
    return Obx(() {
      final categories = _controller.category;
      final main = _controller.selectedMainCategory.value;

      if (main != 0) {
        final ei = _effectiveIndex;
        return categoryWiseSuperSweetSection(
          backgroundImage: _backgroundImage(ei),
          textColor: _textColor(ei),
          pricebgImage: _priceBgImage(ei),
          pricelist: _priceList,
          products: _products,
          onViewAllTap: () {
            Get.to(() => ProductListPage());
          },
          onProductsTap: () {
            Get.to(() => ProductDetailScreen());
          },
          onPriceTap: (_) {
            Get.to(() => ProductListPage());
          },
        );
      }

      if (categories.isEmpty) return const SizedBox.shrink();

      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Categories for you",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 16)),
            ),
          ),
          SizedBox(height: ScreenSize.height * .02),
          _buildCategorySection(
              title: "Men", color: AppColors.blueshade, categories: categories),
          _buildCategorySection(
              title: "Women", color: AppColors.pinkshade, categories: categories),
          _buildCategorySection(
              title: "Kids", color: AppColors.orangeshade, categories: categories),
        ],
      );
    });
  }

  Widget _offerImageSection() {
    return Obx(() {
      if (_controller.selectedMainCategory.value == 0) return const SizedBox.shrink();
      return Container(
        margin: const EdgeInsets.only(left: 16, bottom: 20),
        child: Image.asset(AppImage.offerMen, fit: BoxFit.fill, height: 150),
      );
    });
  }

  Widget _mainBannerSlider() {
    return Obx(() {
      if (_controller.selectedMainCategory.value != 0) return const SizedBox.shrink();
      return _bannerSlider(
        height: ScreenSize.height * 0.4,
        viewportFraction: 1.0,
      );
    });
  }

  Widget _categoryBannerSlider() {
    return Obx(() {
      if (_controller.selectedMainCategory.value == 0) return const SizedBox.shrink();
      return _bannerSlider(
        height: ScreenSize.height * 0.3,
        viewportFraction: 0.8,
      );
    });
  }

  /// Shared banner slider — used for both main (full) and category (peek) variants
  Widget _bannerSlider({required double height, required double viewportFraction}) {
    final banners      = _controller.bannerImages;
    final currentIndex = _controller.currentBannerIndex.value;

    return Column(
      children: [
        SizedBox(
          height: height,
          child: CarouselSlider.builder(
            itemCount: banners.length,
            itemBuilder: (_, index, __) => GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(banners[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  if (_controller.bannerTimers.containsKey(index))
                    Positioned(
                      left: 16,
                      top: 16,
                      child: _timerBadge(index),
                    ),
                ],
              ),
            ),
            options: CarouselOptions(
              height: height,
              viewportFraction: viewportFraction,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              autoPlayCurve: Curves.easeInOut,
              onPageChanged: (index, _) =>
              _controller.currentBannerIndex.value = index,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
            final isActive = currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: isActive ? 20 : 8,
              decoration: BoxDecoration(
                color: isActive ? AppColors.secondary : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _timerBadge(int index) {
    return Container(
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
            child: Image.asset(AppImage.limitedTimer,
                fit: BoxFit.cover, height: 40, width: 80),
          ),
          const SizedBox(width: 8),
          Text(
            _controller.bannerTimers[index] ?? "00 : 00 : 00",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _todaySpecialSection() {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
      height: ScreenSize.height * 0.35,
      decoration: BoxDecoration(color: AppColors.yellow_shade),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today\nSpecial",
                  style: GoogleFonts.calistoga(
                      fontSize: 22, fontWeight: FontWeight.w400, height: 1.2)),
              Text("     Offers",
                  style: GoogleFonts.bilboSwashCaps(
                      fontSize: 22, fontWeight: FontWeight.w400)),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                width: 100,
                child: AppButton(
                    title: "View All",
                    bgColor: AppColors.secondary,
                    onTap: () {}),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (_, __) => todaySpecialProducts(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _brandsInSpotlight() {
    return Obx(() => _controller.selectedMainCategory.value != 0
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text("Brands in spotlight",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16)),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (_, index) => SizedBox(
              width: 160,
              child: categoryWiseCatalog(
                image: AppImage.ocssionFit1,
                brandName: "Lionies",
                offer: "Min. 20% Off",
                onTap: () {
                  Get.to(() => ProductDetailScreen());
                },
              ),
            ),
          ),
        ),
      ],
    )
        : const SizedBox.shrink());
  }

  Widget _occasionFitSection() {
    return Obx(() {
      final categories = _controller.ocassionfit;
      if (categories.isEmpty) return const SizedBox.shrink();

      final selected = _controller.selectedMainCategory.value;
      return Column(
        children: [
          if (selected == 0 || selected == 1)
            _buildOccasionSection(
                title: "Occasion - Fits Men", categories: categories),
          if (selected == 0 || selected == 2)
            _buildOccasionSection(
                title: "Occasion - Fits Women", categories: categories),
          if (selected != 0 && selected != 1 && selected != 2)
            _buildOccasionSection(
                title: "Occasion - Fits Kids", categories: categories),
        ],
      );
    });
  }

  Widget _trendingSection() {
    return Obx(() {
      if (_controller.selectedMainCategory.value == 0) return const SizedBox.shrink();
      return trendingStyleSection(
        onTapCard: () {
          Get.to(() => ProductDetailScreen());
        },
        onAddToCartTap: () {
         Get.find<BottomNavC>().change(3);
        },
        onLikeTap: () {
          Get.to(() => WishlistScreen());
        },
        image: AppImage.bannerModel,
      );
    });
  }

  Widget _bottomOfferImage() {
    return Obx(() {
      final zeroIndex = _controller.selectedMainCategory.value == 0;
      return Padding(
        padding: EdgeInsets.only(
            left: zeroIndex ? 12 : 0, right: zeroIndex ? 0 : 12),
        child: Image.asset(AppImage.offerMen, fit: BoxFit.fill, height: 160),
      );
    });
  }

  Widget _newArrivalImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Image.asset(AppImage.newArrival, height: 200, fit: BoxFit.cover),
    );
  }

  Widget _categoryFilterTabs() {
    return Obx(() {
      final zeroIndex = _controller.selectedMainCategory.value == 0;
      final data = zeroIndex ? categoryTabs : textList;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          height: ScreenSize.height * 0.04,
          child: Row(
            children: [
              Image.asset(AppImage.newArrivalImage,
                  height: 40, width: 40, fit: BoxFit.contain),
              const SizedBox(width: 16),
              Image.asset(AppImage.topRated,
                  height: 40, width: 40, fit: BoxFit.contain),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) => Obx(() {
                    final isSelected = _controller.selectedIndex.value == index;
                    return InkWell(
                      onTap: () => _controller.selectedIndex.value = index,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.secondary : Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 4),
                        child: Text(
                          data[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _productsGrid() {
    return GridView.builder(
      itemCount: 6,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (_, __) =>
          categoryWiseProduct(onTap: () => Get.to(() => ProductDetailScreen())),
    );
  }

  // ════════════════════════════════════════════════════════
  // KIDS SUB TAB
  // ════════════════════════════════════════════════════════

  Widget _kidsSubTab() {
    return Obx(() {
      if (_controller.selectedMainCategory.value != 3) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
          ),
          child: Obx(() => Row(
            children: List.generate(kidsSubTabs.length, (index) {
              final isSelected = _controller.selectedKidsTab.value == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _controller.selectedKidsTab.value = index,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? kidsTabColors[index]['bg']!
                          : kidsTabColors[index]['unselectedBg']!,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      kidsSubTabs[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
              );
            }),
          )),
        ),
      );
    });
  }

  // ════════════════════════════════════════════════════════
  // MAIN CATEGORY TAB
  // ════════════════════════════════════════════════════════

  Widget mainCategoryTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 42,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryTabs.length,
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) => Obx(() {
              final isSelected = _controller.selectedMainCategory.value == index;
              return InkWell(
                onTap: () => _controller.selectedMainCategory.value = index,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      child: Text(
                        categoryTabs[index],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: isSelected
                              ? AppColors.onboardTextColor
                              : Colors.grey,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 2,
                      width: isSelected ? 40 : 0,
                      color: AppColors.onboardTextColor,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }

  // ════════════════════════════════════════════════════════
  // REUSABLE WIDGETS
  // ════════════════════════════════════════════════════════

  Widget _buildOccasionSection({
    required String title,
    required List categories,
  }) {
    return GestureDetector(
      onTap: (){
        Get.to(() => ProductListPage());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.homeCategorybg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            RibbonLabel(text: title),
            GridView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.70,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (_, index) => categorySection(
                image: categories[index].image,
                category: categories[index].offer,
                onTap: () {
                  Get.to(() => ProductDetailScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget trendingStyleSection({
    required VoidCallback onTapCard,
    required VoidCallback onAddToCartTap,
    required VoidCallback onLikeTap,
    required String image,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Trending Styles for You',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey)),
        ),
        const SizedBox(height: 10),
        _trendingRow(onTapCard, onAddToCartTap, onLikeTap, image),
        const SizedBox(height: 12),
        _trendingRow(onTapCard, onAddToCartTap, onLikeTap, image),
      ],
    );
  }

  Widget _trendingRow(VoidCallback onTapCard, VoidCallback onAddToCartTap,
      VoidCallback onLikeTap, String image) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 10,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) => _trendingProductCard(
          onTapCard: onTapCard,
          onAddToCartTap: onAddToCartTap,
          onLikeTap: onLikeTap,
          image: image,
        ),
      ),
    );
  }

  Widget _trendingProductCard({
    required VoidCallback onTapCard,
    required VoidCallback onAddToCartTap,
    required VoidCallback onLikeTap,
    required String image,
  }) {
    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  Image.asset(AppImage.shirt,
                      height: 150, width: double.infinity, fit: BoxFit.cover),
                  Positioned(
                      bottom: 8,
                      left: 8,
                      child: _colorRatingPill(small: true)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Polo',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  const Text('BROWN T-SHIRT',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          letterSpacing: 0.3)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text('1,500',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black38,
                              decoration: TextDecoration.lineThrough)),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('15% OFF',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.orange)),
                      ),
                      const SizedBox(width: 4),
                      const Text('Rs.1,100',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: AppButton(
                  title: "Add To Cart",
                  onTap: onAddToCartTap,
                  bgColor: AppColors.yellow_shade,
                  textColor: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBannerSection() {
    return Obx(() {
      final banners = _controller.topBanner;
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 160,
            child: banners.isEmpty
                ? _staticBanner(height: 160)
                : CarouselSlider.builder(
              itemCount: banners.length,
              itemBuilder: (_, index, __) => GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(banners[index],
                      fit: BoxFit.contain, width: double.infinity),
                ),
              ),
              options: CarouselOptions(
                height: 160,
                viewportFraction: 0.90,
                enableInfiniteScroll: banners.length > 1,
                autoPlay: banners.length > 1 &&
                    (ModalRoute.of(context)?.isCurrent ?? false),
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration:
                const Duration(milliseconds: 600),
                autoPlayCurve: Curves.easeOut,
                scrollPhysics: const BouncingScrollPhysics(),
                onPageChanged: (index, _) =>
                _controller.currentBannerIndex.value = index,
              ),
            ),
          ),
          if (banners.isNotEmpty)
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(banners.length, (index) {
                final isActive =
                    _controller.currentBannerIndex.value == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 6,
                  width: isActive ? 16 : 6,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.black : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            )),
        ],
      );
    });
  }

  Widget categoryWiseSuperSweetSection({
    required String backgroundImage,
    required String pricebgImage,
    required Color textColor,
    required List<String> pricelist,
    required VoidCallback onViewAllTap,
    required VoidCallback onProductsTap,
    required Function(int) onPriceTap,
    required List<Map<String, String>> products,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Super ",
                  style: GoogleFonts.alike(color: textColor, fontSize: 24)),
              TextSpan(
                  text: "Sweet ",
                  style: GoogleFonts.beiruti(
                      fontSize: 24,
                      color: textColor,
                      fontWeight: FontWeight.w600)),
              TextSpan(
                  text: "Savings",
                  style: GoogleFonts.alice(fontSize: 24, color: textColor)),
            ]),
          ),
        ),
        const SizedBox(height: 20),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: onViewAllTap,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("View All",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: textColor,
                                    decorationColor: textColor,
                                    decoration: TextDecoration.underline)),
                            const SizedBox(width: 6),
                            Icon(Icons.arrow_outward,
                                size: 16, color: textColor),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 230,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: products.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(width: 12),
                      itemBuilder: (_, index) {
                        final item = products[index];
                        return GestureDetector(
                          onTap: onProductsTap,
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3))
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                        child: Image.asset(item['image']!,
                                            width: double.infinity,
                                            fit: BoxFit.cover),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 6),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.7),
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Starting Rs.${item['price']}",
                                              style: GoogleFonts.courgette(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                shadows: const [
                                                  Shadow(
                                                      blurRadius: 6,
                                                      color: Colors.black)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(item['brand']!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 2)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // ── Price circles ─────────────────────────────
            Positioned(
              top: -10,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(pricelist.length, (index) {
                    return GestureDetector(
                      onTap: () => onPriceTap(index),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(pricebgImage,
                                width: 120,
                                height: 100,
                                fit: BoxFit.cover),
                            Text(
                              pricelist[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCategorySection({
    required String title,
    required Color color,
    required List<SubCategory> categories,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      color: color,
      height: 250,
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (_, index) => SizedBox(
                width: 160,
                child: categorySection(
                  image: categories[index].bannerImage ?? AppImage.shirt,
                  category: categories[index].name ?? "N/A",
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _staticBanner({required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(AppImage.homeBanner,
          height: height, fit: BoxFit.cover, width: double.infinity),
    );
  }

  Widget roundCategory({required String images, required String text}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.grey.shade200,
          child: GestureDetector(
            onTap: (){
              Get.to(() => ProductListPage());
            },
            child: ClipOval(
              child: Image.network(images,
                  fit: BoxFit.cover, width: 70, height: 70, errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    images, // ⚠️ make sure this is a valid local asset
                    fit: BoxFit.cover,
                  );
                },),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 12),
          ),
        ),
      ],
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
            const Padding(
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
                  const Spacer(),
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
                      child: const Icon(CupertinoIcons.heart,
                          size: 18, color: Colors.black54),
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

  Widget todaySpecialProducts() {
    return GestureDetector(
      onTap: (){
        Get.to(() => ProductDetailScreen());
      },
      child: Container(
        width: 190,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4))
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
                    Image.asset(AppImage.shirt,
                        height: 150, width: double.infinity, fit: BoxFit.cover),
                    Positioned(
                        bottom: 8,
                        left: 8,
                        child: _colorRatingPill(small: true)),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 4, 10, 0),
              child: Text('Polo',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
              child: Text('Brown T-Shirt',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
              child: Row(
                children: [
                  const Text('Rs.1,100',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: Colors.red)),
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

  Widget categorySection({
    required String image,
    required String category,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.asset(image,
                    fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(category,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget brandLogoSection({
    required String image,
    required String offer,
    required VoidCallback onTap,
  }) {
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
              image: DecorationImage(
                  image: AssetImage(AppImage.brandCategoryBg),
                  fit: BoxFit.contain),
            ),
            child: Positioned.fill(
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    image, // ⚠️ make sure this is a valid local asset
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4)),
              child: Text(offer,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10)),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryWiseCatalog({
    required String image,
    required String brandName,
    required String offer,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 300,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      image, // ⚠️ make sure this is a valid local asset
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration:
                  BoxDecoration(color: AppColors.whitemixture),
                  child: Text(brandName.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, letterSpacing: 2)),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 16,
                child: Text(offer,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topIcons({required String icon, required VoidCallback onIconTap}) {
    return GestureDetector(
      onTap: onIconTap,
      child: SvgPicture.asset(icon, height: 18, width: 18),
    );
  }
}