import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding/common/result_state.dart';
import 'package:flutter_dicoding/provider/news_provider.dart';
import 'package:flutter_dicoding/widgets/card_article.dart';
import 'package:flutter_dicoding/widgets/platform_widgets.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
   Widget _buildList(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.articles.length,
            itemBuilder: (context, index) {
              var article = state.result.articles[index];
              return CardArticle(
                article: article,
              );
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }
//   @oveaprridepro
//   _NewsListPageState createState() => _NewsListPageState();
// }

// class _NewsListPageState extends State<NewsListPage> {
//   Future<ArticlesResult> _article;

//   @override
//   void initState() {
//     _article = ApiService().topHeadlines();
//     super.initState();
//   }

//   Widget _buildList(BuildContext context) {
//   return FutureBuilder(
//     future: _article,
//     builder: (context, AsyncSnapshot<ArticlesResult> snapshot) {
//       var state = snapshot.connectionState;
//       if (state != ConnectionState.done) {
//         return Center(child: CircularProgressIndicator());
//       } else {
//         if (snapshot.hasData) {
//           return ListView.builder(
//             shrinkWrap: true,
//             itemCount: snapshot.data.articles.length,
//             itemBuilder: (context, index) {
//               var article = snapshot.data.articles[index];
//               return CardArticle(
//                 article: article,
//                 onPressed: () => Navigator.pushNamed(
//                   context,
//                   NewsDetailPage.routeName,
//                   arguments: article,
//                 ),
//               );
//             },
//           );
//         } else if (snapshot.hasError) {
//           return Center(child: Text(snapshot.error.toString()));
//         } else {
//           return Text('');
//         }
//       }
//     },
//   );
// }

  // Widget _buildArticleItem(BuildContext context, Article article) {
  //   return Material(
  //     color: primaryColor,
  //     child: ListTile(
  //       contentPadding:
  //           const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //       leading: Hero(
  //         tag: article.urlToImage,
  //         child: Image.network(
  //           article.urlToImage,
  //           width: 100,
  //         ),
  //       ),
  //       title: Text(
  //         article.title,
  //       ),
  //       subtitle: Text(article.author),
  //       onTap: () {
  //         Navigator.pushNamed(context, NewsDetailPage.routeName,
  //             arguments: article);
  //       },
  //     ),
  //   );
  // }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
