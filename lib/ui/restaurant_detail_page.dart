import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/base_url.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/restaurants.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/custom_dialog.dart';
import 'package:restaurant_app/widgets/custom_textfield.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final Restaurants restaurants;
  const RestaurantDetailPage({@required this.restaurants});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  RestaurantProvider restaurantProvider =
      RestaurantProvider(apiService: ApiService());
  TextEditingController _nameController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurants.name),
        actions: <Widget>[
          Consumer<DatabaseProvider>(builder: (context, provider, child) {
            return FutureBuilder<bool>(
                future: provider.isFavorited(widget.restaurants.id),
                builder: (context, snapshot) {
                  var isFavorited = snapshot.data ?? false;
                  return IconButton(
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      if (isFavorited) {
                        provider.removeFavorite(widget.restaurants.id);
                      } else {
                        provider.addFavorite(widget.restaurants);
                      }
                    },
                  );
                });
          })
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.stateDetail == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.stateDetail == ResultState.HasData) {
            return _buildDetailRestaurant(state.resultDetail.restaurant);
          } else if (state.stateDetail == ResultState.NoData) {
            return Center(child: Text(state.message));
          } else if (state.stateDetail == ResultState.Error) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }

  Widget _buildDetailRestaurant(Restaurants restaurant) {
    return SingleChildScrollView(
      child: Column(
        children: [
          restaurant.pictureId == null
              ? Container(width: 100, child: Icon(Icons.error))
              : Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    pictUrl + restaurant.pictureId,
                    width: double.infinity,
                  ),
                ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Divider(color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                    Row(
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
                  ],
                ),
                Divider(color: Colors.grey),
                Text(
                  restaurant.description ?? "",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
                Text(
                  "Menu",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Food",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Wrap(children: _buildFoodsItem(restaurant)),
                SizedBox(height: 10),
                Text(
                  "Drink",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Wrap(children: _buildDrinksItem(restaurant)),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Tambah Review",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                CustomTextField(
                  controller: _nameController,
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  hintText: 'Masukkan nama',
                  onChanged: (value) => _nameController.text,
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: _messageController,
                  margin: EdgeInsets.only(bottom: 15),
                  hintText: 'Masukkan review',
                  onChanged: (value) => _messageController.text,
                ),
                SizedBox(height: 4),
                RaisedButton(
                  child: Text('Kirim'),
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _messageController.text.isNotEmpty) {
                      restaurantProvider
                          .fetchAddReview(restaurant.id, _nameController.text,
                              _messageController.text)
                          .then((value) async {
                        if (value != null) {
                          _nameController.clear();
                          _messageController.clear();
                          customDialog(context, "Berhasil",
                              "Review Berhasil Ditambahkan");
                        } else {
                          customDialog(
                              context, "Gagal", "Review gagal Ditambahkan");
                        }
                      });
                    }
                  },
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Review",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                _buildListReview(restaurant.customerReviews)
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDrinksItem(Restaurants restaurant) {
    List<Widget> listDrink = List<Widget>();
    for (var drink in restaurant.menus.drinks) {
      listDrink.add(Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            drink.name,
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ),
        color: Colors.grey.shade300,
      ));
    }
    return listDrink;
  }

  Widget _buildListReview(List<CustomerReview> customerReviews) {
    double sizeHeight =
        customerReviews.length > 0 ? 80.0 * customerReviews.length : 0;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: sizeHeight),
      child: ListView.separated(
        itemCount: customerReviews.length,
        itemBuilder: (context, index) {
          var item = customerReviews[index];
          return Material(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.name ?? "Name"),
                  Text(item.date ?? "Date"),
                ],
              ),
              subtitle: Text(item.review ?? "Review"),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  List<Widget> _buildFoodsItem(Restaurants restaurant) {
    List<Widget> listFood = List<Widget>();
    for (var food in restaurant.menus.foods) {
      listFood.add(Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            food.name,
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ),
        color: Colors.grey.shade300,
      ));
    }
    return listFood;
  }
}
