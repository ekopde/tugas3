import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas2/data/provider/home_provider.dart';
import 'package:tugas2/data/state/current_state.dart';
import 'package:tugas2/widget/restaurants_list_builder.dart';
import 'package:tugas2/widget/state_message_scaffold.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, HomeProvider data, child) {
        /// Loading state
        if (data.currentState == HomeCurrentState.loading) {
          return const Center(
            child: CircularProgressIndicator(color: Color.fromARGB(255, 105, 146, 199)),
          );

          // No Data state
        } else if (data.currentState == HomeCurrentState.noData) {
          return StateMessageScaffold(icon: Icons.fastfood, text: data.message);

          ///Error state
        } else if (data.currentState == HomeCurrentState.error) {
          return StateMessageScaffold(icon: Icons.cancel_rounded, text: data.message);
    
        } else if (data.currentState == HomeCurrentState.hasData) {
          return RestaurantsListBuilder(restaurantsList: data.restaurantsList);

        } else {
          return StateMessageScaffold(icon: Icons.fastfood, text: data.message);
        }
      },
    );
  }
}
