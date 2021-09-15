import 'drinks.dart';
import 'foods.dart';

class Menus {
  List<Foods> foods;
  List<Drinks> drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = List<Foods>();
      json['foods'].forEach((v) {
        foods.add(Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = List<Drinks>();
      json['drinks'].forEach((v) {
        drinks.add(Drinks.fromJson(v));
      });
    }
  }
Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    };
}
