import 'package:food_quest/core/config/const/app_logger.dart';
import 'package:food_quest/core/local_storage/app_get_storage.dart';
import 'package:food_quest/features/user/data/model/auth_response.dart';
import 'package:food_quest/features/user/data/model/user_model.dart';
import 'package:food_quest/features/user/domain/repositories/user_repository.dart';

class UserUseCase {
  final UserRepository _repository;

  UserUseCase(this._repository);

  Future<UserModel?> getUserById(String id) => _repository.getUserById(id);

  Future<List<UserModel>> getAllUsers() => _repository.getAllUsers();

  Future<bool> login(
    String email,
    String password,
  ) async {
    final user = UserModel(
      username: email,
      password: password,
    );
    try {
      final AuthResponse? result = await _repository.login(user);
      if (result != null) {
        AppGetStorage.saveToken(result.token);
        AppGetStorage.saveUser(result.user);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// ✅ Đăng ký user mới
  Future<UserModel?> register({
    required String username,
    required String password,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String role = "user",
  }) async {
    final user = UserModel(
      username: username,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      role: role,
    );

    try {
      final UserModel? result = await _repository.register(user);
      return result;
    } catch (e) {
      AppLogger.i(e);
      return null;
    }
  }

  Future<UserModel> updateUser(UserModel user) => _repository.updateUser(user);

  Future<void> deleteUser(String id) => _repository.deleteUser(id);
}
