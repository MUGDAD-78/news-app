// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Provider/add_to_favorite.dart';
import 'package:news_app/Provider/change_theme.dart';
import 'package:news_app/constant/alert_dilog.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/screens/signin.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'shared/navigator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          child: const MyApp(),
          create: (context) {
            return FavoriteProvider();
          },
        ),
        ChangeNotifierProvider(
          child: const MyApp(),
          create: (context) {
            return ChangeTheme();
          },
        ),
            ChangeNotifierProvider(
          child: const MyApp(),
          create: (context) {
            return NewsViewModle();
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

Future init(BuildContext context) async {
  await Future.delayed(Duration(seconds: 5));
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else if (snapshot.hasError) {
            return showAlertDilog(context, "Something went wrong");
          } else if (snapshot.hasData) {
            return TheNavigator();
          } else {
            return SigninPage();
          }
        },
      ),
      theme: Provider.of<ChangeTheme>(context).themeData,
    );
  }
}
//if ( )  {
//  }  