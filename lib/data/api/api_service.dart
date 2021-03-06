import 'dart:convert';
import 'package:flutter_dicoding/data/model/article.dart';
import 'package:http/http.dart' as http;

class ApiService {
 static final String _baseUrl = 'https://newsapi.org/v2/';
 static final String _apiKey = '202ce898a6a04a8f95f0d853a1e51558';
 static final String _category = 'business';
 static final String _country = 'id';
 
 Future<ArticlesResult> topHeadlines() async {
   final response = await http.get(_baseUrl +
       "top-headlines?country=$_country&category=$_category&apiKey=$_apiKey");
   if (response.statusCode == 200) {
     return ArticlesResult.fromJson(json.decode(response.body));
   } else {
     throw Exception('Failed to load top headlines');
   }
 }
}