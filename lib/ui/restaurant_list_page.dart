import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list_result.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';
import 'package:restaurant_app/widgets/platform_widgets.dart';
import 'package:restaurant_app/widgets/custom_textfield.dart';

class RestaurantListPage extends StatefulWidget {
  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  RestaurantProvider restaurantProvider =
      RestaurantProvider(apiService: ApiService());

  TextEditingController _searchController = TextEditingController();

  Widget _buildList(BuildContext context) {
    restaurantProvider = Provider.of<RestaurantProvider>(context);
    return Column(
      children: [
        Container(
          child: CustomTextField(
            controller: _searchController,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 15),
            hintText: 'Search Restorant',
            onChanged: (value) => restaurantProvider.searchRestaurant(
              query: _searchController.text,
            ),
          ),
        ),
        Expanded(
          child: Consumer<RestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.HasData) {
                return _searchController.text.isNotEmpty &&
                        !state.resultSearch.error
                    ? _buildListView(state.resultSearch)
                    : _buildListView(state.result);
              } else if (state.state == ResultState.NoData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.Error) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text(''));
              }
            },
          ),
        ),
      ],
    );
  }

  ListView _buildListView(RestaurantListResult result) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: result.restaurants.length,
      itemBuilder: (context, index) {
        var restaurant = result.restaurants[index];
        return CardRestaurant(
          restaurant: restaurant,
          onPressed: () {
            restaurantProvider.fetchDetailRestaurant(restaurant.id);
            Navigation.intentWithData(
                RestaurantDetailPage.routeName, restaurant);
          },
        );
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Restaurants App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}