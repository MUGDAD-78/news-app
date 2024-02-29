// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userData = {};
  bool isLoading = false;
  //Get Data From Firebase
  getDataFromDB() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Userinfo')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = snapshot.data()!;
      setState(() {
        isLoading = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getDataFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                setState(() {
                  FirebaseAuth.instance.signOut();
                });
              },
              icon: const Icon(Icons.logout_outlined)),
          backgroundColor: Colors.redAccent,
          title: const Text(
            "Profile",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "font3",
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: isLoading
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        userData['Email'],
                        style:
                            const TextStyle(fontFamily: 'font3', fontSize: 17),
                      ),
                      leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: Colors.redAccent),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: const Icon(Icons.email_rounded)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        userData['Password'],
                        style:
                            const TextStyle(fontFamily: 'font3', fontSize: 17),
                      ),
                      leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: Colors.redAccent),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: const Icon(Icons.lock)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        userData['UserName'],
                        style:
                            const TextStyle(fontFamily: 'font3', fontSize: 17),
                      ),
                      leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: Colors.redAccent),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: const Icon(Icons.person_2_rounded)),
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator(color: Colors.redAccent,)));
  }
}
