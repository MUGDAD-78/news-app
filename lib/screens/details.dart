// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/news_model.dart';
import 'package:news_app/Provider/add_to_favorite.dart';
import 'package:news_app/Provider/change_theme.dart';
import 'package:news_app/constant/alert_dilog.dart';
import 'package:news_app/constant/themes.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  NewsModel allArticalsFromOtherPage;
  DetailsPage({required this.allArticalsFromOtherPage, super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool showTitle = true;
  @override
  Widget build(BuildContext context) {
    final classInstance = Provider.of<ChangeTheme>(context, listen: false);

    var favoriteProviderObject =
        Provider.of<FavoriteProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'font3',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.allArticalsFromOtherPage.urlToImage,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  DateFormat.yMd().add_jm().format(DateTime.parse(
                      widget.allArticalsFromOtherPage.publishedAt)),
                  style: TextStyle(fontFamily: "font3", color:  classInstance.themeData == lightTheme
                          ? Colors.black
                          : Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.allArticalsFromOtherPage.title,
                style: TextStyle(
                    fontFamily: "font3", color: classInstance.themeData == lightTheme
                          ? Colors.black
                          : Colors.white, fontSize: 25),
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 0.4,
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Text(
                widget.allArticalsFromOtherPage.content,
                maxLines: showTitle ? 2 : null,
                overflow: TextOverflow.fade,
                style: TextStyle(fontFamily: 'font3', fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (showTitle == true) {
                    showTitle = false;
                  } else {
                    showTitle = true;
                  }
                });
              },
              child: Text(showTitle ? "Show More" : "Show less",
                  style: TextStyle(
                      fontFamily: "font3",
                      fontSize: 17,
                      color: classInstance.themeData == lightTheme
                          ? Colors.black
                          : Colors.white)),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: ElevatedButton(
                  onPressed: () {
                    favoriteProviderObject
                        .addToFavorite(widget.allArticalsFromOtherPage);
                    showAlertDilog(context, "News added to favorite ❤️");
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                  ),
                  child:  Text(
                    "Add To Favorite",
                    style: TextStyle(fontSize: 19 , color: classInstance.themeData == lightTheme
                          ? Colors.black
                          : Colors.white),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
