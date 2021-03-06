import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding/page/news_webview.dart';
import 'package:flutter_dicoding/utils/background_service.dart';
import 'package:flutter_dicoding/utils/notification_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/navigation.dart';
import 'data/api/api_service.dart';
import 'data/db/database_helper.dart';
import 'page/home.dart';
import 'page/news_detail.dart';
import 'provider/database_provider.dart';
import 'provider/news_provider.dart';
import 'provider/preferences_provider.dart';
import 'provider/scheduling_provider.dart';
import 'utils/preferences_helper.dart';

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
          create: (_) => NewsProvider(apiService: ApiService()),
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
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'News App',
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
            navigatorKey: navigatorKey,
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => HomePage(),
              NewsDetailPage.routeName: (context) => NewsDetailPage(
                    article: ModalRoute.of(context).settings.arguments,
                  ),
              NewsWebView.routeName: (context) => NewsWebView(
                    url: ModalRoute.of(context).settings.arguments,
                  ),
            },
          );
        },
      ),
    );
  }
}
