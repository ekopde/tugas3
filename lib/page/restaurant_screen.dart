import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas2/data/model/restaurant_model.dart';
import 'package:tugas2/data/provider/restaurant_detail_provider.dart';
import 'package:tugas2/data/state/current_state.dart';
import 'package:tugas2/widget/restaurant_detail_builder.dart';
import 'package:tugas2/widget/state_message_scaffold.dart';

class RestaurantScreen extends StatelessWidget {
  static const routeName = "/restaurantScreen";

  final Restaurant restaurant;

  const RestaurantScreen({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final resId = ModalRoute.of(context)!.settings.arguments as String;
    return Consumer<RestaurantDetailProvider>(
      builder: (context, data, child) {
        /// Loading state
        if (data.currentState == RestoDetailState.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 89, 177, 212)),
            ),
          );

          /// No Data state
        } else if (data.currentState == RestoDetailState.noData) {
          return StateMessageScaffold(icon: Icons.fastfood, text: data.message);

          /// Error state
        } else if (data.currentState == RestoDetailState.error) {
          return StateMessageScaffold(
              icon: Icons.cancel_rounded, text: data.message);

          /// Has Data state
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(restaurant.name),
              backgroundColor: Color.fromARGB(255, 92, 155, 206),
            ),
            body: RestaurantDetailBuilder(restaurant: restaurant),
          );
        }
      },
    );
  }
}
