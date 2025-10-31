import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:food_quest/core/config/result.dart';
import 'package:food_quest/core/services/api/api_client.dart';
import 'package:food_quest/core/services/api/api_endpoint.dart';
import 'package:food_quest/main/user/data/model/user_model.dart';
import 'package:get/get.dart';

class UserApi {
  final ApiClient _client = Get.find<ApiClient>();
  Future<Result> getUsers({
    int pageSize = 20,
    String? startAfter,
  }) {
    final query = {
      'pageSize': pageSize,
      if (startAfter != null) 'startAfter': startAfter,
    };
    return _client.get(ApiEndpoint.users, query: query);
  }

  Future<Result> getAllUsers() {
    return _client.get(ApiEndpoint.allUsers);
  }

  Future<Result> getUserDetail(String userId) {
    return _client.get(ApiEndpoint.userDetail(userId));
  }

  Future<Result> login(UserModel user) {
    return _client.post(
      ApiEndpoint.login,
      data: user.toLogin(),
    );
  }

  /// Đăng ký user mới
  Future<Result> registerUser(UserModel user) async {
    final result = await _client.post(
      ApiEndpoint.users,
      data: user.toCreate(),
    );
    if (result.status == Results.error) {
      return Result(
        status: Results.error,
        data: null,
        message: result.message,
      );
    }
    return result;
  }

  Future<Result> updateUser(UserModel user) {
    return _client.patch(
      ApiEndpoint.updateUser(user.uid ?? ""),
      data: user.toReq(),
    );
  }

  /// Xóa user
  Future<Result> deleteUser(String userId) {
    return _client.delete(
      ApiEndpoint.deleteUser(userId),
    );
  }

  /// Đổi mật khẩu user
  Future<Result> updatePassword(
    String userId,
    String newPassword,
  ) {
    return _client.put(
      ApiEndpoint.updatePassword(userId),
      data: {
        'newPassword': newPassword,
      },
    );
  }

  /// Reset mật khẩu user về mặc định
  Future<Result> resetPassword(String userId) {
    return _client.post(
      ApiEndpoint.resetPassword(userId),
    );
  }
}
