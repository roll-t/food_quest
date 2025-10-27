import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:get/get.dart';

class SortController extends GetxController {
  var sortType = SortType.newest.obs;

  /// Đảo trạng thái sort
  void toggleSort() {
    sortType.value =
        sortType.value == SortType.newest ? SortType.oldest : SortType.newest;
  }

  /// Trả về label hiển thị trên UI
  String get label =>
      sortType.value == SortType.newest ? 'Mới nhất' : 'Cũ nhất';

  /// true = tăng dần (cũ -> mới), false = giảm dần (mới -> cũ)
  bool get isAsc => sortType.value == SortType.newest;

  void resetSort() {
    sortType.value = SortType.newest;
  }

  @override
  void onClose() {
    sortType.close();
    super.onClose();
  }
}
