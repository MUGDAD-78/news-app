// ignore_for_file: body_might_complete_normally_nullable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_app/Provider/add_to_favorite.dart';
import 'package:news_app/constant/alert_dilog.dart';
import 'package:news_app/screens/details.dart';
import 'package:news_app/widgets/contentWidget.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          "Favorite",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "font3",
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
        ),
      ),
      body: favoriteProvider.favoriteNews.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: AnimationLimiter(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      ),
                      itemCount: favoriteProvider.favoriteNews.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 1,
                          duration: const Duration(milliseconds: 700),
                          child: SlideAnimation(
                            verticalOffset: 100,
                            child: FadeInAnimation(
                              curve: Curves.bounceInOut,
                              delay: const Duration(microseconds: 1000),
                              child: GestureDetector(
                                onTap: () {
                                  if (favoriteProvider.favoriteNews.isEmpty) {
                                    showAlertDilog(
                                        context, "This Item has been deleted");
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsPage(
                                                allArticalsFromOtherPage:
                                                    favoriteProvider
                                                        .favoriteNews[index],
                                              )),
                                    );
                                  }
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: ContentWidget(
                                        title: favoriteProvider
                                            .favoriteNews[index].title,
                                        decription: favoriteProvider
                                            .favoriteNews[index].description,
                                        imgurl: favoriteProvider
                                            .favoriteNews[index].urlToImage,
                                        author: favoriteProvider
                                            .favoriteNews[index].author,
                                        date: favoriteProvider
                                            .favoriteNews[index].publishedAt,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              favoriteProvider
                                                  .removeFromFavorite(
                                                      favoriteProvider
                                                          .favoriteNews[index]);
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.delete_outline_rounded)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: Text(
                "No Fovorites ",
                style: TextStyle(fontFamily: 'font3', fontSize: 20),
              ),
            ),
    );
  }
}
