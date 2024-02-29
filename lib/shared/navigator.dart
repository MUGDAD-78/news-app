// ignore_for_file: prefer_const_constructors, unused_field, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/screens/home.dart';
import 'package:news_app/screens/profile.dart';

class TheNavigator extends StatefulWidget {
  const TheNavigator({super.key});

  @override
  State<TheNavigator> createState() => _TheNavigatorState();
}

class _TheNavigatorState extends State<TheNavigator> {
  final PageController _pageController = PageController();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  int _selectedIndex = 0;
  final List<Widget> _screen = [
    HomeScreen(),
    ProfileScreen(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: _screen,
      ),
      bottomNavigationBar: _connectionStatus.name == 'none'
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/img/no_internet.jpg'),
                Text(
                  "No Internet available",
                  style: TextStyle(fontFamily: 'font3', fontSize: 20),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(25.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: GNav(
                    backgroundColor: Colors.redAccent,
                    onTabChange: (value) {
                      _pageController.jumpToPage(value);

                      setState(() {
                        _selectedIndex = value;
                      });
                    },
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    gap: 10,
                    tabBackgroundColor: Color.fromARGB(41, 255, 255, 255),
                    tabs: [
                      GButton(
                        icon: Icons.home_filled,
                        hoverColor: Colors.white,
                        text: "Home",
                        textColor:
                            _selectedIndex == 0 ? Colors.white : Colors.black,
                      ),
                      GButton(
                        icon: Icons.person,
                        hoverColor: Colors.white,
                        text: "profile",
                        textColor:
                            _selectedIndex == 1 ? Colors.white : Colors.black,
                      ),
                    ]),
              ),
            ),
    );
  }
}
