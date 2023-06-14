import 'package:flutter/material.dart';
import 'package:hitchhop/screens/availableCarsScreen.dart';
import 'package:hitchhop/screens/homeScreen.dart';
import 'package:hitchhop/screens/loginScreen.dart';
import 'package:hitchhop/screens/profileScreen.dart';
import 'package:hitchhop/screens/signup_screen.dart';
import 'constants.dart';
import 'package:hitchhop/screens/signupScreen.dart';

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
      initialRoute: signupScreen,
      routes: {
        signupScreen: (_) => SignupScreenTwo(),
        loginScreen: (_) => LoginScreen(),
        profileScreen: (_) => ProfileScreen(),
        homeScreen: (_) => HomeScreen(),
        availableCarsScreen: (_) => AvailableCarScreen(),
      },
    );
  }
}