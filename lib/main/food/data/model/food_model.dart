import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_quest/main/food/data/model/meta_data_model.dart';

class FoodModel {
  final String? id;
  final String? name;
  final String? image;
  bool isSelected;
  final MetaDataModel? metaDataModel;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  Timestamp? recentSelect;

  FoodModel({
    this.id,
    this.name,
    this.image,
    this.isSelected = false,
    this.metaDataModel,
    this.createdAt,
    this.updatedAt,
    this.recentSelect,
  });

  /// Tạo từ JSON / Map (Firestore)
  factory FoodModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return FoodModel(
      id: id ?? json['id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      isSelected: json['isSelected'] ?? false,
      metaDataModel:
          json['metaData'] != null ? MetaDataModel.fromMap(Map<String, dynamic>.from(json['metaData'])) : null,
      createdAt: json['createdAt'] as Timestamp?,
      updatedAt: json['updatedAt'] as Timestamp?,
      recentSelect: json['recentSelect'] as Timestamp?,
    );
  }

  /// Chuyển về Map/JSON để lưu Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'isSelected': isSelected,
      'metaData': metaDataModel?.toMap(),
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
      'recentSelect': recentSelect,
    };
  }

  /// CopyWith tiện lợi
  FoodModel copyWith({
    String? id,
    String? name,
    String? image,
    bool? isSelected,
    MetaDataModel? metaDataModel,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    Timestamp? recentSelect,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      isSelected: isSelected ?? this.isSelected,
      metaDataModel: metaDataModel ?? this.metaDataModel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      recentSelect: recentSelect ?? this.recentSelect,
    );
  }

  @override
  String toString() {
    return 'FoodModel(id: $id, name: $name, image: $image, isSelected: $isSelected, recentSelect: $recentSelect, metaDataModel: $metaDataModel, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
