import 'package:flutter/material.dart';
import 'package:news_app/Models/news_model.dart';
import 'package:news_app/Services/news_api.dart';

class NewsViewModle extends ChangeNotifier {
  List<NewsModel> newsViewModel = [];

  Future<List<NewsModel>> fetchData() async {
    newsViewModel = await NewsApi().getNews();

    notifyListeners();
    return newsViewModel;
  }
}
