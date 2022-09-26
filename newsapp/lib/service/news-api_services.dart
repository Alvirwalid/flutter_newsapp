import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/service/news_api_model.dart';

class NewsApiServices {
  static Future<List<Article>> getAllnews(
      {required int page, required String sortBy}) async {
    List<Article> newsList = [];
    try {
      var link =
          'https://newsapi.org/v2/everything?q=bitcoin&apiKey=e9ab60c2f2774f849c64f81681dd6dfa&pageSize=10&page=$page&sortBy=$sortBy';

      var respons = await http.get(Uri.parse(link));

      print('data are :  ${respons.body}');

      var data = jsonDecode(respons.body);

      Article articles;
      for (var i in data['articles']) {
        // articles = Articles.fromJson(i);
        newsList.add(Article.fromJson(i));
      }
    } catch (e) {
      print('$e');
    }
    print('lenght is ${newsList.length}');
    return newsList;
  }

  static Future<List<Article>> getSearchdata({required String search}) async {
    List<Article> searchList = [];

    try {
      var link =
          'https://newsapi.org/v2/everything?q=$search&apiKey=e9ab60c2f2774f849c64f81681dd6dfa&pageSize=10';

      var respons = await http.get(Uri.parse(link));
      print(respons.body);

      var data = jsonDecode(respons.body);

      for (var i in data['articles']) {
        // articles = Articles.fromJson(i);
        searchList.add(Article.fromJson(i));
      }
    } catch (e) {
      print('$e');
    }
    return searchList;
  }
}
