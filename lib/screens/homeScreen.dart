import 'package:flutter/material.dart';
import 'package:hitchhop/widgets/homeScreen/rideTypeTile.dart';
import 'package:hitchhop/widgets/selectCarTile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // RideTypeTile(imageUrl: 'imageUrl', text: 'Take Ride'),
              // RideTypeTile(imageUrl: 'imageUrl', text: 'Give Ride'),
SelectCarTile()
            ],
          ),
        ),
      ),
    );
  }
}
