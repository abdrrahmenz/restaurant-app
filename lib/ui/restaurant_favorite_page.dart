import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';
import 'package:restaurant_app/widgets/platform_widgets.dart';

import 'restaurant_detail_page.dart';

class RestaurantFavoritePage extends StatelessWidget {
  static const String bookmarksTitle = 'Favorite';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookmarksTitle),
      ),
      body: _buildList(),
    );
  }
 
  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(bookmarksTitle),
      ),
      child: _buildList(),
    );
  }
 
  Widget _buildList() {
    return Consumer2<DatabaseProvider, RestaurantProvider>(
      builder: (context, dBprovider, restaurantProvider, child) {
        if (dBprovider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: dBprovider.favorites.length,
            itemBuilder: (context, index) {
              return CardRestaurant(restaurant: dBprovider.favorites[index], onPressed: () {
            restaurantProvider.fetchDetailRestaurant(dBprovider.favorites[index].id);
            Navigation.intentWithData(
                RestaurantDetailPage.routeName, dBprovider.favorites[index]);
          },);
            },
          );
        } else {
          return Center(
            child: Text(dBprovider.message),
          );
        }
      },
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}