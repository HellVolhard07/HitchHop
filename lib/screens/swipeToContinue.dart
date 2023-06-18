import 'package:flutter/material.dart';
import 'package:hitchhop/screens/availableCarsScreen.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class SwipeToContinue extends StatelessWidget {
  const SwipeToContinue({Key? key}) : super(key: key);

  void confirmed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AvailableCarsScreen()),
    );
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
