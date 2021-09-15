import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/navigation.dart';
import 'data/api/api_service.dart';
import 'data/db/database_helper.dart';
import 'provider/database_provider.dart';
import 'provider/preference_provider.dart';
import 'provider/restaurant_provider.dart';
import 'provider/scheduling_provider.dart';
import 'ui/home_page.dart';
import 'ui/restaurant_detail_page.dart';
import 'ui/splash_page.dart';
import 'utils/background_service.dart';
import 'utils/notification_helper.dart';
import 'utils/preference_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => RestaurantProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider(create: (_) => SchedulingProvider()),
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
          ),
        ],
        child:
            Consumer<PreferencesProvider>(builder: (context, provider, child) {
          return MaterialApp(
            title: 'Restaurants App',
            debugShowCheckedModeBanner: false,
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            initialRoute: SplashPage.routeName,
            navigatorKey: navigatorKey,
            routes: {
              SplashPage.routeName: (context) => SplashPage(),
              HomePage.routeName: (context) => HomePage(),
              RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                    restaurants: ModalRoute.of(context).settings.arguments,
                  ),
            },
          );
        }));
  }
}
