import 'dart:convert';
import 'package:restaurant_app/common/base_url.dart';
import 'package:restaurant_app/data/model/add_review.dart';
import 'package:restaurant_app/data/model/customer_review_result.dart';
import 'package:restaurant_app/data/model/restaurant_detail_result.dart';
import 'package:restaurant_app/data/model/restaurant_list_result.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<RestaurantListResult> getListRestaurant() async {
    final response = await http.get(baseUrl + "list");
    if (response.statusCode == 200) {
      return RestaurantListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurants');
    }
  }

  Future<RestaurantDetailResult> getDetailRestaurant(String id) async {
    final response = await http.get(baseUrl + "detail/$id");
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurants');
    }
  }

  Future<RestaurantListResult> searchRestaurant(String query) async {
    final response = await http.get(baseUrl + 'search?q=$query');
    if (response.statusCode == 200) {
      return RestaurantListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  Future<CustomerReviewResult> addReview(
      String idRestaurant, String nameReview, String messageReview) async {
    final headers = {
      'Content-Type': 'application/json',
      'X-Auth-Token': '12345'
    };
    final addReview =
        AddReview(id: idRestaurant, name: nameReview, review: messageReview);
    final convertToJson = addCustomerReviewToJson(addReview);
    final response = await http.post(baseUrl + 'review', body: convertToJson, headers: headers);
    if (response.statusCode == 200) {
      return CustomerReviewResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review restaurants');
    }
  }
}
