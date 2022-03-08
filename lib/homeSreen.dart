// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<QuerySnapshot>? subscription;
  List<DocumentSnapshot> snapshot = [];
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((data) {
      setState(() {
        snapshot = data.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: snapshot.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                // margin: EdgeInsets.all(10),
                elevation: 3,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  CircleAvatar(
                    // child: Text('${loggedInUser.title}'),
                    child: Text(snapshot[index]['title'][0]),
                  ),
                  SizedBox(
                    height: 10,
                    width: 10.0,
                  ),
                  Column(
                    children: [
                      Text(
                        snapshot[index]['title'],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.teal),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot[index]['content'],
                        style: TextStyle(fontSize: 15),
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ]),
              ));
        },
      ),
    );
  }
}
