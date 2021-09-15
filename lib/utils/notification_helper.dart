import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/model/restaurant_list_result.dart';

final selectNotificationSubject = BehaviorSubject<String>();
 
class NotificationHelper {
  static NotificationHelper _instance;
 
  NotificationHelper._internal() {
    _instance = this;
  }
 
  factory NotificationHelper() => _instance ?? NotificationHelper._internal();
 
  Future<void> initNotifications(
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
 
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
 
    var initializationSettings = InitializationSettings(
       initializationSettingsAndroid, initializationSettingsIOS);
 
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
       onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    });
  }
 
  Future<void> showNotification(
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
     RestaurantListResult restaurant) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "restaurant channel"; 
 
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));
 
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
 
    var titleNotification = "<b>Restaurant Terbaru</b>";
    var titleNews = restaurant.restaurants[0].name;
 
    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(restaurant.toJson()));
  }
 
  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantListResult.fromJson(json.decode(payload));
        var article = data.restaurants[0];
        Navigation.intentWithData(route, article);
      },
    );
  }
}