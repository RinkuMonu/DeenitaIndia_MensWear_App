import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../controller/filterCoontroller.dart';
import '../widgets/customAppBar.dart';
import '../widgets/button.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilterController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Filters",
        showMenu: false,
        showWishlist: false,
        showNotification: true,
      ),

      body: Column(
        children: [
          /// MAIN CONTENT
          Expanded(
            child: Row(
              children: [
                /// LEFT CATEGORY LIST
                Container(
                  width: 120,
                  color:  Colors.grey.shade100,
                  child: Obx(() {
                    final selectedIndex = controller.selectedCategoryIndex.value; // ✅ READ HERE

                    return ListView.builder(
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedIndex == index; // ❌ no Rx here

                        return InkWell(
                          onTap: () => controller.selectCategory(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.yellow_shade
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              controller.categories[index],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                /// RIGHT OPTIONS
                /// RIGHT OPTIONS
                Expanded(
                  child: Obx(() {
                    final category =
                    controller.categories[controller.selectedCategoryIndex.value];

                    final selectedSet = controller.selectedValues[category]!;
                    final list = controller.options[category] ?? [];

                    return Column(
                      children: [
                        // ✅ Wrap ListView in Expanded
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final value = list[index];
                              final isChecked = selectedSet.contains(value);

                              return InkWell(
                                onTap: () => controller.toggleOption(category, value),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        activeColor: AppColors.secondary,
                                        value: isChecked,
                                        onChanged: (_) =>
                                            controller.toggleOption(category, value),
                                      ),
                                      Expanded(
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Bottom bar outside ListView
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: controller.clearAll,
                                child: const Text(
                                  'Clear all',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                height: 40,
                                child: AppButton(
                                  title: 'Apply',
                                  textColor: !controller.hasAnySelection ? Colors.black : Colors.white,
                                  bgColor: !controller.hasAnySelection ? Colors.grey.shade200 : AppColors.secondary,
                                  onTap: controller.hasAnySelection
                                      ? () {
                                    Get.back();
                                  }
                                      : () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}