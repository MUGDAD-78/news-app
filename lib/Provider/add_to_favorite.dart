import 'package:flutter/material.dart';
import 'package:news_app/Models/news_model.dart';

class FavoriteProvider extends ChangeNotifier {
  List<NewsModel> favoriteNews = [];

  addToFavorite(value) {
    favoriteNews.add(value);
  }

  removeFromFavorite(value) {
    favoriteNews.remove(value);
  }
}
