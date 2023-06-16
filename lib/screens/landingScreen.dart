import 'package:flutter/material.dart';
import 'package:hitchhop/constants.dart';
import 'package:hitchhop/widgets/homeScreen/rideTypeTile.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RideTypeTile(imageUrl: loginImage, text: 'Give Ride'),
            RideTypeTile(imageUrl: loginImage, text: 'Take Ride'),
          ],
        ),
      ),
    );
  }
}
