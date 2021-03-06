import 'package:flutter/material.dart';
import 'package:flutter_dicoding/widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatelessWidget {
  static const routeName = '/article_web';

  final String url;

  const NewsWebView({@required this.url});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
