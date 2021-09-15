import 'package:restaurant_app/data/model/restaurants.dart';

class RestaurantDetailResult {
    RestaurantDetailResult({
        this.error,
        this.message,
        this.restaurant,
    });

    bool error;
    String message;
    Restaurants restaurant;

    factory RestaurantDetailResult.fromJson(Map<String, dynamic> json) => RestaurantDetailResult(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurants.fromJson(json["restaurant"]),
    );
}