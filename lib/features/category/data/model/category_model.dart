class CategoryModel {
  final String? id;
  final String name;
  final bool isSelected;

  CategoryModel({this.id, required this.name, this.isSelected = false});

  Map<String, dynamic> toJson() => {
        'name': name,
        'isSelected': isSelected,
      };

  factory CategoryModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return CategoryModel(
      id: id,
      name: json['name'] ?? '',
      isSelected: json['isSelected'] ?? false,
    );
  }
}
