class ItemModel {
  final String? id;
  final String? title;
  ItemModel({
    this.id,
    this.title,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
    );
  }
}
