class CategoryDummy {
  final String id;
  final String name;
  final String image;

  CategoryDummy(
    this.id,
    this.name,
    this.image,
  );
}

final List<CategoryDummy> categoryDummy = [
  CategoryDummy("32", "Nike", "assets/category/Nike.png"),
  CategoryDummy("33", "Vans", "assets/category/Vans.png"),
  CategoryDummy("90", "Adidas", "assets/category/Adidas.jpeg"),
  CategoryDummy("91", "Puma", "assets/category/Puma.png"),
];

class AllCategory {
  final int id;
  final String name;

  AllCategory({
    required this.id,
    required this.name,
  });

  factory AllCategory.fromJson(Map<String, dynamic> json) {
    return AllCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}
