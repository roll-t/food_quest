import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/main/user/data/model/auth_response.dart';
import 'package:food_quest/main/user/data/model/user_model.dart';
import 'package:food_quest/main/user/data/source/user_api.dart';
import 'package:food_quest/main/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApi _api;

  UserRepositoryImpl(this._api);

  @override
  Future<List<UserModel>> getAllUsers() async {
    final result = await _api.getAllUsers();
    if (result.isSuccess) {
      final List data = result.data as List;
      return data.map((e) => UserModel.fromJson(e)).toList();
    }
    throw result.status;
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    final result = await _api.getUserDetail(id);
    if (result.isSuccess) {
      return UserModel.fromJson(result.data);
    }
    return null;
  }

  @override
  Future<AuthResponse?> login(UserModel user) async {
    final result = await _api.login(user);
    if (result.isSuccess) {
      return AuthResponse.fromJson(result.data);
    } else if (result.status == Results.error) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        title: "Đăng nhập thất bại",
        content: "${result.message}",
      );
    }
    return null;
  }

  @override
  Future<UserModel?> register(UserModel user) async {
    final result = await _api.registerUser(user);
    if (!result.isSuccess) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        title: "Lỗi đăng ký",
        content: result.message,
      );
      return null;
    }
    if (result.isSuccess) {
      return UserModel.fromJson(result.data);
    }
    return null;
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    final result = await _api.updateUser(user);
    if (result.isSuccess) {
      return UserModel.fromJson(result.data);
    }
    throw result.status;
  }

  @override
  Future<void> deleteUser(String id) async {
    final result = await _api.deleteUser(id);
    if (!result.isSuccess) {
      throw result.status;
    }
  }
}
