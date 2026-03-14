import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide MultipartFile, FormData, Response;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api_url.dart';
import '../view/auth/login.dart';
import '../widgets/toast.dart';
import 'local_storage.dart';

class Apiservices {
  late Dio _dio;

  Apiservices() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      connectTimeout: const Duration(seconds: 150),
      receiveTimeout: const Duration(seconds: 150),
      sendTimeout: const Duration(seconds: 150),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      validateStatus: (status) {
        // Accept all status codes below 500
        return status != null && status < 500;
      },
    );

    _dio = Dio(options);

    _dio.interceptors.add(
      InterceptorsWrapper(

        /// ================= REQUEST =================
        onRequest: (options, handler) async {
          print("➡️ ${options.method} | ${options.uri}");

          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },

        /// ================= RESPONSE =================
        onResponse: (response, handler) async {
          print("✅ Response: ${response.statusCode} | ${response.data}");

          // 🔥 FIX: HANDLE FORCE LOGOUT HERE (because 401 is SUCCESS)
          if (response.statusCode == 401) {
            final data = response.data;

            if (data is Map && data['code'] == "FORCE_LOGOUT") {
              await _forceLogout(
                message: data['message'] ??
                    "Session expired. Please login again.",
              );
              return; // ⛔ stop further processing
            }
          }

          handler.next(response);
        },

        /// ================= ERROR =================
        onError: (DioException e, handler) async {
          print("❌ Error: ${e.message}");

          // 🔹 This will handle REAL network errors only
          if (e.response?.statusCode == 401) {
            await _handleTokenExpiration();
          }

          handler.next(e);
        },
      ),
    );
  }

  // =====================================================
  // 🔐 FORCE LOGOUT (ADDED, DOES NOT REMOVE ANY FEATURE)
  // =====================================================
  static bool _isLoggingOut = false;

  Future<void> _forceLogout({String? message}) async {
    if (_isLoggingOut) return; // prevent double navigation
    _isLoggingOut = true;

    await LocalStorage.clear();

    if (message != null && message.isNotEmpty) {
      showSnackBar(
        title: "Session Expired",
        message: message, context: Get.context!, error: '',
      );
    }

    Get.offAll(() => const Login());
  }

  // =====================================================
  // 🔹 Handle Token Expiration (UNCHANGED)
  // =====================================================
  Future<void> _handleTokenExpiration() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.clear();

      showSnackBar(
        title: "Session Expired",
        message: "Your session has expired. Please login again.",
        context: Get.context!, error: '',
      );

      Get.offAll(() => Login());
    } catch (e) {
      print("Error handling token expiration: $e");
    }
  }

  // =====================================================
  // 🔹 HTTP METHODS (UNCHANGED)
  // =====================================================
  Future<Response> getRequest(
      String endpoint, {
        Map<String, dynamic>? queryParams,
      }) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParams);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> postRequest(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParams,
      }) async {
    try {
      return await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParams,
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> putRequest(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> deleteRequest(String endpoint, {dynamic data}) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> patchRequest(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParams,
      }) async {
    try {
      return await _dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParams,
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> uploadMultipleFiles(
      String endpoint, {
        Map<String, File>? fileMap,
        required List<File> files,
        String fieldName = "files",
        Map<String, dynamic>? data,
      }) async {
    try {
      List<MultipartFile> multipartFiles = [];

      for (var file in files) {
        String fileName = file.path.split("/").last;
        multipartFiles.add(
          await MultipartFile.fromFile(file.path, filename: fileName),
        );
      }

      FormData formData = FormData.fromMap({
        fieldName: multipartFiles,
        ...?data,
      });

      if (fileMap != null && fileMap.isNotEmpty) {
        for (var entry in fileMap.entries) {
          formData.files.add(
            MapEntry(
              entry.key,
              await MultipartFile.fromFile(
                entry.value.path,
                filename: entry.value.path.split('/').last,
              ),
            ),
          );
        }
      }

      return await _dio.post(
        endpoint,
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // =====================================================
  // 📛 Centralized Error Handling (UNCHANGED)
  // =====================================================

  String? _handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    print("📛 Dio Error Handler => Status: $statusCode | Data: $data");

    // Extract message from API response or fallback to default
    String getMessage(String defaultMessage) {
      if (data is Map) {
        return data['message'] ?? data['error'] ?? defaultMessage;
      }
      return defaultMessage;
    }

    // Handle 401 - Unauthorized
    if (statusCode == 401) {
      LocalStorage.clear();
      Get.offAll(() => Login());
      showSnackBar(
        title: "Session Expired",
        message: getMessage("Please login again."), context: Get.context!, error: Get.context!,
      );
      return getMessage("Unauthorized");
    }

    // Handle 400 - Bad Request
    if (statusCode == 400) {
      String message = getMessage("Invalid request.");
      showSnackBar(title: "Error", message: message, context: Get.context!, error: Get.context);
      return message;
    }

    // Handle 403 - Forbidden
    if (statusCode == 403) {
      String message = getMessage("You don't have permission to perform this action.");
      showSnackBar(title: "Access Denied", message: message, context: Get.context!, error: Get.context);
      return message;
    }

    // Handle 404 - Not Found
    if (statusCode == 404) {
      String message = getMessage("Resource not found.");
      showSnackBar(title: "Not Found", message: message, context: Get.context!, error: Get.context!);
      return message;
    }

    // Handle 422 - Validation Error
    if (statusCode == 422) {
      String message = getMessage("Validation failed.");
      showSnackBar(title: "Validation Error", message: message, context: Get.context!, error: Get.context);
      return message;
    }

    // Handle 500+ - Server Errors
    if (statusCode != null && statusCode >= 500) {
      String message = getMessage("Server error. Please try again later.");
      showSnackBar(title: "Server Error", message: message, context: Get.context!, error: Get.context!);
      return message;
    }

    // Handle Timeout Errors
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      showSnackBar(
          title: "Timeout",
          message: "Request timed out. Please try again.", context: Get.context!, error: Get.context!
      );
      return "Request Timeout";
    }

    // Handle Connection Errors
    if (error.type == DioExceptionType.connectionError) {
      showSnackBar(
          title: "Network Error",
          message: "No internet connection. Please check your network.", context: Get.context!, error: Get.context!
      );
      return "No Internet Connection";
    }

    // Handle Cancelled Requests
    if (error.type == DioExceptionType.cancel) {
      showSnackBar(
          title: "Cancelled",
          message: "Request was cancelled.", context: Get.context!, error: Get.context!
      );
      return "Request Cancelled";
    }

    // Default error handling
    String message = getMessage("Something went wrong. Please try again.");
    showSnackBar(title: "Error", message: message, context: Get.context!, error: Get.context!);
    return message;
  }}