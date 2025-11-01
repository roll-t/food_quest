import 'package:food_quest/core/config/const/app_logger.dart';
import 'package:food_quest/core/services/firebase/firebase_service.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';

class FoodService extends FirebaseService {
  final String _collection = "foods";

  Future<bool> addFood(Map<String, dynamic> food) async {
    try {
      await db.collection(_collection).add(food);
      return true;
    } catch (e) {
      AppLogger.e(e);
      return false;
    }
  }

  Future<void> updateFood(String id, Map<String, dynamic> data) async {
    await db.collection(_collection).doc(id).update(data);
  }

  Future<void> deleteFood(String id) async {
    await db.collection(_collection).doc(id).delete();
  }

  /// 🔹 Stream dữ liệu đã map sang List<FoodModel>
  Stream<List<FoodModel>> streamFoods() {
    return db.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => FoodModel.fromJson(doc.data(), doc.id)).toList();
    });
  }

  /// 🔹 Lấy 1 lần (fetch 1 lần, không realtime)
  Future<List<FoodModel>> fetchFoodsOnce() async {
    final snapshot = await db.collection(_collection).get();
    return snapshot.docs.map((doc) => FoodModel.fromJson(doc.data(), doc.id)).toList();
  }
}
