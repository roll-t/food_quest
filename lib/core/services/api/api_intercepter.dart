import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("➡️ [REQUEST] ${options.method} ${options.uri}");
    if (options.data != null) {
      debugPrint("📦 Body: ${options.data}");
    }
    if (options.queryParameters.isNotEmpty) {
      debugPrint("🔍 Query: ${options.queryParameters}");
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("✅ [RESPONSE] ${response.statusCode} ${response.realUri}");
    if (kDebugMode) {
      debugPrint("📦 Data: ${response.data}");
    }

    if (response.statusCode != null && response.statusCode! >= 400) {
      final message = (response.data is Map && response.data['error'] != null)
          ? response.data['error']
          : 'Lỗi không xác định (${response.statusCode})';
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: message,
        ),
      );
      return;
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("❌ [ERROR] ${err.message}");
    if (err.response != null) {
      debugPrint("📦 Error data: ${err.response?.data}");
    }
    super.onError(err, handler);
  }
}
