import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile, FormData, Response;
import 'package:shared_preferences/shared_preferences.dart';


import '../utils/api_url.dart';
import '../view/auth/login.dart';
import '../widgets/toast.dart';
import 'local_storage.dart';

class Apiservices {
  late Dio _dio;

  static String? _cachedToken;
  static bool _isLoggingOut = false;

  Apiservices() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiUrl.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        // ─── REQUEST ────────────────────────────────────────────────────────────
        onRequest: (options, handler) async {
          _cachedToken ??= await _readTokenFromDisk();

          if (_cachedToken != null && _cachedToken!.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $_cachedToken';
          }

          // ⏱️ Stamp the start time onto the request extras
          options.extra['requestStartTime'] = DateTime.now().millisecondsSinceEpoch;

          handler.next(options);
        },

        // ─── RESPONSE ───────────────────────────────────────────────────────────
        onResponse: (response, handler) async {
          // ⏱️ Print response time
          final startTime = response.requestOptions.extra['requestStartTime'] as int?;
          if (startTime != null) {
            final elapsed = DateTime.now().millisecondsSinceEpoch - startTime;
            print("⏱️ [${response.statusCode}] ${response.requestOptions.method} "
                "${response.requestOptions.path} — ${elapsed}ms");
          }

          if (response.statusCode == 401) {
            final data = response.data;
            if (data is Map && data['code'] == "FORCE_LOGOUT") {
              await _logout(message: data['message'] ?? "Session expired. Please login again.");
              return;
            }
          }

          handler.next(response);
        },

        // ─── ERROR ──────────────────────────────────────────────────────────────
        onError: (DioException e, handler) async {
          // ⏱️ Print response time even on errors
          final startTime = e.requestOptions.extra['requestStartTime'] as int?;
          if (startTime != null) {
            final elapsed = DateTime.now().millisecondsSinceEpoch - startTime;
            print("⏱️ [ERROR ${e.response?.statusCode ?? e.type.name}] "
                "${e.requestOptions.method} ${e.requestOptions.path} — ${elapsed}ms");
          }

          if (e.response?.statusCode == 401) {
            await _logout(message: "Your session has expired. Please login again.");
          }
          handler.next(e);
        },
      ),
    );
  }

  // ============================================================
  // 🔑 Token helpers
  // ============================================================

  static Future<String?> _readTokenFromDisk() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static void updateCachedToken(String? token) => _cachedToken = token;

  // ============================================================
  // 🚪 Unified logout
  // ============================================================
  Future<void> _logout({String? message}) async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;

    _cachedToken = null;
    await LocalStorage.clear();

    if (message != null && message.isNotEmpty) {
      showSnackBar(title: "Session Expired", message: message);
    }

    Get.offAll(() => Login());
  }

  // ============================================================
  // 🌐 HTTP methods
  // ============================================================

  Future<Response> getRequest(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParams);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> postRequest(String endpoint, {dynamic data, Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.post(endpoint, data: data, queryParameters: queryParams);
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

  Future<Response> patchRequest(String endpoint, {dynamic data, Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.patch(endpoint, data: data, queryParameters: queryParams);
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
      final multipartFiles = await Future.wait(
        files.map((file) => MultipartFile.fromFile(file.path, filename: file.path.split("/").last)),
      );

      final formData = FormData.fromMap({fieldName: multipartFiles, ...?data});

      if (fileMap != null && fileMap.isNotEmpty) {
        await Future.wait(
          fileMap.entries.map((entry) async {
            formData.files.add(MapEntry(
              entry.key,
              await MultipartFile.fromFile(entry.value.path, filename: entry.value.path.split('/').last),
            ));
          }),
        );
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

  // ============================================================
  // 📛 Centralized error handling
  // ============================================================
  String? _handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    String getMessage(String fallback) =>
        data is Map ? (data['message'] ?? data['error'] ?? fallback) : fallback;

    switch (statusCode) {
      case 401:
        LocalStorage.clear();
        _cachedToken = null;
        Get.offAll(() => Login());
        showSnackBar(title: "Session Expired", message: getMessage("Please login again."));
        return getMessage("Unauthorized");

      case 400:
        final msg = getMessage("Invalid request.");
        showSnackBar(title: "Error", message: msg);
        return msg;

      case 403:
        final msg = getMessage("You don't have permission to perform this action.");
        showSnackBar(title: "Access Denied", message: msg);
        return msg;

      case 404:
        final msg = getMessage("Resource not found.");
        showSnackBar(title: "Not Found", message: msg);
        return msg;

      case 422:
        final msg = getMessage("Validation failed.");
        showSnackBar(title: "Validation Error", message: msg, );
        return msg;
    }

    if (statusCode != null && statusCode >= 500) {
      final msg = getMessage("Server error. Please try again later.");
      showSnackBar(title: "Server Error", message: msg);
      return msg;
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        showSnackBar(title: "Timeout", message: "Request timed out. Please try again.");
        return "Request Timeout";

      case DioExceptionType.connectionError:
        showSnackBar(title: "Network Error", message: "No internet connection. Please check your network.");
        return "No Internet Connection";

      case DioExceptionType.cancel:
        showSnackBar(title: "Cancelled", message: "Request was cancelled.");
        return "Request Cancelled";

      default:
        final msg = getMessage("Something went wrong. Please try again.");
        showSnackBar(title: "Error", message: msg);
        return msg;
    }
  }
}