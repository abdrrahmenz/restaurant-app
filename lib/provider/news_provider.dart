
import 'package:flutter/material.dart';
import 'package:flutter_dicoding/common/result_state.dart';
import 'package:flutter_dicoding/data/api/api_service.dart';
import 'package:flutter_dicoding/data/model/article.dart';
 
class NewsProvider extends ChangeNotifier {
  final ApiService apiService;
 
  NewsProvider({@required this.apiService}) {
    _fetchAllArticle();
  }
 
  ArticlesResult _articlesResult;
  String _message = '';
  ResultState _state;
 
  String get message => _message;
 
  ArticlesResult get result => _articlesResult;
 
  ResultState get state => _state;
 
  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final article = await apiService.topHeadlines();
      if (article.articles.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _articlesResult = article;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}