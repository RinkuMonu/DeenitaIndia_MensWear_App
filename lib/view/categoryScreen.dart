import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        showWishlist: false,
        showNotification: true,
        showMenu: false,
        title: "Category",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            /// 🔍 Search Bar
            CommonTextField2(
              controller: controller.searchController,
              readOnly: false,
              showCursor: false,
              hint: 'Search for clothes...',
              preffix: SvgPicture.asset(
                AppImage.search,
                height: 24,
                width: 24,
              ),
            ),

            const SizedBox(height: 20),

            /// 🧥 Men’s Wear Categories
            Obx(() {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.categoryItem.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (context, index) {
                  final item = controller.categoryItem[index];
                  return categoryItem(
                    image: item.icon,
                    text: item.title,
                    onTap: () {
                      Get.to(() => CategoryView(title: item.title,));
                    },
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  /// 📦 Category Item Widget
  Widget categoryItem({
    required String image,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // ✅ full width
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 3 / 4, // ✅ tall category image
              child: Image.network(
                image,
                fit: BoxFit.cover, // ✅ fills space
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}