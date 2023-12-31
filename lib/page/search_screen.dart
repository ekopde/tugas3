import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas2/data/provider/search_provider.dart';
import 'package:tugas2/data/state/current_state.dart';
import 'package:tugas2/widget/restaurants_list_builder.dart';
import 'package:tugas2/widget/state_message.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = "/searchScreen";
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 76, 129, 172),

        /// Input Text
        title: Consumer<SearchProvider>(
          builder: (context, SearchProvider data, child) {
            /// Search input
            return TextField(
              controller: data.controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                hintText: "Search restaurant, tag, menu...",
                hintStyle: TextStyle(color: Colors.white),
              ),

              /// Everytime user type a letter, this onChanged get called and
              /// [controller] also get called, showing the search button
              onChanged: (value) {
                data.setSearchState(true);
              },
              onSubmitted: (value) {
                /// hiding the search button when user press Enter or
                /// clicking Search button
                data.setSearchState(false);
                if (value != "") {
                  /// get search result
                  data.getSearchResult(data.controller.text);
                }
              },
            );
          },
        ),

        /// Search Button
        actions: <Widget>[
          /// if not in [searchState], hide search button or if input is empty
          Consumer<SearchProvider>(
            builder: (context, SearchProvider data, child) {
              return (data.searchState == false || data.controller.text.isEmpty)
                  ? const SizedBox()
                  : IconButton(
                      icon: const Icon(Icons.search_rounded),
                      onPressed: () {
                        /// Hide search button
                        data.setSearchState(false);

                        /// Close keyboard
                        FocusManager.instance.primaryFocus?.unfocus();

                        /// get search Data
                        if (data.controller.text != "") {
                          data.getSearchResult(data.controller.text);
                        }
                      },
                    );
            },
          ),
        ],
      ),

      /// Search Result
      body: Consumer<SearchProvider>(
        builder: (context, SearchProvider data, child) {
          /// Loading state
          if (data.currentState == SearchCurrentState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 74, 140, 167)),
            );

            /// No Data State
          } else if (data.currentState == SearchCurrentState.noData) {
            return StateMessage(icon: Icons.fastfood, text: data.message);

            /// Error Data State
          } else if (data.currentState == SearchCurrentState.error) {
            return StateMessage(icon: Icons.cancel_rounded, text: data.message);

            /// Has Data State
          } else if (data.currentState == SearchCurrentState.hasData) {
            return RestaurantsListBuilder(
                restaurantsList: data.restaurantsList);

            /// Default State
          } else {
            return StateMessage(icon: Icons.fastfood, text: data.message);
          }
        },
      ),
    );
  }
}
