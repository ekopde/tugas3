import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tugas2/common/navigation.dart';
import 'package:tugas2/data/api/api_service.dart';

import 'package:tugas2/data/model/restaurant_model.dart';
import 'package:tugas2/data/provider/screenIndexProvider.dart';

import 'package:tugas2/data/provider/home_provider.dart';

import 'package:tugas2/data/provider/restaurant_detail_provider.dart';
import 'package:tugas2/data/provider/scheduling_provider.dart';
import 'package:tugas2/data/provider/search_provider.dart';
import 'package:tugas2/page/home_screen.dart';
import 'package:tugas2/page/resto.dart';
import 'package:tugas2/page/restaurant_screen.dart';
import 'package:tugas2/page/search_screen.dart';
import 'package:tugas2/utils/background_service.dart';
import 'package:tugas2/utils/notification_helper.dart';

//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:provider/provider.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(const RestaurantApp1());
}

class RestaurantApp1 extends StatelessWidget {
  const RestaurantApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// [NotifierProvider] is used so we can use the [Consumer]
    /// so we can use the state
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (context) =>
              RestaurantDetailProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (context) => SchedulingProvider(),
        ),
         ChangeNotifierProvider(create: (context) => screenIndexProvider()),
      ],
      child: MaterialApp(
        title: "Restaurant List",
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 81, 194, 214),
          splashColor: const Color.fromRGBO(67, 218, 239, 1),
        ),
        navigatorKey: navigatorKey,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const MainScreen(),
          RestaurantScreen.routeName: (context) => RestaurantScreen(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant),
          SearchScreen.routeName: (context) => const SearchScreen(),
        },
      ),
    );
  }
}
