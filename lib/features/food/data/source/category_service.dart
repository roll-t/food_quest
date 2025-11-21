import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_quest/core/config/const/app_logger.dart';
import 'package:food_quest/core/services/firebase/firebase_service.dart';
import 'package:food_quest/features/category/data/model/category_model.dart';

class CategoryService extends FirebaseService {
  final String _collection = "categories";

  Future<bool> addCategory(CategoryModel category) async {
    try {
      final now = FieldValue.serverTimestamp();
      final data = category.toJson()
        ..['createdAt'] = now
        ..['updatedAt'] = now;

      await db.collection(_collection).add(data);
      return true;
    } catch (e) {
      AppLogger.e(e);
      return false;
    }
  }

  Future<void> updateCategory(String id, Map<String, dynamic> data) async {
    try {
      final updatedData = Map<String, dynamic>.from(data)..['updatedAt'] = FieldValue.serverTimestamp();

      await db.collection(_collection).doc(id).update(updatedData);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  /// 🔹 Xóa category theo ID
  Future<void> deleteCategory(String id) async {
    try {
      await db.collection(_collection).doc(id).delete();
    } catch (e) {
      AppLogger.e(e);
    }
  }

  /// 🔹 Lấy tất cả category theo ngày tạo
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await db.collection(_collection).orderBy('createdAt', descending: true).get();

      return snapshot.docs.map((doc) => CategoryModel.fromJson(doc.data(), id: doc.id)).toList();
    } catch (e) {
      AppLogger.e(e);
      return [];
    }
  }

  /// 🔹 Stream categories realtime
  Stream<List<CategoryModel>> streamCategories({int limit = 50}) {
    return db
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => CategoryModel.fromJson(doc.data(), id: doc.id)).toList());
  }

  /// 🔹 Lấy categories đã chọn
  Future<List<CategoryModel>> getSelectedCategories() async {
    try {
      final snapshot = await db.collection(_collection).where('isSelected', isEqualTo: true).get();
      return snapshot.docs.map((doc) => CategoryModel.fromJson(doc.data(), id: doc.id)).toList();
    } catch (e) {
      AppLogger.e(e);
      return [];
    }
  }

  /// 🔹 Toggle isSelected
  Future<void> toggleSelected(String id, bool isSelected) async {
    try {
      final updateData = {
        'isSelected': isSelected,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await db.collection(_collection).doc(id).update(updateData);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  /// ✅ Xóa nhiều categories cùng lúc (batch)
  Future<bool> deleteMultiCategories(List<String> ids) async {
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

  /// ✅ Toggle isSelected cho nhiều category cùng lúc
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
