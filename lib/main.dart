import 'package:flutter/material.dart';
import 'package:hitchhop/screens/bottomNavBar.dart';
import 'package:hitchhop/screens/availableCarsScreen.dart';
import 'package:hitchhop/screens/landingScreen.dart';
import 'package:hitchhop/screens/loginScreen.dart';
import 'package:hitchhop/screens/mapSample.dart';
import 'package:hitchhop/screens/myRidesScreen.dart';
import 'package:hitchhop/screens/profileScreen.dart';
import 'package:hitchhop/screens/signupScreen.dart';
import 'package:hitchhop/screens/swipeToContinue.dart';
import 'package:hitchhop/screens/trackRide.dart';
import 'constants.dart';

// TODO: https://www.figma.com/community/file/1241766699896445351/Rideshare---Ride-Mobile--App-UI-kit
// TODO: https://www.figma.com/community/file/1205067432626853876/CarPal-the-carpooling-app

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HitchHop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: availableCarsScreen,
      // home: MapSample(type: 'give'),
      routes: {
        signupScreen: (_) => SignupScreen(),
        loginScreen: (_) => LoginScreen(),
        profileScreen: (_) => ProfileScreen(),
        landingScreen: (_) => LandingScreen(),
        // homeScreen: (_) => HomeScreen(),
        availableCarsScreen: (_) => AvailableCarsScreen(),
        // mapSample: (_) => MapSample(),
      },
    );
  }
}
