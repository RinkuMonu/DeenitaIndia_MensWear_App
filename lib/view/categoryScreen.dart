import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/image.dart';
import '../controller/categoryController.dart';
import '../widgets/textfield.dart';
import 'categoryView.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final controller = Get.put(CategoryController());
  final List<String> categoryTabs = ['Men', 'Women', 'Kids'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        showWishlist: true,
        showNotification: true,
        showMenu: false,
        title: "Category",
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 Search Bar
            Column(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 12.0),
                  child: CommonTextField2(
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
            _CategoryTab(),


            Expanded(
              child: Obx(() {
                if (controller.searchQuery.isEmpty) {
                  return Column(
                    children: [

                      categoryFilterButton(),

                      Expanded(
                        child: Row(
                          children: [
                            _leftCategoryList(),
                            _rightCategoryContent(),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                // 🔍 Search Result View
                return Column(
                  children: [
                    SizedBox(height: 20,),
                    _rightCategoryContent(),
                  ],
                );
              }),
            )


          ],
        ),
      ),
    );
  }


  Widget categoryFilterButton() {
    return  Container(height: 40,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.textList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (_, index) => Obx(() {
          final isSelected = controller.selectedsubCategoryIndex .value == index;
          return InkWell(
            onTap: () => controller.selectedsubCategoryIndex .value = index,
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
                controller.textList[index],
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
    );
  }

  Widget _CategoryTab() {
    return Obx(() {
      final selectedIndex = controller.selectedCategoryIndex.value;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          height: 44,

          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: List.generate(categoryTabs.length, (index) {
              final isSelected = selectedIndex == index;
              final tabColor = controller.categoryTabColors[index];

              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectedCategoryIndex.value = index,
                  child: AnimatedContainer(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? tabColor['bg']
                          : tabColor['unselectedBg'],

                    ),
                    alignment: Alignment.center,
                    child: Text(
                      categoryTabs[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.black : Colors.black54,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      );
    });
  }

  Widget _rightCategoryContent() {
    return Expanded(
      child: Obx(() {
        final isSearching = controller.searchQuery.value.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ❌ Hide divider when searching
            if (!isSearching)
              Divider(height: 1, color: Colors.grey.shade200),

            // ❌ Hide title when searching
            if (!isSearching)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  controller.leftCategories[
                  controller.selectedLeftIndex.value]['title']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            // ✅ Grid always visible
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: controller.rightItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (_, index) {
                  final item = controller.rightItems[index];

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(item['image']!),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _leftCategoryList() {
    return Container(
      width: 100,
      color: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: controller.leftCategories.length,
        itemBuilder: (_, index) {
          return Obx(() {
            final isSelected =
                controller.selectedLeftIndex.value == index;

            return GestureDetector(
              onTap: () => controller.selectedLeftIndex.value = index,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.yellow_shade : Colors.transparent,
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,

                    )
                  )
                ),

                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                      AssetImage(controller.leftCategories[index]['image']!),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      controller.leftCategories[index]['title']!,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

}