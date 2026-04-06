import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../constants/colors.dart';
import '../constants/image.dart';
import '../controller/allBrandScreenController.dart';
import '../widgets/textfield.dart';

class AllBrandsPage extends StatefulWidget {
  const AllBrandsPage({super.key});

  @override
  State<AllBrandsPage> createState() => _AllBrandsPageState();
}

class _AllBrandsPageState extends State<AllBrandsPage> {

  final controller = Get.put(AllBrandScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        showWishlist: true,
        showNotification: true,
        showMenu: false,
        title: "Brand List",
      ),

      body: SingleChildScrollView(
        child: Column(
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


            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),

              child: GridView.builder(
                itemCount: controller.brands.length,
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
                  image: controller.brands[index].image,
                  offer: controller.brands[index].offer,
                  onTap: () {},
                ),
              ),
            ),
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
            child: Image.asset(image, fit: BoxFit.contain, height: 40),
          ),
          if(offer.isNotEmpty)...[
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
          ]else...[
            SizedBox.shrink()
          ]

        ],
      ),
    );
  }

}
