import 'package:carousel_slider/carousel_slider.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/view/cart.dart';
import 'package:deenitaindia/view/productDetailScreen.dart';
import 'package:deenitaindia/view/wishlistScreen.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controller/product_list_page_controller.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final _controller = Get.put(ProductListPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              style: const TextStyle(fontSize: 12, color: Colors.black),
              onChanged: (value) => print("Search: $value"),
              decoration: InputDecoration(
                hintText: "Search products...",
                hintStyle: const TextStyle(fontSize: 14, color: Colors.black),
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          actions: [
            topIcons(icon: AppImage.fav, onIconTap: () => Get.to(() => WishlistScreen())),
            const SizedBox(width: 8),
            topIcons(icon: AppImage.shoppingBag, onIconTap: () => Get.to(() => CartView())),
          ],
        ),
        bottomNavigationBar: Container(
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            border: const Border(top: BorderSide(color: Colors.grey, width: 0.3)),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2)),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _openCategorySheet(context),
                  child: Obx(() => Center(
                    child: Text(
                      _controller.categoryList[_controller.selectedCategoryIndex.value],
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  )),
                ),
              ),
              Container(width: 1, height: 22, color: Colors.grey.shade400),
              Expanded(
                child: InkWell(
                  onTap: () => _openSortSheet(context),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.swap_vert, size: 18),
                      SizedBox(width: 6),
                      Text("Sort", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              Container(width: 1, height: 22, color: Colors.grey.shade400),
              Expanded(
                child: InkWell(
                  onTap: () => _openFilterSheet(context),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.tune, size: 18),
                      SizedBox(width: 6),
                      Text("Filters", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AppImage.adBanner),
              const SizedBox(height: 12),
              offerImages(data: [
                AppImage.newArrivalImage, AppImage.topRated,
                AppImage.newArrivalImage, AppImage.topRated,
                AppImage.newArrivalImage, AppImage.topRated,
              ]),
              const SizedBox(height: 12),
              _roundCategoryList(),
              _topBannerSection(),
              const SizedBox(height: 20),
              _productsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  // ─── CATEGORY SHEET ──────────────────────────────────────────────────────────

  void _openCategorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,   // ✅ FIX 2: Column stays tight
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Select",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () => Navigator.pop(sheetContext),
                        child: const Icon(Icons.close, size: 20),
                      ),
                    ],
                  ),
                ),

                Container(height: 1, color: Colors.grey.shade300),

                // ✅ FIX 1 & 2: ConstrainedBox bounds the ListView height so
                //   the Column doesn't overflow. Obx reads observables directly
                //   inside the builder so GetX tracks them properly.
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  child: Obx(() {
                    final categories  = _controller.categoryList;
                    final selectedIdx = _controller.selectedCategoryIndex.value;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (_, index) {
                        final isSelected = selectedIdx == index;
                        return InkWell(
                          onTap: () {
                            _controller.selectedCategoryIndex.value = index;
                            Navigator.pop(sheetContext);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  categories[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected ? Colors.black : Colors.grey,
                                  ),
                                ),
                                Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.grey.shade400,
                                    ),
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.check,
                                      size: 16, color: Colors.white)
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── FILTER SHEET ────────────────────────────────────────────────────────────

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          height: Get.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Filters",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    GestureDetector(
                      onTap: () => Navigator.pop(sheetContext),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: Row(
                  children: [

                    // ✅ FIX: Read observable at top of Obx, not inside itemBuilder
                    Obx(() {
                      final selectedTab = _controller.selectedFilterTab.value;
                      final tabs = _controller.filterTabs;

                      return Container(
                        width: 120,
                        color: Colors.grey.shade100,
                        child: ListView.builder(
                          itemCount: tabs.length,
                          itemBuilder: (_, index) {
                            final isSelected = selectedTab == index; // ✅ uses local var
                            return InkWell(
                              onTap: () => _controller.selectedFilterTab.value = index,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 12),
                                color: isSelected
                                    ? Colors.brown.shade100
                                    : Colors.transparent,
                                child: Text(
                                  tabs[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: isSelected ? Colors.black : Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),

                    // ✅ FIX: Use a dedicated RxList from the controller so
                    //    GetX can track add/remove and rebuild checkboxes
                    Expanded(
                      child: Obx(() {
                        final currentTab =
                        _controller.filterTabs[_controller.selectedFilterTab.value];
                        final options = _controller.categoryOptions;

                        // ✅ Always get the RxList from the controller map
                        final selectedList = _controller.getOrCreateFilterList(currentTab);

                        return ListView.builder(
                          itemCount: options.length,
                          itemBuilder: (_, index) {
                            final option = options[index];
                            final isSelected = selectedList.contains(option); // ✅ reactive
                            return InkWell(
                              onTap: () {
                                if (isSelected) {
                                  selectedList.remove(option);
                                } else {
                                  selectedList.add(option);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(option,
                                        style: TextStyle(
                                            color: isSelected
                                                ? Colors.black
                                                : Colors.grey)),
                                    Container(
                                      height: 22,
                                      width: 22,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: isSelected
                                                ? Colors.black
                                                : Colors.grey),
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.transparent,
                                      ),
                                      child: isSelected
                                          ? const Icon(Icons.check,
                                          size: 16, color: Colors.white)
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  children: [
                    const Text("1000+ Products",
                        style: TextStyle(color: Colors.grey)),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                      ),
                      onPressed: () => Navigator.pop(sheetContext),
                      child: const Text("Apply", style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ─── SORT SHEET ──────────────────────────────────────────────────────────────

  void _openSortSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,   // ✅ keeps Column tight
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Sort",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () => Navigator.pop(sheetContext),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // ✅ Same fix as category sheet
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  child: Obx(() {
                    final sortList    = _controller.sortList;
                    final selectedIdx = _controller.selectedSortIndex.value;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: sortList.length,
                      itemBuilder: (_, index) {
                        final isSelected = selectedIdx == index;
                        return InkWell(
                          onTap: () {
                            _controller.selectedSortIndex.value = index;
                            Navigator.pop(sheetContext);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  sortList[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: isSelected ? Colors.black : Colors.grey,
                                  ),
                                ),
                                Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.grey),
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.check,
                                      size: 16, color: Colors.white)
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── BANNER ──────────────────────────────────────────────────────────────────

  Widget _topBannerSection() {
    return Obx(() {
      final banners = _controller.topBanner;
      return Column(
        children: [
          SizedBox(
            height: 160,
            child: banners.isEmpty
                ? _staticBanner(height: 160)
                : CarouselSlider.builder(
              itemCount: banners.length,
              itemBuilder: (context, index, realIndex) {
                final isActive =
                    _controller.currentBannerIndex.value == index;
                return AnimatedScale(
                  scale: isActive ? 1 : 0.95,
                  duration: const Duration(milliseconds: 300),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(banners[index],
                            fit: BoxFit.cover, width: double.infinity),
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 160,
                viewportFraction: 0.95,
                enlargeCenterPage: true,
                enlargeFactor: 0.15,
                padEnds: true,
                enableInfiniteScroll: banners.length > 1,
                autoPlay: banners.length > 1 &&
                    (ModalRoute.of(context)?.isCurrent ?? false),
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration:
                const Duration(milliseconds: 600),
                autoPlayCurve: Curves.easeOut,
                scrollPhysics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                onPageChanged: (index, _) =>
                _controller.currentBannerIndex.value = index,
              ),
            ),
          ),
          if (banners.isNotEmpty)
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
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
                ),
              );
            }),
        ],
      );
    });
  }

  Widget _staticBanner({required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(AppImage.homeBanner,
          height: height, fit: BoxFit.cover, width: double.infinity),
    );
  }

  // ─── OTHER WIDGETS ───────────────────────────────────────────────────────────

  Widget offerImages({required List<String> data}) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Image.asset(data[index],
              height: 40, width: 50, fit: BoxFit.contain),
        ),
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
              images: categories[index].image,
              text: categories[index].offer,
            ),
          ),
        ),
      );
    });
  }

  Widget roundCategory({required String images, required String text}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.grey.shade200,
          child: ClipOval(
            child: Image.asset(images, fit: BoxFit.cover, width: 70, height: 70),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _productsGrid() {
    return GridView.builder(
      itemCount: 22,
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
                    Positioned(bottom: 8, left: 8, child: _colorRatingPill()),
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

  Widget _colorRatingPill({bool small = false}) {
    final size = small ? 10.0 : 12.0;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: small ? 6 : 8, vertical: small ? 3 : 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.88),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6)
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
                    color: Colors.black26, fontSize: small ? 11 : 13)),
          ),
          Icon(Icons.star_rounded, color: Colors.amber, size: small ? 12 : 14),
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

  Widget topIcons({required String icon, required VoidCallback onIconTap}) {
    return GestureDetector(
      onTap: onIconTap,
      child: SvgPicture.asset(icon, height: 20, width: 20),
    );
  }
}