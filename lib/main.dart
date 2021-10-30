// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Now create flutter instance

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // property future
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("You have an error congifguration");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(),
              debugShowCheckedModeBanner: false,
              home: HomePage(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
