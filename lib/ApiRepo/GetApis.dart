import 'dart:convert';
import 'dart:developer';
import 'package:deenitaindia/models/brand_list_model.dart';
import 'package:deenitaindia/models/subCategory_model.dart';

import '../service/apiService.dart';
import '../utils/api_url.dart';
import '../utils/logger.dart';
import '../widgets/toast.dart';

class GetApiRepo {
  // ✅ Uses singleton Apiservices — no new instance created
  final Apiservices _api = Apiservices();

  // =====================================================
  // 🔧 GENERIC SAFE GET — Eliminates repetitive try/catch
  // Every method reuses this instead of copy-pasting error handling
  // =====================================================
  Future<T?> _safeGet<T>({
    required String endpoint,
    required T Function(dynamic data) parser,
    Map<String, dynamic>? queryParams,
    String errorMessage = "Something went wrong. Please try again.",
    bool acceptCreated = false, // true = also accept 201
  }) async {
    try {
      final response = await _api.getRequest(
          endpoint, queryParams: queryParams);
      final code = response.statusCode;
      final isSuccess = code == 200 || (acceptCreated && code == 201);

      logDebug('[$endpoint] Status: $code');

      if (isSuccess && response.data != null) {
        logDebug('[$endpoint] Data: ${response.data}');
        return parser(response.data);
      }

      // ✅ Show actual API message if available
      final apiMessage = _extractMessage(response.data) ?? errorMessage;
      logError('[$endpoint] Failed: $apiMessage');
      showSnackBar(title: "Failed", message: apiMessage);
      return null;
    } catch (e, stackTrace) {
      logError('[$endpoint] Exception: $e');
      logError('StackTrace: $stackTrace');
      showSnackBar(title: "Error", message: errorMessage);
      return null;
    }
  }

  // =====================================================
  // 🔧 EXTRACT API MESSAGE — Reads all common message keys
  // =====================================================
  String? _extractMessage(dynamic data) {
    if (data is Map) {
      return data['message'] ?? data['error'] ?? data['msg'] ?? data['detail'];
    }
    if (data is String && data
        .trim()
        .isNotEmpty) return data.trim();
    return null;
  }

// =====================================================
// 🔹 ALL API METHODS — Clean, no boilerplate
// =====================================================

  Future<BrandListModel?> fetchBrands({int page = 1, int limit = 10}) => _safeGet(
    endpoint: "${ApiUrl.getBrand}?page=$page&limit=$limit",
    parser: (data) => BrandListModel.fromJson(data),
    errorMessage: "Unable to fetch loans. Please try again later.",
  );

  Future<SubCategoryModel?> fetchSubCategory({int page = 1, int limit = 10}) => _safeGet(
    endpoint: "${ApiUrl.getSubcategory}?page=$page&limit=$limit",
    parser: (data) => SubCategoryModel.fromJson(data),
    errorMessage: "Unable to fetch loans. Please try again later.",
  );
}