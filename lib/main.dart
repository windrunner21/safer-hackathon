import 'package:flutter/material.dart';
import 'package:safer_hackathon/ui/landing-page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.baiJamjureeTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: FutureBuilder(
          // Initialize FlutterFire
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              print('error occured');
            }
            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return LandingPage();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
