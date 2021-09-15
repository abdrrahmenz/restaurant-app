import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash_page';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigatesToLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Center(child: Image.asset('assets/rest.png')),
        ],
      ),
    );
  }

  navigatesToLogin() async {
    Navigation.intentAndRemove(HomePage.routeName);
  }
}
