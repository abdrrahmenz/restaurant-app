class Category {
  Category({
    this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );
}
