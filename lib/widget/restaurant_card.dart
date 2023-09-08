import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas2/common/navigation.dart';
import 'package:tugas2/data/model/restaurant_model.dart';
import 'package:tugas2/data/model/restaurants_model.dart';

import 'package:tugas2/data/provider/restaurant_detail_provider.dart';
import 'package:tugas2/page/restaurant_screen.dart';

/// Each Restaurant in [HomeScreen], [SearchScreen], [FavoriteScreen]
class RestaurantCard extends StatelessWidget {
  final Restaurants restaurants;
  const RestaurantCard({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String smallImg = "https://restaurant-api.dicoding.dev/images/small/";

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 4),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return GestureDetector(
            onTap: () async {
              /// get the current restaurant detail value that is pressed
              /// and pass to navigation
              await value.getRestaurantsDetail(restaurants.id);
              final Restaurant restaurant = value.restaurantDetail.restaurant;
              Navigation.intentWithData(RestaurantScreen.routeName, restaurant);
            },

            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(8),
                color: Color.fromARGB(255, 107, 155, 201),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color.fromARGB(255, 189, 189, 189),
                    blurRadius: 3,
                    offset: Offset(1, 3),
                  )
                ],
              ),

              //Card content
              child: ListTile(
                // Restaurant Image
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Hero(
                      tag: restaurants.pictureId,
                      child: Image.network(
                        (smallImg + restaurants.pictureId),

                        /// When it's done loading
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          /// While still loading
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 106, 188, 255)));
                        },                 
                        errorBuilder: (context, error, stackTrace) {
                          return Column(
                            children: const <Widget>[
                              Icon(Icons.warning_rounded),
                              Text("Img Error")
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Restaurant Name
                title: Text(
                  restaurants.name,
                  style: const TextStyle(color: Colors.white),
                ),

                //Restaurant Location
                subtitle: Text(
                  restaurants.city,
                  style: const TextStyle(color: Colors.white),
                ),

                //Restaurant Rating
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                                               const Icon(
                          Icons.star_rounded,
                          color: Colors.yellow,
                        ),
                        Text(
                          restaurants.rating.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
