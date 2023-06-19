import 'package:flutter/material.dart';
import 'package:hitchhop/constants.dart';
import 'package:hitchhop/screens/mapSample.dart';
import 'package:hitchhop/widgets/availableCarsScreen/rideTypeTile.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  // void giveOnTap(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => MapSample()),
  //   );
  // }
  //
  // void takeOnTap(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => MapSample()),
  //   );
  // }

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
