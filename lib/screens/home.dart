// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_app/Models/news_model.dart';
import 'package:news_app/screens/details.dart';
import 'package:news_app/screens/favorite.dart';
import 'package:news_app/shared/categories.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:news_app/widgets/contentWidget.dart';
import 'package:provider/provider.dart';
import '../Provider/change_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //NewsApi allArticals = NewsApi();
  
  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final newsInstance = Provider.of<NewsViewModle>(context, listen: false);
    final classInstance = Provider.of<ChangeTheme>(
      context,
      listen: false
    );
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          "MH News",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "font3",
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              classInstance.changeTheme();
            });
          },
          icon: const Icon(
            Icons.sunny,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritePage()),
                );
              },
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.black,
              )),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: FutureBuilder<List<NewsModel>>(
        future: newsInstance.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            newsInstance.newsViewModel = snapshot.data as List<NewsModel>;
            return Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(
                //       top: 15, left: 30, right: 30, bottom: 20),
                //   child: TextField(
                //       controller: _searchWord,
                //       //  onChanged: _runFilter(searchKeyWord: _searchWord.text),
                //       obscureText: false,
                //       keyboardType: TextInputType.emailAddress,
                //       decoration: decorationtextFiled.copyWith(
                //         hintText: "Search",
                //         hintStyle: const TextStyle(fontFamily: "font3"),
                //         suffixIcon: IconButton(
                //           icon: Icon(Icons.search),
                //           onPressed: () {
                //           },
                //         ),
                //       )),
                // ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 45,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: widthScreen * 0.1,
                      ),
                      CategoriesWidget(
                        typeNews: 'BBC News',
                      ),
                      CategoriesWidget(
                        typeNews: 'Sport',
                      ),
                      CategoriesWidget(
                        typeNews: 'Entertiment',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Generated code for this topSearchBar Widget...
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    child: AnimationLimiter(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                        ),
                        itemCount: newsInstance.newsViewModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 1,
                              duration: const Duration(milliseconds: 700),
                              child: SlideAnimation(
                                verticalOffset: 100,
                                child: FadeInAnimation(
                                  curve: Curves.bounceInOut,
                                  delay: const Duration(microseconds: 1000),
                                  child: snapshot.hasData
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsPage(
                                                        allArticalsFromOtherPage:
                                                            newsInstance
                                                                    .newsViewModel[
                                                                index],
                                                      )),
                                            );
                                          },
                                          child: ContentWidget(
                                            title: newsInstance
                                                .newsViewModel[index].title
                                                .toString(),
                                            decription: newsInstance
                                                .newsViewModel[index]
                                                .description
                                                .toString(),
                                            imgurl: newsInstance
                                                .newsViewModel[index].urlToImage
                                                .toString(),
                                            date: newsInstance
                                                .newsViewModel[index]
                                                .publishedAt
                                                .toString()
                                                .toString(),
                                            author: newsInstance
                                                .newsViewModel[index].author
                                                .toString(),
                                          ),
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.redAccent),
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            );
          }
        },
      ),
    );
  }
}
