import 'dart:async';

import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:food_quest/main/home/data/model/food_model.dart';
import 'package:food_quest/main/home/feature/presentation/controller/scale_dialog_controller.dart';
import 'package:food_quest/main/home/feature/presentation/widgets/wheel_spinner.dart';
import 'package:get/get.dart';

class WheelController extends GetxController {
  // ---- Reactive states ----
  final RxBool isPressed = false.obs;
  final RxBool isSpinning = false.obs;

  // ---- Stream for the wheel ----
  final StreamController<int> selected = StreamController<int>();

  // ---- Data ----
  final List<FoodModel> foods = [
    FoodModel(
      name: 'Pizza',
      image:
          'https://tse4.mm.bing.net/th/id/OIP.MjXQ8F5-vQZWZNNcZvitYwHaFj?rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    FoodModel(
      name: 'Burger',
      image:
          'https://img5.thuthuatphanmem.vn/uploads/2021/11/09/anh-do-an-doc-dao-dep-nhat_095145309.jpg',
    ),
    FoodModel(
      name: 'Sushi',
      image:
          'https://tse4.mm.bing.net/th/id/OIP.xJgerYD5UWl0rDj4eqyMbwHaE8?w=1024&h=683&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    FoodModel(
      name: 'Steak',
      image: 'https://i.pinimg.com/originals/43/31/73/433173c8ef119c7e5fa7137a96ad77fa.jpg',
    ),
    FoodModel(
      name: 'Pasta',
      image:
          'https://tse3.mm.bing.net/th/id/OIP.1dR3odGnCpRdmCq3QSnCEgAAAA?w=417&h=626&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    FoodModel(
      name: 'Salad',
      image:
          'https://tse4.mm.bing.net/th/id/OIP.yqncS5YHYtJAUnuCqFSZ-wHaE8?w=626&h=418&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
  ];

  int? _selectedIndex;

  // ---- Actions ----
  Future<void> spinWheel() async {
    if (isSpinning.value) return;

    // hiệu ứng nhấn nhẹ
    isPressed.value = true;
    await Future.delayed(const Duration(milliseconds: 100));
    isPressed.value = false;

    isSpinning.value = true;

    _selectedIndex = Fortune.randomInt(0, foods.length);
    selected.add(_selectedIndex!);
  }

  void onSpinEnd() async {
    isSpinning.value = false;
    if (_selectedIndex != null) {
      // Đăng ký controller
      Get.put(ScaleDialogController());

      // Gọi dialog (không bọc Get.put() trong await)
      await Get.dialog(
        ScaleTransitionDialog(result: foods[_selectedIndex!].name),
        barrierDismissible: false,
      );

      // Xoá controller sau khi dialog đóng
      if (Get.isRegistered<ScaleDialogController>()) {
        Get.delete<ScaleDialogController>();
      }
    }
  }

  // ---- Lifecycle ----
  @override
  void onClose() {
    selected.close();
    super.onClose();
  }
}
