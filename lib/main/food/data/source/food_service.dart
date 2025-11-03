import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_quest/core/config/const/app_logger.dart';
import 'package:food_quest/core/services/firebase/firebase_service.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';

class FoodService extends FirebaseService {
  final String _collection = "foods";

  /// 🔹 Thêm food mới với createdAt và updatedAt
  Future<bool> addFood(FoodModel food) async {
    try {
      final now = FieldValue.serverTimestamp();
      final data = food.toJson()
        ..['createdAt'] = now
        ..['updatedAt'] = now;

      await db.collection(_collection).add(data);
      return true;
    } catch (e) {
      AppLogger.e(e);
      return false;
    }
  }

  /// 🔹 Cập nhật food theo ID với updatedAt
  Future<void> updateFood(String id, Map<String, dynamic> data) async {
    try {
      final updatedData = Map<String, dynamic>.from(data)
        ..['updatedAt'] = FieldValue.serverTimestamp();

      await db.collection(_collection).doc(id).update(updatedData);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  /// 🔹 Xóa food theo ID
  Future<void> deleteFood(String id) async {
    try {
      await db.collection(_collection).doc(id).delete();
    } catch (e) {
      AppLogger.e(e);
    }
  }

  Future<List<FoodModel>> fetchFoodsPage({
    int limit = 18,
    DocumentSnapshot? startAfterDoc,
  }) async {
    try {
      Query query = db.collection(_collection).orderBy('createdAt', descending: true).limit(limit);
      if (startAfterDoc != null) {
        query = query.startAfterDocument(startAfterDoc);
      }
      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) {
            final data = doc.data();
            if (data == null) return null;
            return FoodModel.fromJson(Map<String, dynamic>.from(data as Map), id: doc.id);
          })
          .whereType<FoodModel>()
          .toList();
    } catch (e) {
      AppLogger.e(e);
      return [];
    }
  }

  /// 🔹 Lấy tất cả foods theo ngày tạo (mới nhất trước)
  Future<List<FoodModel>> getAllFoods() async {
    try {
      final snapshot =
          await db.collection(_collection).orderBy('createdAt', descending: true).get();

      return snapshot.docs.map((doc) => FoodModel.fromJson(doc.data(), id: doc.id)).toList();
    } catch (e) {
      AppLogger.e(e);
      return [];
    }
  }

  /// 🔹 Stream foods realtime theo ngày tạo
  Stream<List<FoodModel>> streamFoods({int limit = 18}) {
    return db
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => FoodModel.fromJson(doc.data(), id: doc.id)).toList();
    });
  }

  /// 🔹 Lấy foods đã chọn
  Future<List<FoodModel>> getSelectedFoods() async {
    try {
      final snapshot = await db.collection(_collection).where('isSelected', isEqualTo: true).get();
      return snapshot.docs.map((doc) => FoodModel.fromJson(doc.data(), id: doc.id)).toList();
    } catch (e) {
      AppLogger.e(e);
      return [];
    }
  }

  /// 🔹 Toggle trạng thái isSelected
  Future<void> toggleSelected(String id, bool isSelected) async {
    try {
      await db.collection(_collection).doc(id).update({'isSelected': isSelected});
    } catch (e) {
      AppLogger.e(e);
    }
  }

  /// 🔹 Stream foods đã chọn realtime
  Stream<List<FoodModel>> streamSelectedFoods() {
    return db
        .collection(_collection)
        .where('isSelected', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => FoodModel.fromJson(doc.data(), id: doc.id)).toList();
    });
  }
}
