import 'package:flutter/cupertino.dart';
import 'package:newsapp/service/news-api_services.dart';
import 'package:newsapp/service/news_api_model.dart';

class NewsProvider with ChangeNotifier {
  List<Article> newsList = [];
  List<Article> searchList = [];

  Future<List<Article>> getnewsData(
      {required int page, required String sortBy}) async {
    newsList = await NewsApiServices.getAllnews(page: page, sortBy: sortBy);

    return newsList;
  }

  Article findByDate({required String date}) {
    var data = newsList.firstWhere((element) => element.publishedAt == date);

    return data;
  }

  Future<List<Article>> getDataBySearch({required String search}) async {
    searchList = await NewsApiServices.getSearchdata(search: search);
    notifyListeners();
    return searchList;
  }
}
