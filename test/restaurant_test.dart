import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';

void main() {
  group('JSON Parsing API test', () {
    ApiService apiService;

    setUp(() {
      apiService = ApiService();
    });

    test('should contain list restaurants fetch completed', () async {
      var restaurantList = await apiService.getListRestaurant();
      var result = restaurantList.error;
      expect(result, false);
    });

    test('should contain detail restaurants fetch completed', () async {
      var restoDetail = await apiService.getDetailRestaurant('rqdv5juczeskfw1e867');
      var result = restoDetail.error;
      expect(result, false);
    });

    test('should contain search restaurants fetch completed', () async {
      var restoSearch = await apiService.searchRestaurant('melting');
      var result = restoSearch.error;
      expect(result, false);
    });
  });
}
