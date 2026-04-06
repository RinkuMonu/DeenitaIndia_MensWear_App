import 'package:deenitaindia/constants/textstyle.dart';
import 'package:deenitaindia/view/product_list_page.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/image.dart';
import '../controller/searchC.dart';
import '../widgets/textfield.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final controller = Get.put(SearchC());

  final List<String> recentList = [
    'Jeans',
    'Casual clothes',
    'V-neck tshirt',
    'Winter clothes',
  ];

  // ── Mock search results (replace with your API data) ───
  final List<Map<String, String>> searchResults = [
    {'image': AppImage.shirt, 'name': 'Polo', 'subtitle': 'BROWN T-SHIRT'},
    {'image': AppImage.shirt, 'name': 'Polo', 'subtitle': 'BROWN T-SHIRT'},
    {'image': AppImage.shirt, 'name': 'Polo', 'subtitle': 'BROWN T-SHIRT'},
  ];

  @override
  void initState() {
    super.initState();
    // ── Listen to text changes ──────────────────────────
    controller.searchController.addListener(() {
      controller.searchQuery.value = controller.searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Search",
        showNotification: true,
        showWishlist: true,
        showMenu: false,
        appBarBgColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Search Field ──────────────────────────────
            // ── Search Field + Listening Banner ──────────────────────
            Column(
              children: [
                CommonTextField2(
                  controller: controller.searchController,
                  readOnly: false,
                  showCursor: true,
                  hint: 'Search for clothes...',
                  preffix: SvgPicture.asset(AppImage.search, height: 28, width: 28),

                  // ── Single clean suffix ─────────────────────────
                  suffix: Obx(() {
                    // Show X when typing
                    if (controller.searchQuery.value.isNotEmpty) {
                      return IconButton(
                        onPressed: () {
                          controller.searchController.clear();
                          controller.searchQuery.value = '';
                        },
                        icon: const Icon(Icons.close, color: Colors.grey),
                      );
                    }

                    // Show mic when idle or listening
                    return GestureDetector(
                      onTap: () => controller.toggleListening(),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: controller.isListening.value
                              ? Colors.red.shade50
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          controller.isListening.value
                              ? Icons.mic
                              : Icons.mic_none,
                          color: controller.isListening.value
                              ? Colors.red
                              : Colors.grey,
                          size: 24,
                        ),
                      ),
                    );
                  }),
                ),

                // ── Listening Banner (OUTSIDE suffix, INSIDE Column) ─
                Obx(() {
                  if (!controller.isListening.value) return const SizedBox.shrink();

                  return Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        // ── Pulsing dot ─────────────────────────────
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.5, end: 1.0),
                          duration: const Duration(milliseconds: 600),
                          builder: (_, value, __) => Opacity(
                            opacity: value,
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Listening...',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => controller.toggleListening(),
                          child: const Text(
                            'Stop',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),

            const SizedBox(height: 10),

            // ── 3 States ──────────────────────────────────
            Expanded(
              child: Obx(() {
                final query = controller.searchQuery.value.trim();

                // ── STATE 1: Empty query → Recent Searches ──
                if (query.isEmpty) {
                  return _recentSearchesSection();
                }

                // ── STATE 2: Has results ────────────────────
                if (searchResults.isNotEmpty) {
                  return _searchResultsList();
                }

                // ── STATE 3: No results found ───────────────
                return _noResultsFound();
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════
  // STATE 1 — Recent Searches
  // ════════════════════════════════════════════════════

  Widget _recentSearchesSection() {
    return Obx(() {
      if (!controller.recentSearch.value) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: () => controller.recentSearch.value = false,
                child: const Text(
                  'Clear all',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Recent List ────────────────────────────────
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.searchController.text = recentList[index];
                      controller.searchQuery.value = recentList[index];
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          recentList[index],
                          style: AppTextStyles.alexandria16w300Black,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => recentList.removeAt(index));
                          },
                          child: const Icon(
                            CupertinoIcons.xmark_circle,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Divider(color: Colors.grey.shade300),
                  ),
                ],
              );
            },
          ),
        ],
      );
    });
  }

  // ════════════════════════════════════════════════════
  // STATE 2 — Search Results
  // ════════════════════════════════════════════════════

  Widget _searchResultsList() {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final item = searchResults[index];
        return Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(()=> ProductListPage());
                },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    // ── Product Thumbnail ───────────────────
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item['image']!,
                        height: 56,
                        width: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // ── Product Info ────────────────────────
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['subtitle']!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Arrow Icon ──────────────────────────
                    const Icon(
                      Icons.arrow_outward,
                      size: 18,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey.shade200),
          ],
        );
      },
    );
  }

  // ════════════════════════════════════════════════════
  // STATE 3 — No Results Found
  // ════════════════════════════════════════════════════

  Widget _noResultsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ── Search with minus icon ──────────────────────
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 1.5),
            ),
            child: Icon(
              CupertinoIcons.minus,
              color: Colors.grey.shade400,
              size: 24,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Oops! No results found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'try a different keyword',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}