import 'package:flutter/material.dart';
import 'package:flutter_dicoding/common/navigation.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  CustomScaffold({this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            body,
            _buildShortAppBar(context),
          ],
        ),
      ),
    );
  }

  Card _buildShortAppBar(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigation.back();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'N',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
