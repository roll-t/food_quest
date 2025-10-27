import 'package:food_quest/main/user/data/repositories/user_repository_impl.dart';
import 'package:food_quest/main/user/data/source/user_api.dart';
import 'package:food_quest/main/user/domain/repositories/user_repository.dart';
import 'package:food_quest/main/user/domain/usecase/user_usecase.dart';
import 'package:food_quest/main/user/features/auth/login/presentation/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    ///---> [API]
    Get.lazyPut(
      () => UserApi(),
    );

    ///---> [Repository]
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        Get.find(),
      ),
    );

    ///---> [User]
    Get.lazyPut(
      () => UserUseCase(
        Get.find(),
      ),
    );

    ///---> [Controller]
    Get.lazyPut(
      () => LoginController(
        Get.find(),
      ),
    );
  }
}
