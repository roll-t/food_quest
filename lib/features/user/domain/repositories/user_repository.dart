import 'package:food_quest/features/user/data/model/auth_response.dart';
import 'package:food_quest/features/user/data/model/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> getUserById(String id);
  Future<List<UserModel>> getAllUsers();
  Future<AuthResponse?> login(UserModel user);
  Future<UserModel?> register(UserModel user);
  Future<UserModel> updateUser(UserModel user);
  Future<void> deleteUser(String id);
}
