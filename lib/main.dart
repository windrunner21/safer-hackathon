import 'package:flutter/material.dart';
import 'package:safer_hackathon/local_notification.dart';
import 'package:safer_hackathon/ui/landing-page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:workmanager/workmanager.dart';

// void callbackDispatcher() {
//   Workmanager.executeTask((taskName, inputData) {
//     LocalNotification.Initializer();
//     LocalNotification.ShowOneTimeNotification(DateTime.now());

//     //Return true when the task executed successfully or not
//     return Future.value(true);
//   });
// }
void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    switch (task) {
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
        break;
    }
    bool success = true;
    return Future.value(success);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(callbackDispatcher);
  //Workmanager.registerOneOffTask("1", "firebaseSyncing");
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
