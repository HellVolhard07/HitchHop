import 'package:flutter/material.dart';
import 'package:hitchhop/constants.dart';
import 'package:hitchhop/screens/mapSample.dart';
import 'package:hitchhop/widgets/availableCarsScreen/rideTypeTile.dart';
import 'package:permission_handler/permission_handler.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://localsearchforum.com/attachments/googlemaps_error-jpg.1109/'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RideTypeTile(
                  imageUrl: giveRideImage, text: 'Give Ride', type: 'give'),
              RideTypeTile(
                  imageUrl: takeRideImage, text: 'Take Ride', type: 'take'),
            ],
          ),
        ),
      ),
    );
  }
}
