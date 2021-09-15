import 'package:restaurant_app/data/model/restaurants.dart';

class RestaurantListResult {
    RestaurantListResult({
        this.error,
        this.message,
        this.count,
        this.restaurants,
    });

    bool error;
    String message;
    int count;
    List<Restaurants> restaurants;

    factory RestaurantListResult.fromJson(Map<String, dynamic> json) => RestaurantListResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurants>.from(json["restaurants"].map((x) => Restaurants.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}