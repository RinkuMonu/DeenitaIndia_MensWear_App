import 'package:get/get.dart';

import '../constants/image.dart';
import 'homeC.dart';

class ProductListPageController extends GetxController {

  RxList<BrandsCategory> category = <BrandsCategory>[].obs;
  RxList<String> topBanner = <String>[].obs;
  RxInt currentBannerIndex = 0.obs;

  RxInt selectedCategoryIndex = 0.obs;

  List<String> categoryList = [
    "Men",
    "Women",
    "Girl",
    "Boy",
    "Infant"
  ];

  RxInt selectedSortIndex = 0.obs;

  List<String> sortList = [
    "Relevance",
    "Price (High to Low)",
    "Price (Low to High)",
    "Discount",
    "Ratings"
  ];

  // ─── Filter ───────────────────────────────────────────────────────────────

  RxInt selectedFilterTab = 0.obs;

  List<String> filterTabs = [
    "Category",
    "Brand",
    "Colors",
    "Fabric",
    "Size",
    "Price",
    "Rating",
    "Combo",
    "Discount",
    "Sleeve",
    "Occasion"
  ];

  List<String> categoryOptions = [
    "Casual",
    "Formal",
    "Slim Fit",
    "Regular Fit",
    "Checked",
    "Printed",
    "Solid",
    "Denim",
    "Linen",
    "Cotton"
  ];

  // ✅ Single RxMap — removed the old plain Map<String, RxList<String>>
  final RxMap<String, RxList<String>> selectedFilters =
      <String, RxList<String>>{}.obs;

  // ✅ Always returns the same RxList instance for a given tab
  RxList<String> getOrCreateFilterList(String tab) {
    if (!selectedFilters.containsKey(tab)) {
      selectedFilters[tab] = <String>[].obs;
    }
    return selectedFilters[tab]!;
  }

  @override
  void onInit() {
    super.onInit();
    category.addAll([
      BrandsCategory(image: AppImage.shirt,  offer: "Shirt"),
      BrandsCategory(image: AppImage.tshirt, offer: "T-Shirt"),
      BrandsCategory(image: AppImage.shirt,  offer: "Shirt"),
      BrandsCategory(image: AppImage.tshirt, offer: "T-Shirt"),
      BrandsCategory(image: AppImage.shirt,  offer: "Shirt"),
      BrandsCategory(image: AppImage.tshirt, offer: "T-Shirt"),
    ]);

    topBanner.addAll([
      AppImage.homeBanner,
      AppImage.homeBanner2,
      AppImage.homeBanner,
      AppImage.homeBanner2,
    ]);
  }
}