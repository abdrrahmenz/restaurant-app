import 'package:flutter/material.dart';
import 'package:flutter_dicoding/common/navigation.dart';
import 'package:flutter_dicoding/data/model/article.dart';
import 'package:flutter_dicoding/page/news_detail.dart';
import 'package:flutter_dicoding/provider/database_provider.dart';
import 'package:provider/provider.dart';

class CardArticle extends StatelessWidget {
  final Article article;
 
  const CardArticle({Key key, @required this.article})
     : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(article.url),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: article.urlToImage == null
                    ? Container(width: 100, child: Icon(Icons.error))
                    : Hero(
                        tag: article.urlToImage,
                        child: Image.network(
                          article.urlToImage,
                          width: 100,
                        ),
                      ),
                title: Text(
                  article.title ?? "",
                ),
                subtitle: Text(article.author ?? ""),
                trailing: isBookmarked
                    ? IconButton(
                        icon: Icon(Icons.bookmark),
                        onPressed: () => provider.removeBookmark(article.url),
                      )
                    : IconButton(
                        icon: Icon(Icons.bookmark_border),
                        onPressed: () => provider.addBookmark(article),
                      ),
                onTap: () => Navigation.intentWithData(NewsDetailPage.routeName, article),
              ),
            );
          },
        );
      },
    );
  }
}