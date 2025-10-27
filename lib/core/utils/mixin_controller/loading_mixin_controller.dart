import 'package:get/get.dart';

mixin LoadingMixinController {
  RxBool isLoading = false.obs; // Trạng thái loading chính
  RxBool isLoadMore = false.obs; // Trạng thái loading cho load more
  RxBool isLoadWaiting = false.obs; // Trạng thái waiting (chờ)
  RxBool isLoadingProgressing = false.obs; // Trạng thái loading tiến trình

  // Hàm cập nhật trạng thái loading
  void setLoadingState(bool value) {
    isLoading.value = value;
  }
}
