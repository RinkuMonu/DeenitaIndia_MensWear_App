import 'package:get/get.dart';

class FilterController extends GetxController {
  /// Left panel selected category index
  RxInt selectedCategoryIndex = 0.obs;

  /// Categories
  final List<String> categories = [
    'Price',
    'Colors',
    'Discount',
    'Size',
    'Type',
    'Review',
    'Fabric',
    'Sort by',
    'Availability',
    'Sleeve',
    'Occasion',
  ];

  /// Options per category
  final Map<String, List<String>> options = {
    'Price': [
      'Under ₹500',
      '₹500 - ₹1,000',
      '₹1,000 - ₹1,500',
      '₹1,500 - ₹2,000',
      'Above ₹2,000',
    ],
    'Colors': ['Black', 'White', 'Blue', 'Red'],
    'Discount': ['10%+', '20%+', '30%+', '50%+'],
  };

  /// Selected values - changed to RxMap with regular Set
  final RxMap<String, Set<String>> selectedValues = <String, Set<String>>{}.obs;

  @override
  void onInit() {
    super.onInit();

    for (var key in options.keys) {
      selectedValues[key] = <String>{};
    }
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void toggleOption(String category, String value) {
    final set = selectedValues[category]!;
    if (set.contains(value)) {
      set.remove(value);
    } else {
      set.add(value);
    }

    // 🔥 FORCE UI UPDATE by reassigning the map
    selectedValues.refresh();
  }

  bool isSelected(String category, String value) {
    return selectedValues[category]!.contains(value);
  }

  void clearAll() {
    for (var set in selectedValues.values) {
      set.clear();
    }
    selectedValues.refresh();
  }

  bool get hasAnySelection =>
      selectedValues.values.any((set) => set.isNotEmpty);
}