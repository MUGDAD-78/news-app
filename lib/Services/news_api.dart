// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/artical_model.dart';
import 'package:news_app/Models/news_model.dart';
import 'package:news_app/constant/alert_dilog.dart';

class NewsApi {
  var apiUrl =
      "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=4e76508ae2b6414a838b71ba6187372a#";

  List<NewsModel> newsList = [];
  Future<List<NewsModel>> getNews([context]) async {
    var url = Uri.parse(apiUrl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);

        ArticleModel articalModel = ArticleModel.fromJson(jsonData);
        newsList =
            articalModel.articals.map((e) => NewsModel.fromJson(e)).toList();
      } else {
        showAlertDilog(context, "Error : Please check your internet status");
      }
    } catch (e) {
      print(e);
    }

    return newsList;
  }
}
