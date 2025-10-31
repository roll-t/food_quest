class FoodModel {
  final String? id;
  final String? name;
  final String? image;

  FoodModel({
    this.id,
    this.name,
    this.image,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json, String id) {
    return FoodModel(
      id: id,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
