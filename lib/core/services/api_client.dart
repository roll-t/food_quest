import 'dart:developer';
import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:food_quest/core/config/result.dart';
import 'package:food_quest/core/local_storage/app_get_storage.dart';
import 'package:food_quest/core/services/api_intercepter.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'internet_service.dart'; // import service check mạng

class ApiClient extends GetxService {
  late final Dio _dio;
  final InternetService _internetService = Get.find<InternetService>();
  final String baseUrl = dotenv.env["API_URL"] ?? "https://";

  @override
  void onInit() {
    super.onInit();
    _initDio();
  }

  Dio get client => _dio;

  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        validateStatus: (_) => true,
      ),
    )
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = AppGetStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            log('[ApiClient] 🟢 Attached token: $token');
          } else {
            log('[ApiClient] 🔴 No token found, sending request without auth');
          }
          handler.next(options);
        },
      ))
      ..interceptors.add(ApiInterceptor());

    log('[ApiClient] ✅ Dio initialized');
  }

  /// --- HTTP REQUESTS ---
  Future<Result<dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    if (!_internetService.isConnected.value) {
      return Result(
          status: Results.error, message: 'Không có kết nối internet');
    }

    try {
      final response = await _dio.get(path, queryParameters: query);
      return _handleResponse(response);
    } on DioException catch (e) {
      return Result(status: Results.error, message: _handleError(e));
    }
  }

  Future<Result<dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    if (!_internetService.isConnected.value) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        title: "Lỗi kết nối internet",
        confirmText: "Thử lại",
      );
      return Result(
        status: Results.error,
        message: 'Không có kết nối internet',
      );
    }

    try {
      final response = await _dio.post(path, data: data);
      print("Chạy vào đây");
      return _handleResponse(response);
    } on DioException catch (e) {
      return Result(
        status: Results.error,
        message: _handleError(e),
      );
    }
  }

  Future<Result<dynamic>> patch(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    if (!_internetService.isConnected.value) {
      return Result(
          status: Results.error, message: 'Không có kết nối internet');
    }

    try {
      final response = await _dio.patch(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      return Result(status: Results.error, message: _handleError(e));
    }
  }

  Future<Result<dynamic>> put(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    if (!_internetService.isConnected.value) {
      return Result(
          status: Results.error, message: 'Không có kết nối internet');
    }

    try {
      final response = await _dio.put(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      return Result(status: Results.error, message: _handleError(e));
    }
  }

  Future<Result<dynamic>> delete(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    if (!_internetService.isConnected.value) {
      return Result(
          status: Results.error, message: 'Không có kết nối internet');
    }

    try {
      final response = await _dio.delete(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      return Result(status: Results.error, message: _handleError(e));
    }
  }

  /// --- RESPONSE & ERROR HANDLER ---
  Result _handleResponse(dynamic response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return Result(status: Results.success, data: response.data);
    } else {
      final message = (response.data is Map && response.data['error'] != null)
          ? response.data['error']
          : 'HTTP ${response.statusCode}';
      return Result(status: Results.error, message: message);
    }
  }

  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Kết nối server quá thời gian cho phép';
    } else if (e.message != null) {
      return e.message.toString();
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Server phản hồi quá chậm';
    } else if (e.type == DioExceptionType.badResponse) {
      return 'Lỗi server: ${e.response?.statusCode}';
    } else {
      return 'Có lỗi xảy ra: ${e.message}';
    }
  }
}
