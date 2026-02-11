import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Category {
  final String icon;
  final String title;

  const Category({
    required this.icon,
    required this.title,
  });
}

class CategoryController extends GetxController {
  final searchController = TextEditingController();

  /// Master list (never changes)
  final List<Category> _allCategories = [];

  /// UI list (changes with search)
  final RxList<Category> categoryItem = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMensWearCategories();

    /// 🔍 Listen to search input
    searchController.addListener(_onSearchChanged);
  }

  void _loadMensWearCategories() {
    _allCategories.addAll([
      const Category(
        title: 'Shirts',
        icon:
        'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=400',
      ),
      const Category(
        title: 'Jeans',
        icon:
        'https://images.unsplash.com/photo-1542272604-787c3835535d?w=400',
      ),
      const Category(
        title: 'T-Shirts',
        icon:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
      ),
      const Category(
        title: 'Hoodies',
        icon:
        'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=400',
      ),
      const Category(
        title: 'Jackets',
        icon:
        'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=400',
      ),
    ]);

    /// show all initially
    categoryItem.assignAll(_allCategories);
  }

  void _onSearchChanged() {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      categoryItem.assignAll(_allCategories);
    } else {
      categoryItem.assignAll(
        _allCategories.where(
              (item) => item.title.toLowerCase().contains(query),
        ),
      );
    }
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.onClose();
  }
}