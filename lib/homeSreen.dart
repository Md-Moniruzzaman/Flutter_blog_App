// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';
import 'package:blog_app/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot> _userStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  // StreamSubscription<QuerySnapshot>? subscription;
  // List<DocumentSnapshot>? snapshot = [];
  // CollectionReference collectionReference =
  //     FirebaseFirestore.instance.collection('users');

  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance.collection('users').doc().get().then((value) {
  //     loggedInUser = UserModel.fromMap(value.data());
  //   });
  //   setState(() {});
  // }
  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _userStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.teal,
              )),
            );
          }

          final List storedoc = [];
          // Map<String, dynamic> data = {};
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            storedoc.add(data);
          }).toString();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Blog App'),
            ),
            drawer: Drawer(
              child: ListView(padding: EdgeInsets.zero, children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  leading: const Icon(Icons.pageview_rounded),
                  title: const Text('item 1'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('item 2'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('item 3'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('item 4'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('item 5'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(
                  color: Colors.redAccent, //color of divider
                  height: 5, //height spacing of divider
                  // thickness: 3, //thickness of divier line
                  indent: 5, //spacing at the start of divider
                  endIndent: 25,
                ),
                ListTile(
                  title: const Text('close'),
                  trailing: const Icon(Icons.close),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ), //spacing at the end of divider)
              ]),
            ),
            body: ListView(padding: EdgeInsets.all(10), children: [
              for (int i = 0; i < storedoc.length; i++) ...[
                Card(
                  // margin: EdgeInsets.all(10),
                  elevation: 3,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          // child: Text('${loggedInUser.title}'),
                          child: Text(storedoc[i]['title'][0]),
                        ),
                        SizedBox(
                          height: 10,
                          width: 10.0,
                        ),
                        Column(
                          children: [
                            Text(
                              storedoc[i]['title'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.teal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              storedoc[i]['content'],
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      ]),
                ),
              ],
            ]),
          );
        });
  }
}
