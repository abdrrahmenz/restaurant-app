import 'dart:convert';

String addCustomerReviewToJson(AddReview data) =>
    json.encode(data.toJson());

class AddReview {
  AddReview({
    this.id,
    this.name,
    this.review,
  });

  String id;
  String name;
  String review;

  factory AddReview.fromJson(Map<String, dynamic> json) => AddReview(
        id: json["id"] != null ? json["id"] : '',
        name: json["name"] != null ? json["name"] : '',
        review: json["review"] != null ? json["review"] : '',
      );

  Map<String, dynamic> toJson() => {
        "id": id != null ? id : '',
        "name": name != null ? name : '',
        "review": review != null ? review : '',
      };
}