class Drinks {
  String name;

  Drinks({this.name});

  factory Drinks.fromJson(Map<String, dynamic> json) => Drinks(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
