import 'package:flutter/material.dart';
import 'package:tugas2/data/provider/screenIndexProvider.dart';
import 'package:tugas2/page/restaurant_screen.dart';
import 'package:tugas2/page/search_screen.dart';
import 'package:tugas2/page/home_screen.dart';
import 'package:tugas2/page/setting_screen.dart';
import 'package:tugas2/utils/notification_helper.dart';
import 'package:provider/provider.dart';
class MainScreen extends StatefulWidget {
  static const String routeName = '/homeScreen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int _currentTabIndex = 0;

  List<Widget> widgetToBuild = <Widget>[
    const HomeScreen(),
    const SettingScreen(),
  ];
  
  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(RestaurantScreen.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenindexprovider = Provider.of<screenIndexProvider>(context) ;
    int currentScreenIndex = screenindexprovider.fetchCurrentScreenIndex;
    return Scaffold(
      appBar: AppBar(
        title: (_currentTabIndex == 0)
            ? const Text('List Restaurants')
            : const Text('Favorite Restaurants'),
        backgroundColor: Color.fromARGB(255, 106, 176, 255),

        /// Search Icon
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                // Navigation.intentWithoutData(SearchScreen.routeName);
                Navigator.pushNamed(context, SearchScreen.routeName);
              },
              child: const Icon(
                Icons.search_rounded,
              ),
            ),
          ),
        ],
      ),

      /// content to show
      body: widgetToBuild[_currentTabIndex],

      /// Bot nav bar
      
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        showSelectedLabels: false,
        elevation: 1.5,
        currentIndex: currentScreenIndex,
        onTap: (value) => screenindexprovider.updateScreenIndex(value),
        items: [
          BottomNavigationBarItem(
              label: '',
              icon: Icon(
                  (currentScreenIndex == 0) ? Icons.home : Icons.home_outlined),
              backgroundColor: Colors
                  .indigo // provide color to any one icon as it will overwrite the whole bottombar's color ( if provided any )
              ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon((currentScreenIndex == 1)
                ? Icons.search
                : Icons.search_outlined),
          ),
         
        ],
      ),
    );
  }
}
