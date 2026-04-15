import 'package:deenitaindia/controller/faq_controller.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {

  final controller = Get.put(FaqController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "FAQs",
        showNotification: true,
        showWishlist: false,
        showMenu: false,
        appBarBgColor: Colors.white,
      ),
      body: Column(
        children: [

          /// 🔹 Category Tabs
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {

                return Obx(() {
                  final isSelected =
                      controller.selectedCategory.value == index;

                  return GestureDetector(
                    onTap: () {
                      controller.selectedCategory.value = index;
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.black
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        controller.categories[index],
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),

          const SizedBox(height: 10),

          /// 🔹 FAQ LIST (NO Obx here ❗)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.faqs.length,
              itemBuilder: (context, index) {
                return _faqItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 FAQ ITEM (ONLY Obx here ✅)
  Widget _faqItem(int index) {
    return Obx(() {
      final isExpanded =
          controller.expandedIndex.value == index;
      final faq = controller.faqs[index];

      return GestureDetector(
        onTap: () => controller.toggleExpand(index),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔹 Question Row
              Row(
                children: [
                  Expanded(
                    child: Text(
                      faq['question']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration:
                    const Duration(milliseconds: 200),
                    child:
                    const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),

              /// 🔹 Answer
              if (isExpanded) ...[
                const SizedBox(height: 10),
                Text(
                  faq['answer']!,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}