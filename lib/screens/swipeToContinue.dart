import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hitchhop/screens/availableCarsScreen.dart';
import 'package:hitchhop/screens/profileScreen.dart';
import 'package:hitchhop/screens/trackRide.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:http/http.dart' as http;


class SwipeToContinue extends StatelessWidget {
  const SwipeToContinue({Key? key, required this.type}) : super(key: key);

  final String type;

  void confirmed(BuildContext context)async {
    if (type == 'take') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AvailableCarsScreen()),
      );
    } else {
      // @TODO @sarthak - fill appropriate data here
      var reqBody = {
        "userId": "648f01fa967b0c4215a5d1a1",
        "source": {
          "lat": 28.6562484958429,
          "lng": 77.24075317382812,
          "place": "Source String"
        },
        "destination": {
          "lat": 28.116610865104626,
          "lng": 77.2692718132267,
          "place": "Destination String"
        },
        "dateTime": "2023-06-16T19:30:00.535+00:00",
        "max_riders":2
      };
      // @TODO- @sarthak add path in global strings /trip/drive

      // var response = await http.post(Uri.parse("path"),
      //     headers: {"Content-Type": "application/json"},
      //     body: jsonEncode(reqBody));
      //
      // var jsonResponse = jsonDecode(response.body);
      // print('RESPONSE ${jsonResponse}');
      //
      // final user = jsonResponse['user'];
      // if (jsonResponse['success']) {}
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
