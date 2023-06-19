import 'package:flutter/material.dart';
import 'package:hitchhop/screens/availableCarsScreen.dart';
import 'package:hitchhop/screens/profileScreen.dart';
import 'package:hitchhop/screens/trackRide.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class SwipeToContinue extends StatelessWidget {
  const SwipeToContinue({Key? key, required this.type}) : super(key: key);

  final String type;

  void confirmed(BuildContext context) {
    if (type == 'take') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AvailableCarsScreen()),
      );
    } else {
      // Todo: Change to correct screen

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TrackRide()),
      );
    }
  }

  Widget build(BuildContext context) {
    return ConfirmationSlider(
      onConfirmation: () => confirmed(context),
      foregroundColor: Colors.lightGreen,
      textStyle: const TextStyle(
          color: Colors.black54, fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }
}
