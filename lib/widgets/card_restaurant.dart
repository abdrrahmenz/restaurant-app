import 'package:flutter/material.dart';
import 'package:restaurant_app/common/base_url.dart';
import 'package:restaurant_app/data/model/restaurants.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurants restaurant;
  final Function onPressed;

  const CardRestaurant(
      {Key key, @required this.restaurant, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: restaurant.pictureId == null
            ? Container(width: 100, child: Icon(Icons.error))
            : Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                  pictUrl + restaurant.pictureId,
                  width: 100,
                ),
              ),
        title: Text(
          restaurant.name ?? "",
        ),
        subtitle: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 14,
                    color: Colors.brown,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(restaurant.city ?? "")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(restaurant.rating ?? "")
                ],
              ),
            )
          ],
        ),
        onTap: onPressed
      ),
    );
  }
}
