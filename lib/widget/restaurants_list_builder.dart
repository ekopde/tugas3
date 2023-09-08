import 'package:flutter/material.dart';
import 'package:tugas2/data/model/restaurants_model.dart';
import 'package:tugas2/widget/restaurant_card.dart';

class RestaurantsListBuilder extends StatelessWidget {
  final RestaurantsList restaurantsList;
  const RestaurantsListBuilder({super.key, required this.restaurantsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurantsList.restaurants.length,
      itemBuilder: (context, index) {
        return RestaurantCard(restaurants: restaurantsList.restaurants[index]);
      },
    );
  }
}
