class Foods {
  String name;

  Foods({this.name});

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
    };
}
