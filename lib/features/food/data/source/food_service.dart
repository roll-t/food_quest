import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_quest/core/config/const/app_logger.dart';
import 'package:food_quest/core/services/firebase/firebase_service.dart';
import 'package:food_quest/features/food/data/model/food_model.dart';

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
      final updatedData = Map<String, dynamic>.from(data)..['updatedAt'] = FieldValue.serverTimestamp();

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

  /// 🔹 Lấy foods phân trang (không theo category)
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
          .map((doc) => FoodModel.fromJson(Map<String, dynamic>.from(doc.data() as Map), id: doc.id))
          .toList();
    } catch (e) {
      AppLogger.e(e);
      return [];
    }
  }

  /// 🔹 Lấy foods phân trang theo category
  Future<List<FoodModel>> fetchFoodsByCategoryPage({
    required String categoryId,
    int limit = 18,
    DocumentSnapshot? startAfterDoc,
  }) async {
    try {
      Query query = db
          .collection(_collection)
          .where('categoryId', isEqualTo: categoryId)
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (startAfterDoc != null) {
        query = query.startAfterDocument(startAfterDoc);
      }

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => FoodModel.fromJson(Map<String, dynamic>.from(doc.data() as Map), id: doc.id))
          .toList();
    } catch (e) {
      AppLogger.e(e);
      return [];
    }
  }

  /// 🔹 Lấy tất cả foods theo ngày tạo (mới nhất trước)
  Future<List<FoodModel>> getAllFoods() async {
    try {
      final snapshot = await db.collection(_collection).orderBy('createdAt', descending: true).get();

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
        .map((snapshot) => snapshot.docs.map((doc) => FoodModel.fromJson(doc.data(), id: doc.id)).toList());
  }

  /// 🔹 Stream foods realtime theo category
  Stream<List<FoodModel>> streamFoodsByCategory(String categoryId, {int limit = 18}) {
    return db
        .collection(_collection)
        .where('categoryId', isEqualTo: categoryId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => FoodModel.fromJson(doc.data(), id: doc.id)).toList());
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

  Future<void> toggleSelected(String id, bool isSelected) async {
    try {
      final updateData = {
        'isSelected': isSelected,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (!isSelected) {
        updateData['recentSelect'] = FieldValue.serverTimestamp();
      }
      await db.collection(_collection).doc(id).update(updateData);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  Future<List<FoodModel>> getRecentFoods({int limit = 20}) async {
    try {
      final snapshot = await db.collection(_collection).orderBy('recentSelect', descending: true).limit(limit).get();

      return snapshot.docs.map((doc) => FoodModel.fromJson(doc.data(), id: doc.id)).toList();
    } catch (e, s) {
      AppLogger.e('Error getRecentFoods: $e\n$s');
      return [];
    }
  }

  Stream<List<FoodModel>> streamSelectedFoods() {
    return db
        .collection(_collection)
        .where('isSelected', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => FoodModel.fromJson(doc.data(), id: doc.id)).toList());
  }

  /// ✅ Xóa nhiều foods cùng lúc (dùng batch)
  Future<bool> deleteMultiFood(List<String> ids) async {
    if (ids.isEmpty) return false;
    try {
      final batch = db.batch();
      for (final id in ids) {
        batch.delete(db.collection(_collection).doc(id));
      }
      await batch.commit();
      return true;
    } catch (e) {
      AppLogger.e(e);
      return false;
    }
  }

  /// ✅ Toggle isSelected cho nhiều item cùng lúc
  Future<bool> toggleSelectedMulti(List<String> ids, bool isSelected) async {
    if (ids.isEmpty) return false;
    try {
      final batch = db.batch();
      for (final id in ids) {
        batch.update(db.collection(_collection).doc(id), {'isSelected': isSelected});
      }
      await batch.commit();
      return true;
    } catch (e) {
      AppLogger.e(e);
      return false;
    }
  }
}
