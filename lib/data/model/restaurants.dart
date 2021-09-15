import 'category.dart';
import 'customer_review.dart';
import 'menus.dart';

class Restaurants {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  String rating;
  String address;
  List<Category> categories;
  Menus menus;
  List<CustomerReview> customerReviews;

  Restaurants(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.address,
      this.categories,
      this.menus,
      this.customerReviews});

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"] != null ? json["address"] : "",
        pictureId: json["pictureId"],
        categories: json["categories"] != null ? List<Category>.from(json["categories"].map((x) => Category.fromJson(x))) : [],
        menus: json["menus"] != null ? Menus.fromJson(json["menus"]) : null,
        rating: json["rating"].toString(),
        customerReviews: json["customerReviews"] != null ? List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))) : [],
    );

   Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "pictureId": pictureId,
        "rating": rating,
    };
}
