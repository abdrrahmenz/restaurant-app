import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail_result.dart';
import 'package:restaurant_app/data/model/restaurant_list_result.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({@required this.apiService}) {
    _fetchListRestaurant();
  }

  RestaurantListResult _restaurantListResult;
  RestaurantListResult _restaurantSearchListResult;
  RestaurantDetailResult _restaurantDetailResult;
  String _message = '';
  ResultState _state;
  ResultState _stateDetail;

  String get message => _message;

  RestaurantListResult get result => _restaurantListResult;

  RestaurantListResult get resultSearch => _restaurantSearchListResult;

  RestaurantDetailResult get resultDetail => _restaurantDetailResult;

  ResultState get state => _state;

  ResultState get stateDetail => _stateDetail;

  Future<dynamic> _fetchListRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getListRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Restaurant Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantListResult = restaurant;
      }
    } on SocketException {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'No network connection';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> fetchDetailRestaurant(String restauranttId) async {
    try {
      _stateDetail = ResultState.Loading;
      notifyListeners();
      final detailRestaurant = await apiService.getDetailRestaurant(restauranttId);
      if (detailRestaurant.restaurant != null) {
        _stateDetail = ResultState.HasData;
        notifyListeners();
        return _restaurantDetailResult = detailRestaurant;
      } else {
        _stateDetail = ResultState.NoData;
        notifyListeners();
      return _message = 'Restorant Empty Data';
      }
    } on SocketException {
      _stateDetail = ResultState.Error;
      notifyListeners();
      return _message = 'No network connection';
    } catch (e) {
      _stateDetail = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> searchRestaurant({
    @required String query,
  }) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Restaurant Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantSearchListResult = restaurant;
      }
    } on SocketException {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'No network connection';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> fetchAddReview(
      String idRestaurant, String name, String review) async {
    try {
      _stateDetail = ResultState.Loading;
      notifyListeners();
      final restaurant =
          await apiService.addReview(idRestaurant, name, review);
      if (restaurant.customerReviews.isEmpty || restaurant.error) {
        _stateDetail = ResultState.NoData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _stateDetail = ResultState.HasData;
        notifyListeners();
        return _restaurantDetailResult.restaurant.customerReviews.add(restaurant.customerReviews.last);
      }
    } on SocketException {
      _stateDetail = ResultState.Error;
      notifyListeners();
      return _message = 'No network connection';
    } catch (e) {
      _stateDetail = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
