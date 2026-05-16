class SubCategoryModel {
  final String id;
  final String name;
  final String image;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['sub_id'] ?? '',
      name: json['sub_name'] ?? '',
      image: json['sub_image'] ?? '',
    );
  }
}
